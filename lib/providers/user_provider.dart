import '../services/services.dart';
import '/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> _usersList = [];

  List<UserModel> get getUsersList => _usersList;

  Services services = Services();

  Future setUsersList() async {
    _usersList = await services.getUsers();
  }
}
