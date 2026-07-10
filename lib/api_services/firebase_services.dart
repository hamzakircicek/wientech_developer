import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebaseNotificationService {
  static Future<void>? _initialization;

  static Future<void> init() {
    // initState birden fazla çalışsa bile ikinci listener kurulmaz.
    return _initialization ??= _initialize();
  }

  static Future<void> _initialize() async {
    try {
      final messaging = FirebaseMessaging.instance;

      final settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      debugPrint('Bildirim izni: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        debugPrint('Bildirim izni reddedildi.');
        return;
      }

      /*
       * iOS'ta FCM token alınmadan önce APNs token oluşmalıdır.
       */
      if (Platform.isIOS) {
        final apnsToken = await _waitForAPNSToken(messaging);

        if (apnsToken == null) {
          debugPrint('APNs token alınamadı. iOS yapılandırmasını kontrol et.');
          return;
        }

        debugPrint('APNs token: $apnsToken');
      }

      final fcmToken = await messaging.getToken();

      debugPrint('FCM token: $fcmToken');

      if (fcmToken != null) {
        await messaging.subscribeToTopic('all_admins');
        debugPrint('all_admins topic aboneliği başarılı.');
      }

      messaging.onTokenRefresh.listen(
        (newToken) async {
          debugPrint('Yeni FCM token: $newToken');

          // Yeni tokenı backend'e burada gönderebilirsin.
        },
        onError: (Object error) {
          debugPrint('Token yenileme hatası: $error');
        },
      );

      FirebaseMessaging.onMessage.listen((message) {
        debugPrint('Foreground bildirim: ${message.notification?.title}');
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        debugPrint('Bildirime basıldı: ${message.messageId}');
      });
    } on FirebaseException catch (error, stackTrace) {
      debugPrint(
        'Firebase Messaging hatası '
        '[${error.code}]: ${error.message}',
      );
      debugPrintStack(stackTrace: stackTrace);
    } catch (error, stackTrace) {
      debugPrint('Bildirim kurulumu hatası: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  static Future<String?> _waitForAPNSToken(FirebaseMessaging messaging) async {
    // Toplam yaklaşık 15 saniye bekler.
    for (int attempt = 1; attempt <= 30; attempt++) {
      try {
        final token = await messaging.getAPNSToken();

        if (token != null && token.isNotEmpty) {
          return token;
        }
      } on FirebaseException catch (error) {
        debugPrint(
          'APNs henüz hazır değil '
          '($attempt/30): ${error.code}',
        );
      }

      await Future<void>.delayed(const Duration(milliseconds: 500));
    }

    return null;
  }
}
