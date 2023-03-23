import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/screen/splash_screen.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // StreamSubscription? _sub;

  // Future<void> initUniLinks() async {
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     final initialLink = await getInitialLink();
  //     // Parse the link and warn the user, if it is not correct,
  //     // but keep in mind it could be `null`.
  //     print('initialLink = $initialLink');
  //   } on PlatformException {
  //     // Handle exception by warning the user their action did not succeed
  //     // return?
  //   }

  //   // Attach a listener to the stream
  //   _sub = linkStream.listen((String? link) {
  //     // Parse the link and warn the user, if it is not correct
  //   }, onError: (err) {
  //     // Handle exception by warning the user their action did not succeed
  //   });
    
  //   // NOTE: Don't forget to call _sub.cancel() in dispose()
  //   print('done');
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   initUniLinks();
  // }

  // @override
  // void dispose() {
  //   _sub?.cancel();
  //   super.dispose();
  // }

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
        accentColor: primaryLightestColor,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const SplashScreen(),
    );
  }
}
