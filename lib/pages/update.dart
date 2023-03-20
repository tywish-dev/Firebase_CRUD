import '/models/user_model.dart';
import '/providers/user_provider.dart';
import '/widgets/custom_button.dart';
import '/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key, required this.user});
  final UserModel user;
  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController ageController;

  @override
  void initState() {
    emailController = TextEditingController(text: widget.user.email);
    nameController = TextEditingController(text: widget.user.name);
    ageController = TextEditingController(text: widget.user.age.toString());
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
            'Update User',
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
                                  widget.user.name = nameController.text;
                                  widget.user.age =
                                      int.parse(ageController.text);
                                  widget.user.email = emailController.text;
                                  userProvider.updateUser(widget.user);
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
                  text: 'Update',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
