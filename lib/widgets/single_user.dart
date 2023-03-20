import '/models/user_model.dart';
import '/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleUser extends StatelessWidget {
  final UserModel user;
  const SingleUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            width: 25,
          ),
          CircleAvatar(
            backgroundColor: Colors.purple.shade900,
            backgroundImage: NetworkImage(user.image, scale: 0.2),
            radius: 36,
          ),
          const SizedBox(
            width: 25,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${user.name}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Age: ${user.age}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                height: 30,
                child: OutlinedButton(
                  style: const ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                  ),
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
                                  userProvider.deleteUserbyId(user.id!);

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
                  child: const Text('Delete'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: OutlinedButton(
                  style: const ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {},
                  child: const Text('Update'),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
