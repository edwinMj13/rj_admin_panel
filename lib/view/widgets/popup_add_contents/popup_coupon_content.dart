import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_rj_admin_panel/data/models/coupon_model.dart';
import 'package:project_rj_admin_panel/services/coupon_services.dart';
import 'package:project_rj_admin_panel/view/providers/coupon_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/simple_text_label.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../utils/text_controllers.dart';
import '../custom_elevated_button.dart';

class PopupCouponContent extends StatelessWidget {

  final String title;
  final CouponServices couponServices = CouponServices();

  PopupCouponContent({
    super.key,
    required this.title,
  });



  void setValuesToEdit(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Container(
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
                double discount = couponServices.getDiscountInDouble(popupDiscountController.text);
                //assert(discount is double);
                final model = CouponModel(
                  firebaseCollectionID: "",
                  code: popupCodeController.text,
                  campaignName: popupCampaignNameController.text,
                  discount: discount,
                  status: "Available",
                );
                couponServices.checkCouponAdd(model, context);
              },
              buttonBackground: primaryColor,
              textColor: secondaryColor,
              text: 'Add',
            ),
          ],
        );
  }

  Widget _textFields() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: couponServices.formKeycouponAdd,
        child: Column(
          children: [
            SimpleTextLabel(
              controller: popupCampaignNameController,
              labelText: 'Campaign Name',
              errorLabel: 'Enter Campaign Name',
            ),
            sizedHeight10,
            Row(
              children: [
                Expanded(
                  child: SimpleTextLabel(
                    controller: popupCodeController,
                    labelText: 'Code',
                    errorLabel: "Enter Code",
                  ),
                ),
                sizedWidth10,
                Expanded(
                  child: TextFormField(
                    controller: popupDiscountController,
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
