import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_rj_admin_panel/data/models/coupon_model.dart';
import 'package:project_rj_admin_panel/services/coupon_services.dart';
import 'package:project_rj_admin_panel/view/providers/coupon_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/simple_text_label.dart';
import 'package:provider/provider.dart';

import '../../../config/color.dart';
import '../../../utils/constants.dart';
import '../../../utils/text_controllers.dart';
import '../custom_elevated_button.dart';

class PopupEDITCouponContent extends StatelessWidget {
  final String title;

  final CouponModel model;
  final CouponServices couponServices = CouponServices();

  PopupEDITCouponContent({
    super.key,
    required this.title, required this.model,
  });


  void setValuesToEdit(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
      popupEDITCampaignNameController.text = model.campaignName;
      popupEDITCodeController.text = model.code;
      popupEDITDiscountController.text = model.discount.toString();
      final size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(
        minHeight: size.height * 0.2,
        maxHeight: size.height * 0.3,
        minWidth: size.width * 0.3,
        maxWidth: size.width * 0.4,
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          _textFields(),
          _actionButtonSection(context)
        ],
      ),
    );
  }

  Row _actionButtonSection(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Elev_Button(
              onPressed: () => couponServices.clearFields(context),
              borderColor: primaryColor,
              buttonBackground: secondaryColor,
              textColor: primaryColor,
              text: 'Cancel',
            ),
            Elev_Button(
              onPressed: () {
                double discount = couponServices.getDiscountInDouble(popupEDITDiscountController.text);
                final modelCoupon = CouponModel(
                  firebaseCollectionID: model.firebaseCollectionID,
                  code: popupEDITCodeController.text,
                  campaignName: popupEDITCampaignNameController.text,
                  discount: discount,
                  status: model.status,
                );
                couponServices.checkCouponUpdate(modelCoupon, context);
              },
              buttonBackground: primaryColor,
              textColor: secondaryColor,
              text: 'Update',
            ),
          ],
        );
  }

  Widget _textFields() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: couponServices.formKeycouponUpdate,
        child: Column(
          children: [
            SimpleTextLabel(
              controller: popupEDITCampaignNameController,
              labelText: 'Campaign Name',
              errorLabel: 'Enter Campaign Name',
            ),
            sizedHeight10,
            Row(
              children: [
                Expanded(
                  child: SimpleTextLabel(
                    controller: popupEDITCodeController,
                    labelText: 'Code',
                    errorLabel: "Enter Code",
                  ),
                ),
                sizedWidth10,
                Expanded(
                  child: TextFormField(
                    controller: popupEDITDiscountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Discount",
                        suffixIcon: Icon(Icons.percent)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Discount';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            sizedHeight10,
          ],
        ),
      ),
    );
  }
}
