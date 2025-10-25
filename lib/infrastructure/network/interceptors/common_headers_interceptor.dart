import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../controllers/user_controller.dart';

class CommonHeadersInterceptor extends Interceptor {

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
    final userController = GetIt.I<UserController>();
    userController.getToken();
    if(options.extra['multipart']==true){
      options.headers.addAll({
        "Access-Control-Allow-Methods": "POST, OPTIONS",
        'Content-Type': "multipart/form-data"
      });
    }
    else{
      options.headers.addAll({
        "Access-Control-Allow-Methods": "POST, OPTIONS",
        "Content-Type":'application/json'
      });
    }
    if(userController.userToken!=''){
      options.headers.addAll(
          {
            'Authorization': 'Bearer ${userController.userToken}',
          }
      );
    }
  }
}
