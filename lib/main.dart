import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fitnessapp/pages/AccountScreen/account_page.dart';
import 'package:fitnessapp/pages/HomeScreen/home_page.dart';
import 'package:fitnessapp/pages/LoginScreen/login_page.dart';
import 'package:fitnessapp/pages/SplashScreen/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://jmygwyjemgvqtkrpvslt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpteWd3eWplbWd2cXRrcnB2c2x0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE1MzE1OTIsImV4cCI6MjAxNzEwNzU5Mn0.Cudo9V8MLhkbWTsqdDrNyXRxXTEXhlttxSImwZuJu4Y',
    // authFlowType: AuthFlowType.pkce,
  );

  runApp(const MyApp());
}

// Get a reference your Supabase client
final supabase = Supabase.instance.client;
final ThemeData myTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
      background: Color(0xFF192126),
      primary: Color(0xFF192126),
      secondary: Color(0xFFBBF246)),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      home: AnimatedSplashScreen(
        splash: const SplashPage(),
        nextScreen: const LoginPage(),
        splashIconSize: toDouble(200),
        splashTransition: SplashTransition.fadeTransition,
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const SplashPage(),
      //   '/login_page': (context) => const LoginPage(),
      //   '/account': (context) => const AccountPage(),
      //   '/home_page': (context) => const HomePage(),
      // },
    );
  }
}
