import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    final session = supabase.auth.currentSession;

    if (!mounted) return;
    if (session != null) {
      Navigator.of(context).pushReplacementNamed('/home_page');
    } else {
      Navigator.of(context).pushReplacementNamed('/login_page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/images/fitness-app-logo.png")),
    );
  }
}
