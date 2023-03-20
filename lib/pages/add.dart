import 'package:firebase_test/models/user_model.dart';
import 'package:firebase_test/providers/user_provider.dart';
import 'package:firebase_test/widgets/custom_button.dart';
import 'package:firebase_test/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController ageController;
  late UserModel _user;

  @override
  void initState() {
    emailController = TextEditingController(text: "sametylmz621@gmail.com");
    nameController = TextEditingController(text: 'Samet');
    ageController = TextEditingController(text: '19');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 25) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add User',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: SizedBox(
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 300,
                  child: CustomTextField(
                      controller: nameController,
                      label: "Name",
                      obsecure: false),
                ),
                SizedBox(
                  width: 300,
                  child: CustomTextField(
                      controller: ageController, label: "Age", obsecure: false),
                ),
                SizedBox(
                  width: 300,
                  child: CustomTextField(
                      controller: emailController,
                      label: "Email",
                      obsecure: false),
                ),
                CustomButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: const EdgeInsets.all(30),
                          content: const Text(
                            'Are you sure ?',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          actions: [
                            SizedBox(
                              width: 70,
                              height: 50,
                              child: OutlinedButton(
                                style: const ButtonStyle(
                                  splashFactory: NoSplash.splashFactory,
                                ),
                                onPressed: () {
                                  _user = UserModel(
                                      name: nameController.text,
                                      age: int.parse(ageController.text),
                                      email: emailController.text,
                                      image: "https://picsum.photos/200");
                                  userProvider.postUser(_user);
                                  Navigator.pop(context);
                                },
                                child: const Text('Yes'),
                              ),
                            ),
                            SizedBox(
                              width: 70,
                              height: 50,
                              child: OutlinedButton(
                                style: const ButtonStyle(
                                  splashFactory: NoSplash.splashFactory,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No'),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  text: 'Add',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
