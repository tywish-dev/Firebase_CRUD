import 'package:firebase_auth/firebase_auth.dart';

import '/pages/add.dart';
import '/pages/login.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  final FirebaseAuth auth;
  const NavDrawer({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(
              height: 300,
            ),
            ListTile(
              leading: const Icon(
                Icons.home_max_outlined,
                size: 30,
                color: Colors.black87,
              ),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(
                Icons.add,
                size: 30,
                color: Colors.black87,
              ),
              title: const Text(
                'Add',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddPage()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                size: 30,
                color: Colors.black87,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                auth.signOut();
                Navigator.of(context).pop();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
