class  CwsRoutes{

  static const login = '/login';
  static const splash = '/splash';
  static const login_with_mobile = '/login-with-mobile';
  static const login_with_mobile_password = '/login-with-mobile-password';
  static const login_with_mobile_otp = '/login-with-mobile-otp';
  static const set_profile = '/set-profile';
  static const dashboard = '/dashboard';
  static const not_found = '/not-found';

  static  companyDetails({required String companyId}) => '/company/$companyId';
}