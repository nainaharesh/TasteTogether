// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:tastetogether/routes/app_routes.dart';

// /// Background / terminated mein message aane par chalta hai.
// /// Top-level function hona zaroori hai (class ke andar nahi chalta).
// /// "notification" wala message system khud dikha deta hai, yahan kuch nahi karna.
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }

// /// FCM (push notifications) ek jagah:
// ///   init()            -> main() mein, app shuru hote hi
// ///   registerDevice()  -> Splash par (permission + token). Login se koi talluq nahi:
// ///                        FCM token device ka hota hai, user ka nahi.
// class PushNotificationService {
//   PushNotificationService._();

//   /// Firebase theek se chalu hua? (web par ya setup na ho to false, app phir bhi chalti hai)
//   static bool _isReady = false;

//   static FirebaseMessaging get _messaging => FirebaseMessaging.instance;

//   // ---------------------------------------------------------------------------
//   // 1) App start (main.dart)
//   // ---------------------------------------------------------------------------
//   static Future<void> init() async {
//     if (kIsWeb) return; // abhi sirf Android / iOS

//     try {
//       await Firebase.initializeApp();
//       FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

//       // App khuli hai (foreground): system banner nahi dikhata, to app ke andar dikhao
//       FirebaseMessaging.onMessage.listen(_showInApp);

//       // App background mein thi, user ne notification par tap kiya
//       FirebaseMessaging.onMessageOpenedApp.listen(_openFromMessage);

//       _isReady = true;
//     } catch (e) {
//       // google-services.json na ho to app band na ho, sirf push kaam nahi karega
//       debugPrint('Firebase init failed: $e');
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // 2) Permission + token (login ki zaroorat nahi)
//   // ---------------------------------------------------------------------------
//   static Future<void> registerDevice() async {
//     if (!_isReady) return;

//     // Android 13+ aur iOS: user se permission poochta hai
//     final settings = await _messaging.requestPermission();
//     if (settings.authorizationStatus == AuthorizationStatus.denied) return;

//     final token = await _messaging.getToken();
//     if (token != null) await _sendTokenToBackend(token);

//     // Token kabhi kabhi badal jata hai
//     _messaging.onTokenRefresh.listen(_sendTokenToBackend);

//   }

//   // ---------------------------------------------------------------------------
//   // Private
//   // ---------------------------------------------------------------------------

//   static Future<void> _sendTokenToBackend(String token) async {
//     // TODO: backend se token save karne ka endpoint maango (Postman collection
//     // mein abhi nahi hai), phir yahan ApiClient.post(...) se bhejo.
//     // Tab tak testing ke liye token yahan se copy karo
//     // (Firebase console > Cloud Messaging > "Send test message").
//     debugPrint('FCM token: $token');
//   }

//   static void _showInApp(RemoteMessage message) {
//     final notification = message.notification;
//     if (notification == null) return;

//     Get.snackbar(
//       notification.title ?? 'TasteTogether',
//       notification.body ?? '',
//       snackPosition: SnackPosition.TOP,
//       onTap: (_) => _openFromMessage(message),
//     );
//   }

//   /// Notification par tap: Notifications screen kholo.
//   /// TODO: message.data mein type ('like', 'comment', 'follow') ho to
//   /// seedha us review / profile par bhejo.
//   static void _openFromMessage(RemoteMessage message) {
//     Get.toNamed(AppRoutes.notifications);
//   }
// }
