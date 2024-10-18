import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/product_model.dart';
import 'package:project_rj_admin_panel/services/filter_services.dart';
import 'package:project_rj_admin_panel/services/products_services/products_services.dart';
import 'package:project_rj_admin_panel/services/products_services/text_field_actions.dart';
import 'package:project_rj_admin_panel/utils/common_methods.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/category_provider.dart';
import 'package:project_rj_admin_panel/view/providers/common_provider.dart';
import 'package:project_rj_admin_panel/view/providers/pick_image_provider.dart';
import 'package:project_rj_admin_panel/view/providers/products_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/simple_text_label.dart';
import 'package:project_rj_admin_panel/repository/common.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../data/models/storage_image_model.dart';
import '../../../utils/text_controllers.dart';
import '../alternative_like_dropdown_but_popup.dart';
import '../custom_elevated_button.dart';
import '../multiple_images_widget.dart';

class PopupEDITProductContent extends StatefulWidget {
  final String title;
  ProductModel? model;

  PopupEDITProductContent({super.key, required this.title, this.model});

  @override
  State<PopupEDITProductContent> createState() =>
      _PopupEDITProductContentState();
}

class _PopupEDITProductContentState extends State<PopupEDITProductContent> {
  ProductServices productServices = ProductServices();

  @override
  void initState() {
    // TODO: implement initState
    // context.read<ProductsProvider>().getImagesForUpdate(
    //     widget.model!.imagesList);
    context.read<PickImageProvider>().addToImages(widget.model!.imagesList);
    TextFieldActions.setValuesToFields(widget.model!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(
        minHeight: size.height * 0.6,
        maxHeight: size.height * 0.65,
        minWidth: size.width * 0.5,
        maxWidth: size.width * 0.6,
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _textFieldContent(context),
          sizedHeight20,
          _actionButtonSection(context)
        ],
      ),
    );
  }


  Widget _textFieldContent(BuildContext context) {
    return Form(
      key: productServices.formKeyProductUpdate,
      child: Column(
        children: [
          SimpleTextLabel(
            controller: productNameController,
            labelText: "Product Name",
            errorLabel: "Enter Product Name",
          ),
          sizedHeight10,
          _description_images(),
          sizedHeight10,
          _brand_category_sub_Section(),
          sizedHeight10,
          _price_quantity(),
          //sizedHeight10,
          //_variant(),
        ],
      ),
    );
  }

  Row _actionButtonSection(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Elev_Button(
              onPressed: () => productServices.cancelPopup(context),
              borderColor: primaryColor,
              buttonBackground: secondaryColor,
              textColor: primaryColor,
              text: 'Cancel',
            ),
            Elev_Button(
              onPressed: () =>productServices.checkAndUpdate(context, widget.model),
              buttonBackground: primaryColor,
              textColor: secondaryColor,
              text: 'Update',
            ),
          ],
        );
  }

  Row _brand_category_sub_Section() {
    return Row(
          children: [
            Expanded(child: AlternativeForDropDown(label: 'Brand',listenable: FilterServices.brandNotifier,)),
            sizedWidth20,
            Expanded(child: AlternativeForDropDown(label: 'Category',listenable: FilterServices.categoryNotifier,)),
            sizedWidth20,
            Expanded(child: ValueListenableBuilder(
              valueListenable: FilterServices.subCategoryListNotifier,
              builder: (context,snap,_) {
                return AlternativeForDropDown(label: 'Sub-Category',listenable: FilterServices.subCategoryNotifier,subList: snap,);
              }
            )),
            /*Consumer<CommonProvider>(
              builder: (context, value, _) {
                return Expanded(
                    child: DropDownEDITFormSubCategoryWidget(
                      items: value.brandsNames!,
                      label: "Select Brand",
                    ));
              },
            ),
            Consumer<CommonProvider>(
              builder: (context, value, _) {
                return Expanded(
                    child: DropDownEDITFormSubCategoryWidget(
                      items: value.categoryNames!,
                      label: "Select Category",
                    ));
              },
            ),
            Consumer<CommonProvider>(

              builder: (context, value,_) {
                return Expanded(
                    child: DropDownEDITFormSubCategoryWidget(
                        items: value.subListProducts,
                      label: "Select Sub-Category",
                    ));
              },
            )*/
          ],
        );
  }

  Row _variant() {
    return Row(
      children: [
        Expanded(
          child: SimpleTextLabel(
            controller: productVariantTypeController,
            labelText: "Variant Type",
            errorLabel: "Enter Variant Type",
          ),
        ),
        sizedWidth10,
        Expanded(
            child: SimpleTextLabel(
              controller: productVariantItemController,
              labelText: "Variant Item",
              errorLabel: "Enter Variant Item",
            )),
      ],
    );
  }

  Row _price_quantity() {
    return Row(
      children: [
        Expanded(
            child: SimpleTextLabel(
              controller: productEDITMrpController,
              labelText: "Mrp",
              errorLabel: "Enter Mrp",
            )),
        sizedWidth10,
        Expanded(
          child: SimpleTextLabel(
            controller: productPriceController,
            labelText: "Price",
            errorLabel: "Enter Price",
          ),
        ),
        sizedWidth10,
        Expanded(
            child: SimpleTextLabel(
              controller: productSellingPriceController,
              labelText: "Selling Price",
              errorLabel: "Enter Selling Price",
            )),
        sizedWidth10,
        Expanded(
          child: SimpleTextLabel(
            controller: productQuantityController,
            labelText: "Quantity",
            errorLabel: "Enter Quantity",
          ),
        ),
      ],
    );
  }

  SizedBox _description_images() {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Description"),
                  Container(
                    height: 130,
                    width: 400,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: selectionColor, width: 0.5),
                    ),
                    child: TextFormField(
                        expands: true,
                        minLines: null,
                        maxLines: null,
                        controller: productDescriptionController,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Description";
                          }
                          return null;
                        }),
                  ),
                ],
              )),
          sizedWidth10,
           Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add Images (Min. 2 images and Max. 6 images)"),
                  MultipleImagesWidget(tag: "update",),
                ],
              )),
        ],
      ),
    );
  }
}


/*return Row(
      children: [
        Expanded(
          child: SimpleTextLabel(
            controller: productBrandController,
            labelText: "Brand",
            errorLabel: "Enter Brand",
          ),
        ),
        sizedWidth10,
        Expanded(
          child: SimpleTextLabel(
            controller: productCategoryController,
            labelText: "Category",
            errorLabel: "Enter Category Name",
          ),
        ),
        sizedWidth10,
        Expanded(
          child: SimpleTextLabel(
            controller: productSubCategoryController,
            labelText: "Sub-Category",
            errorLabel: "Enter Sub-Category",
          ),
        ),
      ],
    );*/
