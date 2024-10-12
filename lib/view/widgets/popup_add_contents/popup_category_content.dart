import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/data/models/category_model.dart';
import 'package:project_rj_admin_panel/data/models/storage_image_model.dart';
import 'package:project_rj_admin_panel/services/category_services.dart';
import 'package:project_rj_admin_panel/view/providers/category_provider.dart';
import 'package:project_rj_admin_panel/view/providers/home_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/chips_widget.dart';
import 'package:project_rj_admin_panel/view/widgets/simple_text_label.dart';
import 'package:project_rj_admin_panel/repository/common.dart';
import 'package:project_rj_admin_panel/utils/common_methods.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../utils/text_controllers.dart';
import '../../providers/brand_provider.dart';
import '../../providers/pick_image_provider.dart';
import '../custom_elevated_button.dart';

class PopupContentCategoryWidget extends StatelessWidget {
  final String labelText;
  final String title;
  CategoryServices categoryServices = CategoryServices();

  PopupContentCategoryWidget({
    super.key,
    required this.labelText,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(

      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Consumer<HomeProvider>(
        builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _imageSection(context),
              sizedHeight20,
              _textField(),
              sizedHeight20,
              sub_CategorySection(context),
              sizedHeight20,
              _actionButtonSection(context)
            ],
          );
        },
      ),
    );
  }

  Row _actionButtonSection(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Elev_Button(
                  onPressed: () => categoryServices.clearFields(context),
                  borderColor: primaryColor,
                  buttonBackground: secondaryColor,
                  textColor: primaryColor,
                  text: 'Cancel',
                ),
                Elev_Button(
                  onPressed: () => categoryServices.checkAndAddCategory(
                      popupCategoryNameController.text, context),
                  buttonBackground: primaryColor,
                  textColor: secondaryColor,
                  text: 'Add',
                ),
              ],
            );
  }

  /*Widget selectContent(BuildContext context, int categorySubIndex) {
    final stringTitle = getSubSectionsCategory(categorySubIndex);
    switch (stringTitle) {
      case "Category":
        return categorySection(context,stringTitle);
      case "Sub-Category":
        return sub_CategorySection(context,stringTitle);
      case "Variant-Type":
        return variant_TypeSection(context,stringTitle);
      case "Variant-Item":
        return variant_ItemSection(context,stringTitle);
      default:
        return SizedBox();
    }
  }*/

  Widget categorySection(BuildContext context, String stringTitle) {
    return _textField();
  }

  Widget sub_CategorySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 0.5, color: Colors.grey),
        ),
        child: Consumer<CategoryProvider>(
          builder: (context, value, child) {
            List<String> subList = value.subCategoryChip;
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: popupSub_CategoryNameController,
                        decoration: const InputDecoration(
                          hintText: 'Sub-Category',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        String str = popupSub_CategoryNameController.text;
                        if (str.isEmpty) {
                          showSnackbar(context, "Field cannot be empty");
                        } else if (subList.contains(str)) {
                          showSnackbar(context, "Already entered");
                        } else {
                          context.read<CategoryProvider>().addToSubCategory(
                              popupSub_CategoryNameController.text);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(width: 0.5, color: Colors.grey),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.add),
                            Text('Add'),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                sizedHeight20,
                Container(
                  height: 100,
                  width: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ChipsWidget(value: value.subCategoryChip),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget variant_TypeSection(BuildContext context, String stringTitle) {
    return SizedBox();
  }

  Widget variant_ItemSection(BuildContext context, String stringTitle) {
    return SizedBox();
  }

  Widget getChipList(List<String> value, BuildContext context) {
    //print(value.subCategoryChip);
    return Wrap(
        spacing: 5,
        children: value.isEmpty
            ? List.generate(1, (i) => const SizedBox())
            : List.generate(value.length, (index) {
                print("CHIPS ${value[index]}");
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                  child: Chip(
                    label: Text(value[index]),
                    labelStyle: const TextStyle(color: secondaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.red.shade100),
                    ),
                    backgroundColor: Colors.red.shade100,
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    deleteIconColor: Colors.red,
                    shadowColor: backgroundColor,
                    surfaceTintColor: Colors.grey,
                    onDeleted: () {
                      context.read<CategoryProvider>().deleteSubCtaegory(index);
                    },
                  ),
                );
              }));
  }

  Center _imageSection(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          context
              .read<PickImageProvider>()
              .pickImage("add",()=> categoryServices.saveImageToCheck(context));
        },
        child: Consumer<PickImageProvider>(
          builder:
              (BuildContext context, PickImageProvider value, Widget? child) {
            return _image(value, context);
          },
        ),
      ),
    );
  }

  Container _image(PickImageProvider value, BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.grey[200]),
      child: getImage(value, context),
    );
  }

  Widget getImage(PickImageProvider value, BuildContext context) {
    late Widget widget;
    if (value.imageFile == null) {
      widget = const Icon(
        Icons.add_a_photo,
        size: 30,
      );
    }
    if (value.imageFile != null) {
      widget = ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.memory(
          Uint8List.fromList(value.imageFile!.bytes!),
          fit: BoxFit.cover,
        ),
      );
    }
    return widget;
  }

  Padding _textField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Form(
        key: categoryServices.formKeyCategoryAdd,
        child: SimpleTextLabel(
          labelText: labelText,
          controller: popupCategoryNameController,
          errorLabel: labelText,
        ),
      ),
    );
  }
}
