import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/register.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late ConfettiController confettiController;
  @override
  void initState() {
    usernameController = TextEditingController(text: "sametylmz621@gmail.com");
    passwordController = TextEditingController(text: "123");
    confettiController =
        ConfettiController(duration: const Duration(seconds: 100));
    super.initState();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ConfettiWidget(
                    confettiController: confettiController,
                    blastDirectionality: BlastDirectionality.explosive,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ],
                    createParticlePath: drawStar,
                  );
                  UserCredential credential =
                      await auth.signInWithEmailAndPassword(
                          email: usernameController.text,
                          password: passwordController.text);

                  print(credential.toString());
                } catch (e) {
                  print(e.toString());
                }
              }, "Login"),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const RegisterPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        final tween = Tween(begin: begin, end: end);
                        final offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  "Don't have an account? Create one!",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.purple.shade900,
                  ),
                ),
              )
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

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}
