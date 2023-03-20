import 'package:firebase_test/models/user_model.dart';
import 'package:flutter/material.dart';

class SingleUser extends StatelessWidget {
  final UserModel user;
  const SingleUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
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
