import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/utils/text_controllers.dart';
import 'package:provider/provider.dart';

import '../data/models/coupon_model.dart';
import '../view/providers/coupon_provider.dart';

class CouponServices {

  final formKeycouponAdd = GlobalKey<FormState>();
  final formKeycouponUpdate = GlobalKey<FormState>();

  validateAdd() {
    if (formKeycouponAdd.currentState!.validate()) {
      return true;
    }
    return false;
  }

  validateUpdate() {
    if (formKeycouponUpdate.currentState!.validate()) {
      return true;
    }
    return false;
  }

  getDiscountInDouble(String discString){
    double discount=0.0;
  try {
   discount = double.parse(discString);
  } catch (e) {
  print("Exception Discount Coupon Popup${e.toString()}");
  }
  return discount;
}


  checkCouponAdd(CouponModel model, BuildContext context) async {
    if (validateAdd()) {
      await context.read<CouponProvider>().addCoupons(model).then((_) {
        popupCampaignNameController.clear();
        popupDiscountController.clear();
        popupCodeController.clear();
        couponScreenRefresh(context);
      });
    }
  }

  checkCouponUpdate(CouponModel model, BuildContext context) async {
    if (validateUpdate()) {
      await context.read<CouponProvider>().editCoupon(model.firebaseCollectionID,model).then((_){
        popupEDITCampaignNameController.clear();
        popupEDITDiscountController.clear();
        popupEDITCodeController.clear();
        couponScreenRefresh(context);
      });
    }
  }

  clearFields(BuildContext context){
    popupCampaignNameController.clear();
    popupEDITCampaignNameController.clear();
    popupCodeController.clear();
    popupEDITCodeController.clear();
    popupDiscountController.clear();
    popupEDITDiscountController.clear();
    Navigator.pop(context);
  }

  couponScreenRefresh(BuildContext context) {
    clearFields(context);
    context.read<CouponProvider>().getCouponDetailsProvider();
  }
}