// إدارة كل ما يتعلق بإشعارات الفايربيس والإشعارات المحلية
import 'dart:async';
import 'dart:convert';

import 'package:frontend_user/core/constant/app_route.dart';
import 'package:frontend_user/core/routes/app_route_observer.dart';
import 'package:frontend_user/core/services/app_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final _orderController = StreamController<void>.broadcast();
Stream<void> get onOrders => _orderController.stream;

class NotificationService {
  // // إنشاء كائن المكتبة الرئيسي
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // // 1. تهيئة المحركات فقط عند بداية التطبيق (بدون إزعاج المستخدم)
  static Future<void> initialize() async {
    // // تهيئة مكتبة الإشعارات المحلية
    await _initLocalNotification();

    // // الاستماع للإشعارات في الواجهة
    _listenToForegroundMessages();
  }

  // // 2. طلب الصلاحيات من المستخدم (تُستدعى في صفحة الهوم)
  static Future<void> requestPermissions() async {
    AppService appService = AppService();
    // استخدام nullable لتجنب الـ crash عند غياب الـ id
    int? usersId = appService.sharedPreferences.getInt('id');

    // // طلب صلاحيات الفايربيس
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // // الاشتراك في الـ Topic العام
    await FirebaseMessaging.instance.subscribeToTopic("users");
    // الاشتراك في الـ Topic الخاص بالمستخدم فقط إذا كان الـ id متوفراً
    if (usersId != null) {
      await FirebaseMessaging.instance.subscribeToTopic("users$usersId");
    }

    // // طلب صلاحية أندرويد 13+ للمكتبة المحلية
    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin != null) {
      await androidPlugin.requestNotificationsPermission();
    }
  }

  // 3. تهيئة مكتبة الإشعارات المحلية
  static Future<void> _initLocalNotification() async {
    // // تحديد أيقونة التطبيق الرسمية للإشعارات
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // // إعدادات iOS الافتراضية
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    // // إتمام عملية التهيئة (تمرير positional)
    await _notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        if (details.payload != null) {
          final data = jsonDecode(details.payload!) as Map<String, dynamic>;
          if (data['type'] == 'orders') {
            if (AppRouteObserver.currentRoute != AppRoute.ordersPending ||
                AppRouteObserver.currentRoute != AppRoute.ordersArchive) {
              _orderController.add(null);
            }
          }
        }
      },
    );
  }

  // 4. الاستماع للإشعارات والتطبيق مفتوح في الواجهة (Foreground)
  static void _listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      final data = message.data;

      // // إذا كان الإشعار يحتوي على عنوان وحمولة يتم إظهاره فوراً عبر المكتبة المحلية
      if (notification != null) {
        showNotification(
          id: notification.hashCode,
          title: notification.title ?? '',
          body: notification.body ?? '',
          payload: data.isNotEmpty
              ? jsonEncode(data)
              : null, // // تمرير البيانات للضغط لاحقاً
        );
      }

      // // تحديث صفحة الطلبات فور ظهور الإشعار (بدون الحاجة للضغط عليه)
      if (data['type'] == 'orders') {
        if (AppRouteObserver.currentRoute != AppRoute.ordersPending ||
            AppRouteObserver.currentRoute != AppRoute.ordersArchive) {
          _orderController.add(null);
        }
      }
    });
  }

  // 5. إعداد مستمعات الضغط على الإشعارات
  static Future<void> setupNotificationInteractions(
    BuildContext context,
  ) async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (context.mounted) {
        _handleNotificationClick(context, message);
      }
    });

    // // حالة: الضغط على الإشعار والتطبيق مغلق تماماً
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();

    if (initialMessage != null && context.mounted) {
      _handleNotificationClick(context, initialMessage);
    }
  }

  // 6. توجيه المستخدم بناءً على بيانات الإشعار
  static void _handleNotificationClick(
    BuildContext context,
    RemoteMessage message,
  ) {
    Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamedAndRemoveUntil(AppRoute.homeScreen, (route) => false);
  }

  // 7. دالة إظهار إشعار فوري باستخدام صوت وأيقونة الجهاز الافتراضية
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload, // // بيانات إضافية تُستخدم عند الضغط على الإشعار
  }) async {
    // // ضبط تفاصيل الإشعار وقناة أندرويد
    const AndroidNotificationDetails
    androidDetails = AndroidNotificationDetails(
      'main_channel_id', // // معرّف القناة (يجب أن يكون فريداً)
      'الإشعارات العامة', // // اسم القناة كما يظهر للمستخدم في إعدادات الهاتف
      channelDescription: 'قناة التنبيهات الرئيسية للتطبيق',
      importance: Importance.max, // // يضمن ظهور الإشعار المنبثق أعلى الشاشة
      priority: Priority.high,
      playSound: true, // // تفعيل صوت الجهاز الافتراضي
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    // // إرسال وإظهار الإشعار (تمرير positional)
    await _notificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
      payload: payload, // // تمرير الـ payload
    );
  }
}
