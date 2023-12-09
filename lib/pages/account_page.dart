import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: ElevatedButton(
        onPressed: () async {
          try {
            await supabase.auth.signOut();
            Navigator.of(context).pushReplacementNamed('/login');
          } catch (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
              ),
            );
          }
        },
        child: const Text('Logout'),
      ),
    );
  }
}
