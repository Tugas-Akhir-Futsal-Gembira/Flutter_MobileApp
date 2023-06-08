import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/firebase_options.dart';
import 'package:flutter_application_futsal_gembira/screen/splash_screen.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';

const AndroidNotificationChannel _channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title(name)
  description: 'This channel is used for important notifications.', // description
  importance: Importance.max,
);

void main() async{
  // await initializeDateFormatting('id_ID, null').then((_) => runApp(const MyApp()));
  await initializeDateFormatting('id_ID, null');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(android: AndroidInitializationSettings('ic_launcher'))
  );

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_channel);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if(notification != null && android != null){
      flutterLocalNotificationsPlugin.show(
        notification.hashCode, 
        notification.title, 
        notification.body, 
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id, 
            _channel.name,
            channelDescription: _channel.description,
          )
        )
      );
    }
  },);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        }
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        ///To set Inter font to be default font
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Inter',
          bodyColor: Colors.white,
          displayColor: Colors.white
        ),
        ///To set scroll effect color
        // ignore: deprecated_member_use
        accentColor: primaryLightestColor,
        scrollbarTheme: const ScrollbarThemeData(thumbColor: MaterialStatePropertyAll(primaryLightestColor))
      ),
      home: const SplashScreen(),
      // home: const MainScreen(indexChoosen: 0,)
    );
  }
}
