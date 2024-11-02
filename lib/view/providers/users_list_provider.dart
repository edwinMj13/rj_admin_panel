import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/data/models/user_profile_model.dart';
import 'package:project_rj_admin_panel/repository/users_repository.dart';

class UsersListProvider extends ChangeNotifier{

  List<UserProfileModel> _userList = [];
  List<UserProfileModel> get userList=> _userList;

  final userRepo = UserRepo();

  getUsers() async {
    _userList = await userRepo.getUsers();
    notifyListeners();
  }

  deleteUser(String nodeId) async {
    await userRepo.deleteUser(nodeId).then((_){
      getUsers();
    });
    }
}