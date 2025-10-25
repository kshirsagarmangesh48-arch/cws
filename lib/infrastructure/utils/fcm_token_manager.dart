import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/storage_keys.dart';

class FCMTokenManager {
  final sharedPreferences = GetIt.I<SharedPreferences>();
  final firebaseMessaging = GetIt.I<FirebaseMessaging>();

  Future<String?> getFCMToken() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    String? token;
    try {
      token = await firebaseMessaging.getToken();
    } catch (_) {}
    return token;
  }

  Future<void> saveFcmToken() async {
    try {
      final fcmToken = await getFCMToken();
      sharedPreferences.setString(StorageKeys.fcmToken, fcmToken ?? '');
    } catch (e) {
      if (e is Exception) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> getFcmToken() async {
    sharedPreferences.getString(StorageKeys.fcmToken);
  }
}
