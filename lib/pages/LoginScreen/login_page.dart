import 'dart:async';

import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/pages/HomeScreen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        // Navigator.of(context).pushReplacementNamed('/account');
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => new Home()));
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _authSubscription.cancel();
    super.dispose();
  }

  final Widget googleIcon = SvgPicture.asset(
    "assets/icons/google.svg",
    height: 48,
    width: 48,
  );

  final Widget octopusIcon = SvgPicture.asset(
    "assets/icons/octopus.svg",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            octopusIcon,
            const SizedBox(height: 48),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
                fixedSize: MaterialStateProperty.all<Size>(const Size(250, 50)),
              ),
              onPressed: () async {
                try {
                  await supabase.auth.signInWithOAuth(Provider.google,
                      redirectTo:
                          "io.supabase.flutterquickstart://login-callback");
                  // Navigator.push(
                  //     context,
                  //     new MaterialPageRoute(
                  //         builder: (context) => new AccountPage()));
                } on AuthException catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(error.message),
                        backgroundColor: Theme.of(context).colorScheme.error),
                  );
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: const Text(
                            'An error has occurred, please try again.'),
                        backgroundColor: Theme.of(context).colorScheme.error),
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  googleIcon,
                  const SizedBox(width: 10),
                  Text(
                    'Sign in with Google',
                    style: TextStyle(color: Colors.blueGrey.shade900),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
