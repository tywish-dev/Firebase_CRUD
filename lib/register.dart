import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  @override
  void initState() {
    usernameController = TextEditingController(text: "sametylmz621@gmail.com");
    passwordController = TextEditingController(text: "123456");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 300,
                child: _textField(usernameController, "Username", false),
              ),
              SizedBox(
                width: 300,
                child: _textField(passwordController, "Password", true),
              ),
              _button(() async {
                FirebaseAuth auth = FirebaseAuth.instance;
                try {
                  UserCredential credential =
                      await auth.createUserWithEmailAndPassword(
                          email: usernameController.text,
                          password: passwordController.text);
                  print(credential.toString());
                } catch (e) {
                  print(e.toString());
                }
              }, "Register"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(
      TextEditingController controller, String label, bool obsecure) {
    return TextField(
      controller: controller,
      obscureText: obsecure,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _button(Function() onPressed, String text) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}
