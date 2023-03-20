import '../services/services.dart';
import '/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> _usersList = [];
  late UserModel? _singleUser;

  List<UserModel> get getUsersList => _usersList;
  UserModel get getSingleUser => _singleUser!;

  Services services = Services();

  Future setUsersList() async {
    _usersList = await services.getUsers();
    notifyListeners();
  }

  Future setSingleUser(String id) async {
    _singleUser = await services.getUserById(id);
    notifyListeners();
  }

  Future deleteUserbyId(String id) async {
    await services.deleteUser(id);
    setUsersList();
    notifyListeners();
  }
}
