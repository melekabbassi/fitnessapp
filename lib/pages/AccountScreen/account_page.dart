import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/pages/LoginScreen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

final Widget logoutIcon = SvgPicture.asset(
  "assets/icons/logout.svg",
  height: 48,
  width: 48,
);

final User? user = supabase.auth.currentUser;

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 16),
            Text(
              'email: ${user!.email}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'role: ${user!.role}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 48),
            FloatingActionButton(
              backgroundColor: Colors.lightGreenAccent,
              onPressed: () async {
                try {
                  await supabase.auth.signOut();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new LoginPage()));
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error.toString()),
                    ),
                  );
                }
              },
              child: logoutIcon,
            )
          ],
        ),
      ),
    );
  }
}
