class UserProfileModel {
  String name;
  String email;
  String phoneNumber;
  String pincode;
  String? shippingAddress;
  String uid;
  String nodeID;

  UserProfileModel(
      {required this.name,
      required this.phoneNumber,
      required this.email,
      required this.pincode,
      this.shippingAddress,
        required this.nodeID,
      required this.uid,});
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "pincode": pincode,
      "shippingAddress": shippingAddress,
      "uid": uid,
      "nodeID": nodeID,
    };
  }
}
List<String> userTableTitle=[
  "Name",
  "E-Mail",
  "Actions",
];
