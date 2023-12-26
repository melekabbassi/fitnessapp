import 'package:fitnessapp/components/avatar.dart';
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
  final _usernameController = TextEditingController();
  final _fullnameController = TextEditingController();
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _getInitialProfile();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullnameController.dispose();
    super.dispose();
  }

  Future<void> _getInitialProfile() async {
    final userId = supabase.auth.currentUser!.id;
    final data =
        await supabase.from('profiles').select().eq('id', userId).single();
    setState(() {
      _usernameController.text = data['username'];
      _fullnameController.text = data['full_name'];
      _imageUrl = data['avatar_url'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            "Account",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreenAccent),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          Avatar(
              imageUrl: _imageUrl,
              onUpload: (imageUrl) async {
                setState(() {
                  _imageUrl = imageUrl;
                });
                final userId = supabase.auth.currentUser!.id;
                await supabase
                    .from('profiles')
                    .update({'avatar_url': imageUrl}).eq('id', userId);
              }),
          const SizedBox(height: 12),
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreenAccent),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              floatingLabelAlignment: FloatingLabelAlignment.start,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              floatingLabelStyle: TextStyle(color: Colors.lightGreenAccent),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreenAccent),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              label: Text('Username'),
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _fullnameController,
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreenAccent),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              floatingLabelAlignment: FloatingLabelAlignment.start,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              floatingLabelStyle: TextStyle(color: Colors.lightGreenAccent),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreenAccent),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              label: Text('Full Name'),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
              fixedSize: MaterialStateProperty.all<Size>(const Size(250, 50)),
            ),
            onPressed: () async {
              final username = _usernameController.text.trim();
              final fullname = _fullnameController.text.trim();
              final userId = supabase.auth.currentUser!.id;
              await supabase.from('profiles').update({
                'username': username,
                'full_name': fullname,
              }).eq('id', userId);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Profile updated.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  backgroundColor: Colors.lightGreenAccent,
                ));
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
              ),
            ],
          )
        ],
      ),
    );
  }
}
