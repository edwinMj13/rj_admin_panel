import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/data/models/coupon_model.dart';
import 'package:project_rj_admin_panel/repository/database_services_coupon.dart';

class CouponProvider extends ChangeNotifier{

  List<CouponModel>? _couponList;
  List<CouponModel>? get couponList=>_couponList;

  final couponservices=DatabaseServicesCoupon();


  Future<void> addCoupons(CouponModel model) async {
    await couponservices.addCouponDetails(model);
    notifyListeners();
  }

  getCouponDetailsProvider() async {
    _couponList= await couponservices.readCouponDetails();
    notifyListeners();
  }

  Future<void> editCoupon(String fireId,CouponModel model) async {
    await couponservices.editCouponDetails(fireId, model);
  }

  refresh(){
notifyListeners();
  }

  deleteCoupon(String id) async {
    await couponservices.deleteCouponDetails(id);
    getCouponDetailsProvider();
  }

}