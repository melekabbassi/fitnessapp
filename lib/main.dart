import 'package:fitnessapp/pages/account_page.dart';
import 'package:fitnessapp/pages/login_page.dart';
import 'package:fitnessapp/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://jmygwyjemgvqtkrpvslt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpteWd3eWplbWd2cXRrcnB2c2x0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE1MzE1OTIsImV4cCI6MjAxNzEwNzU5Mn0.Cudo9V8MLhkbWTsqdDrNyXRxXTEXhlttxSImwZuJu4Y',
    authFlowType: AuthFlowType.pkce,
  );

  runApp(const MyApp());
}

// Get a reference your Supabase client
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/account': (context) => const AccountPage(),
      },
    );
  }
}
