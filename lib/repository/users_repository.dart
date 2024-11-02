import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_rj_admin_panel/data/models/user_profile_model.dart';

class UserRepo {
  final firebase = FirebaseFirestore.instance;

  Future<List<UserProfileModel>> getUsers() async {
    List<UserProfileModel> usersList = [];
    try {
      final data = await firebase.collection("Users").get();
      final dataMap = data.docs;
      usersList = dataMap.map((model) {
        print(model);
        return UserProfileModel(
          name: model.get("name"),
          shippingAddress: model.get("shippingAddress"),
          phoneNumber: model.get("phoneNumber"),
          email: model.get("email"),
          pincode: model.get("pincode"),
          nodeID: model.get("nodeID"),
          uid: model.get("uid"),
        );
      }).toList();
    }catch(e){
      print("Read Users Exception - ${e.toString()}");
    }
    return usersList;
  }

  Future<void>deleteUser(String nodeId) async {
    try {
    await firebase.collection("Users").doc(nodeId).delete();
    }catch(e){
      print("deleteUser Exception  - ${e.toString()}");
    }
  }
}
