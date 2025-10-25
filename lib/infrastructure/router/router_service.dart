


import 'package:cws/infrastructure/router/routes.dart';
import 'package:cws/presentation/modules/auth_module/enter_mobile/enter_mobile_page.dart';
import 'package:cws/presentation/utils/not_found_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class CwsRouter {
  final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(path: CwsRoutes.not_found,builder: (context,state){
        return NotFoundPage();
      }),
      GoRoute(path: CwsRoutes.login_with_mobile,builder: (context,state){
        return EnterMobilePage();
      }),
      // GoRoute(path: '/company/:companyId', builder: (context, state) {
      //   final companyId = state.pathParameters['companyId']??'';
      //   return CompanyDetailsPage(companyId: companyId,);}),
    ],
    initialLocation: CwsRoutes.login_with_mobile,
    onException: (_, GoRouterState state, GoRouter router) {
      router.go(
        CwsRoutes.not_found,
      );
    },
  );
}
