import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/services/common_services.dart';
import 'package:project_rj_admin_panel/utils/text_controllers.dart';
import 'package:provider/provider.dart';

import '../data/models/coupon_model.dart';
import '../view/providers/coupon_provider.dart';

class CouponServices {

  final formKeycouponAdd = GlobalKey<FormState>();
  final formKeycouponUpdate = GlobalKey<FormState>();
  CommonServices commonServices = CommonServices();
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
    commonServices.loadingDialogShow(context);

    if (validateAdd()) {
      await context.read<CouponProvider>().addCoupons(model).then((_) {
        commonServices.cancelLoading();

        couponScreenRefresh(context);
      });
    }
  }

  checkCouponUpdate(CouponModel model, BuildContext context) async {
    commonServices.loadingDialogShow(context);

    if (validateUpdate()) {
      await context.read<CouponProvider>().editCoupon(model.firebaseCollectionID,model).then((_){
        commonServices.cancelLoading();
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

  updateStatus(CouponModel model,BuildContext context){
    context.read<CouponProvider>().editCoupon(model.firebaseCollectionID, model).then((_){
      context.read<CouponProvider>().getCouponDetailsProvider();
      Navigator.of(context).pop();
    });
  }
}