import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_rj_admin_panel/data/models/coupon_model.dart';

class DatabaseServicesCoupon {
  final firebase = FirebaseFirestore.instance;

  addCouponDetails(CouponModel model) async {
    try {
      await firebase.collection("Coupons").add(model.toMap()).then((q) async {
        final modelIds = CouponModel(
          firebaseCollectionID: q.id,
          status: model.status,
          code: model.code,
          campaignName: model.campaignName,
          discount: model.discount,
        );
        await firebase.collection("Coupons").doc(q.id).update(modelIds.toMap());
        print("Coupons Added To Firebase ${q}");
      });
    } catch (e) {
      print("Create Coupon Details Error :- ${e.toString()}");
    }
  }

  Future<List<CouponModel>> readCouponDetails() async {
    List<CouponModel> couponModelList = [];
    try {
      final collection = await firebase.collection("Coupons").get();
      final data = collection.docs;
      couponModelList = data
          .map((e) => CouponModel(
                firebaseCollectionID: e.get("firebaseCollectionID"),
                code: e.get("code"),
                campaignName: e.get("campaignName"),
                discount: e.get("discount"),
                status: e.get("status"),
              ))
          .toList();
      print(data);
    } catch (e) {
      print("Read Coupon ${e.toString()}");
    }
    return couponModelList;
  }

  editCouponDetails(String fireID,CouponModel model) async {

    await firebase.collection("Coupons").doc(fireID).update(model.toMap());
  }

  deleteCouponDetails(String fireID) async {
    await firebase.collection("Coupons").doc(fireID).delete();
  }

}
