import 'package:frontend_user/data/static/app_text.dart';

Map<String, String> errorMessagesAr = {
  // Dialog Titles
  AppText.alert: "تنبيه",
  AppText.warning: "تحذير",
  AppText.exitMessage: "هل تريد الخروج من التطبيق؟",

  // General Dialog Messages
  AppText.messagewarningAlready: "حدث خطأ ما، يرجى المحاولة مرة أخرى لاحقًا",
  AppText.unexpectedError: "حدث خطأ غير متوقع",

  // Network Errors
  AppText.checkInternet: "تحقق من الاتصال بالإنترنت",

  // Backend Error Keys
  AppText.emailNotFoundOrNotApproved:
      "البريد الإلكتروني غير موجود أو الحساب غير مُفعل",
  AppText.passwordIncorrect: "كلمة المرور غير صحيحة",
  AppText.passwordsNotMatch: "كلمتا المرور غير متطابقتين",
  AppText.emailNotFound: "البريد الإلكتروني غير موجود",
  AppText.emailOrPhoneExists: "البريد الإلكتروني أو رقم الجوال مستخدم مسبقًا",
  AppText.verificationCodeIncorrect: "رمز التحقق غير صحيح",
  AppText.passwordsNotMatchDialog: "كلمتا المرور غير متطابقتين، أعد إدخالهما",
  AppText.accountNotActive: "حسابك غير مفعّل. هل ترغب في تفعيل حسابك الآن؟",
  AppText.noData: "لا توجد بيانات",

  // Buttons
  AppText.activateNow: "تفعيل الآن",
  AppText.cancel: "إلغاء",
  AppText.confirm: "موافق",
  AppText.delete: "حذف",
  AppText.deleteOrder: "حذف الطلب",
  AppText.areYouSureYouWantToDeleteThisOrder:
      "هل أنت متأكد من رغبتك في حذف هذا الطلب؟",
};

Map<String, String> errorMessagesEn = {
  AppText.exitMessage: "Do you want to exit the app?",

  // Dialog Titles
  AppText.alert: "Alert",
  AppText.warning: "Warning",

  // General Dialog Messages
  AppText.messagewarningAlready: "Something went wrong, please try again later",
  AppText.unexpectedError: "An unexpected error occurred",

  // Network Errors
  AppText.checkInternet: "Check your internet connection",

  // Backend Error Keys
  AppText.emailNotFoundOrNotApproved: "Email not found or account not approved",
  AppText.passwordIncorrect: "Incorrect password",
  AppText.passwordsNotMatch: "Passwords do not match",
  AppText.emailNotFound: "Email not found",
  AppText.emailOrPhoneExists: "Email or phone number already exists",
  AppText.verificationCodeIncorrect: "Invalid verification code",
  AppText.passwordsNotMatchDialog: "Passwords do not match, please re-enter",
  AppText.accountNotActive:
      "Your account is not activated. Would you like to activate it now?",
  AppText.noData: "No data available",

  // Buttons
  AppText.activateNow: "Activate Now",
  AppText.cancel: "Cancel",
  AppText.confirm: "Confirm",
  AppText.delete: "Delete",
  AppText.deleteOrder: "Delete Order",
  AppText.areYouSureYouWantToDeleteThisOrder:
      "Are you sure you want to delete this order?",
};
