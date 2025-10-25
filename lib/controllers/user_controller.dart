
import 'dart:convert';
import 'package:cws/infrastructure/network/network_service.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../infrastructure/router/router_service.dart';
import '../presentation/utils/snackbars.dart';

class UserController extends GetxController{




  @override
  onInit(){
    super.onInit();
    getToken();
  }

  getUserData(){
    getToken();
  }

  RxBool isLoggedIn = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool loginButtonEnabled = true.obs;
  RxBool registerButtonEnabled = true.obs;
  RxBool forgotPasswordButtonEnabled = true.obs;
  RxBool rememberMe = false.obs;

  final _client = GetIt.I<CwsApiClient>();
  final _sharedPref = GetIt.I<SharedPreferences>();

  void getToken (){
    // userToken = _sharedPref.getString(StorageKeys.userToken)??'';
  }
  String userToken = '';


}
