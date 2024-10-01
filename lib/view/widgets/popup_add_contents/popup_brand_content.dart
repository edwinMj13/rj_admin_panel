import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/data/models/category_model.dart';
import 'package:project_rj_admin_panel/data/models/storage_image_model.dart';
import 'package:project_rj_admin_panel/services/brand_services.dart';
import 'package:project_rj_admin_panel/view/providers/category_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/simple_text_label.dart';
import 'package:project_rj_admin_panel/repository/common.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../utils/text_controllers.dart';
import '../../providers/brand_provider.dart';
import '../../providers/pick_image_provider.dart';
import '../custom_elevated_button.dart';

class PopupContentBrandWidget extends StatelessWidget {
  final String labelText;
  final String title;
  BrandServices brandServices=BrandServices();

  PopupContentBrandWidget({
    super.key,
    required this.labelText,
    required this.title,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _imageSection(context),
          sizedHeight10,
          _textField(),
          sizedHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Elev_Button(
                onPressed: () => brandServices.clearFields(context),
                borderColor: primaryColor,
                buttonBackground: secondaryColor,
                textColor: primaryColor,
                text: 'Cancel',
              ),
              Elev_Button(
                onPressed: () =>
                    brandServices.checkAndAddBrand(popupBrandNameController.text, context),
                buttonBackground: primaryColor,
                textColor: secondaryColor,
                text: 'Add',
              ),
            ],
          )
        ],
      ),
    );
  }

  // saveTtoString(BuildContext context){
  //   imageMain = context.read<PickImageProvider>().imageFile!.bytes.toString();
  // }

  Center _imageSection(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          context.read<PickImageProvider>().pickImage("add", () => brandServices.saveTtoString(context));
        },
        child: Consumer<PickImageProvider>(
          builder:
              (BuildContext context, PickImageProvider value, Widget? child) {
            return _image(value);
          },
        ),
      ),
    );
  }

  Padding _textField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Form(
        key: brandServices.formKeyAddBrand,
        child: SimpleTextLabel(labelText: labelText,controller: popupBrandNameController,errorLabel: labelText,),
      ),
    );
  }

  Container _image(PickImageProvider value) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.grey[200]),
      child: value.imageFile == null
          ? const Icon(
              Icons.add_a_photo,
              size: 30,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.memory(
                Uint8List.fromList(value.imageFile!.bytes!),
                fit: BoxFit.cover,
              ),
            ),
    );
  }

}
