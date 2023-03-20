import 'package:firebase_auth/firebase_auth.dart';
import '/pages/add.dart';
import '/pages/login.dart';
import '/providers/user_provider.dart';
import '/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';
import '/widgets/single_user.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final FirebaseAuth auth;
  const HomePage({super.key, required this.auth});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 25) {
          _key.currentState!.openDrawer();
        }
      },
      child: Scaffold(
        key: _key,
        drawer: NavDrawer(
          auth: widget.auth,
        ),
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              _key.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
            color: Colors.black,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            iconSize: 30,
          ),
          title: const Text(
            'Users',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddPage()));
              },
              icon: const Icon(Icons.add),
              color: Colors.black,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              iconSize: 30,
            ),
            IconButton(
              onPressed: () {
                widget.auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(Icons.logout),
              color: Colors.black,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: userProvider.getUsersList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SingleUser(
                        user: userProvider.getUsersList[index],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
