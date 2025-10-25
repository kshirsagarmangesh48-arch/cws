import 'package:dio/dio.dart';
import '../../../presentation/utils/snackbars.dart';


class SnackBarInterceptor extends Interceptor {

  bool showSuccessBar = false;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    if(options.extra.containsKey('showSuccess')){
      showSuccessBar = true;
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    print(response);
      if(response.statusCode.toString().startsWith('4')||response.statusCode.toString().startsWith('2')){
        if(response.data['success'].toString()=='false'){
          showFailureSnackbar(response.data['message']??response.data['msg']??'Something Went wrong !!!');
        }
      }
  }
}
