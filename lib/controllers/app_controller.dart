
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../infrastructure/router/router_service.dart';
import '../infrastructure/utils/force_update.dart';


class AppController extends GetxController {
  var selectedTheme = ThemeMode.light.obs;
  final SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();
  var notificationCount = 0.obs;
  RxBool notificationLoading = false.obs;
  RxBool isInitialising = true.obs;
  RxString localVersionNo = ''.obs;
  RxString currentDrawerPage = ''.obs;

  void changeThemeMode(bool isDark){
    if(isDark){
      selectedTheme.value = ThemeMode.dark;
    }
    else{
      selectedTheme.value = ThemeMode.light;
    }
  }
  void hideLoader() {
    isInitialising.value = false;
  }

  getCurrentVersionNo() async {

    localVersionNo.value = await ForceUpdate().retriveCurrentVersionCodeNumber()??'';
  }

  getCurrentNavigationPage() {
    final navContext = navigatorKey.currentContext;
    if (navContext != null) {
      final navigationRoute = GoRouter
          .of(navContext)
          .state
          .path;
      currentDrawerPage.value = navigationRoute??'';
    }
  }


  void showLoader() {
    isInitialising.value = true;
  }

  void getNotifications(){

  }

}
