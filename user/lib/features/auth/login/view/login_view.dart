import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend_user/core/constant/app_color.dart';
import 'package:frontend_user/core/constant/app_image_asset.dart';
import 'package:frontend_user/core/constant/app_svg_asset.dart';
import 'package:frontend_user/core/function/alert_exit_app.dart';
import 'package:frontend_user/core/shared/custom_logo.dart';
import 'package:frontend_user/features/auth/login/bloc/login_bloc.dart';
import 'package:frontend_user/features/auth/widgets/custom_divider.dart';
import 'package:frontend_user/features/auth/widgets/phone_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // متحكم النص لاستخراج رقم الهاتف المخزن بالحقل
  final TextEditingController phoneController = TextEditingController();
  // مراقب تركيز حقل الهاتف
  final FocusNode phoneFocusNode = FocusNode();

  @override
  void initState() {
    phoneFocusNode.addListener(() {
      setState(() {}); // إعادة بناء الواجهة لإظهار/إخفاء زر التأكيد
    });
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (phoneFocusNode.hasFocus) {
          FocusScope.of(context).unfocus();
        } else {
          alertExitApp(context); // إظهار تنبيه الخروج من التطبيق
        }
      },
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          state.whenOrNull(
            // عند نجاح إرسال الرمز التوجيه لشاشة الـ OTP
            otpSent: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("تم إرسال الرمز بنجاح")));
              // Navigator.pushNamed(context, AppRoute.verifyOtp, arguments: phoneController.text);
            },
            // عند نجاح تسجيل الدخول بالكامل (مثل تسجيل الدخول بقوقل)
            success: () {
              // Navigator.pushReplacementNamed(context, AppRoute.home);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("تم تسجيل الدخول في قوقل بنجاح")),
              );
            },
            // عند حدوث خطأ إظهار شريط تنبيه للمستخدم
            failure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            },
          );
        },
        builder: (context, state) {
          // الاستعلام عن حالة التحميل الحالية لتمريرها لعناصر الواجهة
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return Scaffold(
            backgroundColor: AppColor.bgColorOnBoarding,
            bottomNavigationBar: AnimatedPadding(
              duration: const Duration(
                milliseconds: 100,
              ), // سرعة الاستجابة لصعود الكيبورد
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(
                  context,
                ).viewInsets.bottom, // ارتفاع الكيبورد الحالي
              ),
              child: Container(
                padding: const EdgeInsets.all(15), // حواشي داخلية
                decoration: const BoxDecoration(
                  color: Colors.white, // لون الخلفية
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      30,
                    ), // استدارة الزاوية العلوية اليسرى
                    topRight: Radius.circular(
                      30,
                    ), // استدارة الزاوية العلوية اليمنى
                  ),
                ),
                height: screenWidth * 0.60, // ارتفاع القائمة
                child: ListView(
                  children: [
                    // حقل الهاتف مع تمرير الـ FocusNode والمتحكم
                    PhoneField(
                      controller: phoneController,
                      focusNode:
                          phoneFocusNode, // ربط حقل الهاتف بمتغير التركيز
                      invalidMessage: "يجب أن يكون 10 أرقام", // رسالة الخطأ
                    ),

                    const SizedBox(height: 15),

                    // فحص حالة التركيز على الحقل
                    if (phoneFocusNode.hasFocus) ...[
                      // زر التأكيد عند تفعيل الحقل
                      ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                FocusScope.of(context).unfocus();
                                // إرسال حدث طلب رمز OTP مع رقم الهاتف المدخل
                                context.read<LoginBloc>().add(
                                  LoginEvent.sendOtp(phoneController.text),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // لون الزر
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ), // حواشي الزر الداخلية
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20,
                            ), // استدارة الحواف
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "تأكيد", // نص الزر
                                style: TextStyle(
                                  color: Colors.white, // لون النص
                                  fontSize: 16, // حجم الخط
                                ),
                              ),
                      ),
                    ] else ...[
                      // الخيارات الافتراضية عند عدم تفعيل الحقل
                      const CustomDivider(title: "أو"), // الفاصل

                      const SizedBox(height: 15), // مسافة رأسية
                      // زر تسجيل الدخول عبر حساب Google
                      InkWell(
                        onTap: isLoading
                            ? null
                            : () {
                                context.read<LoginBloc>().add(
                                  const LoginEvent.loginWithGoogle(),
                                );
                              },
                        child: Container(
                          padding: const EdgeInsets.all(10), // حواشي داخلية
                          width: double.infinity, // كامل العرض
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ), // حدود الزر
                            borderRadius: BorderRadius.circular(
                              20,
                            ), // استدارة الحدود
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // محاذاة النص في المنتصف
                            children: [
                              if (isLoading)
                                const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                    strokeWidth: 2,
                                  ),
                                )
                              else ...[
                                const Text("المتابعة بحساب "), // النص
                                SvgPicture.asset(
                                  AppSvgAsset.google, // أيقونة جوجل
                                  height: 20, // ارتفاع الأيقونة
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.broken_image,
                                      ), // البديل عند خطأ التحميل
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            body: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // شعار التطبيق المخصص
                  CustomLogo(
                    tagImage: "logo",
                    imageName: AppImageAsset.logo,
                    heightImage: screenWidth * 0.5,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
