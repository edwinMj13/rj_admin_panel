class CouponModel{
  String firebaseCollectionID;
  String campaignName;
  String code;
  double discount;
  String status;

  CouponModel( {required this.firebaseCollectionID,required this.status,required this.code,required this.campaignName,required this.discount,});

  Map<String, dynamic> toMap(){
    return {
      "campaignName":campaignName,
      "firebaseCollectionID":firebaseCollectionID,
      "code":code,
      "discount":discount,
      "status":status,
    };
  }
}
List<String> couponsTableTitle=[
  "Campaign Name",
  "Code",
  "Discount",
  "Status",
  "Actions",
];
