// ignore_for_file: deprecated_member_use
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mal/firebase_options.dart';
import 'package:mal/providers/bank_loan_provider.dart';
import 'package:mal/providers/coin_loan_provider.dart';
import 'package:mal/providers/theme_provider.dart';
import 'package:mal/utills/app_theme.dart';
import 'package:mal/view/auth/update_password_screen.dart';
import 'package:mal/view/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // firebase initilization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // global status bar UI
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  // restricting the orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
        runApp(
          kDebugMode && kIsWeb ? DevicePreview(builder: (context) => MyCore()) : MyCore(),
        );
      })
      .onError((error, stackTrace) {
        throw Exception(error);
      });
}

class MyCore extends StatelessWidget {
  const MyCore({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BankLoanProvider()),
        ChangeNotifierProvider(create: (context) => CoinLoanProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder:
          (context, child) => MediaQuery(
            data: MediaQueryData(
              textScaleFactor: 1,
              textScaler: TextScaler.linear(1),
            ),
            child: child!,
          ),
      initialRoute: "/",
      routes: {"/update-password": (_) => UpdatePasswordScreen()},
      themeMode: ThemeMode.system,
      themeAnimationCurve: Curves.easeOutCirc,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: MainScreen(),
    );
  }
}
