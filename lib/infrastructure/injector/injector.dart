import 'dart:async';

import 'package:cws/infrastructure/network/network_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/app_controller.dart';
import '../utils/app_consts.dart';

typedef AppRunner = FutureOr<void> Function();

class Injector {
  static Future<void> init({
    required AppRunner appRunner,
  }) async {
    await _initDependencies();
    appRunner();
  }

  static Future<void> _initDependencies() async {
    await _injectUtils();
    await _injectControllers();
    await GetIt.I.allReady();
  }
}

FutureOr<void> _injectControllers(){
  GetIt.I.registerLazySingleton<AppController>(() => AppController());
}

FutureOr<void> _injectUtils() async {
  GetIt.I.registerLazySingleton<Dio>(() => Dio());
  GetIt.I.registerLazySingleton<CwsApiClient>(
          () => CwsApiClient(GetIt.I<Dio>(), AppConsts.baseURL));
  GetIt.I.registerSingletonAsync<SharedPreferences>(
          () => SharedPreferences.getInstance());
  GetIt.I.registerSingletonAsync<FirebaseMessaging>(
          () async => Future.value(FirebaseMessaging.instance));
}
