import 'dart:io';
import 'package:app_links/app_links.dart';
import 'package:cws/infrastructure/router/router_service.dart';
import 'package:cws/presentation/utils/snackbars.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'controllers/app_controller.dart';
import 'firebase_options.dart';
import 'infrastructure/injector/injector.dart';
import 'infrastructure/storage/storage_keys.dart';
import 'infrastructure/theme/theme.dart';
import 'infrastructure/utils/fcm_token_manager.dart';
import 'infrastructure/utils/http_override.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showSuccessSnackbar(message.data['link']);
}


late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'CWS', // id
    'Car Washing Services', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}


/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();


  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  usePathUrlStrategy();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission();

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  HttpOverrides.global = MyHttpOverrides();
  await Injector.init(
    appRunner: () => runApp(
      const App(),
    ),
  );
}

final GlobalKey<OverlayState> overlayKey = GlobalKey<OverlayState>();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppController appController = GetIt.I<AppController>();

  @override
  void initState() {
    super.initState();
    appController.showLoader();
    checkDeeplink();
    FCMTokenManager().saveFcmToken();
  }

  checkDeeplink(){
    final sharedPreferences = GetIt.I<SharedPreferences>();
    final appLinks = AppLinks(); // AppLinks is singleton
    appLinks.uriLinkStream.listen((uri) {
      sharedPreferences.setString(StorageKeys.deeplinkURL, uri.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => MaterialApp.router(
        routerConfig: CwsRouter().router,
        themeMode: appController.selectedTheme.value,
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: CwsTheme.lightScheme(),
            scaffoldBackgroundColor: Colors.blueGrey.shade50,
            hoverColor: Colors.blue.shade50),
        darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: CwsTheme.darkScheme(),
            hoverColor: Colors.grey.shade800),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Overlay(
            key: overlayKey,
            initialEntries: [
              OverlayEntry(builder: (context) => child!),
            ],
          );
        },
      ),
    );
  }
}
