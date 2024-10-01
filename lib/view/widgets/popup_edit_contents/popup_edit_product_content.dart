import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/product_model.dart';
import 'package:project_rj_admin_panel/services/products_services.dart';
import 'package:project_rj_admin_panel/utils/common_methods.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/category_provider.dart';
import 'package:project_rj_admin_panel/view/providers/common_provider.dart';
import 'package:project_rj_admin_panel/view/providers/pick_image_provider.dart';
import 'package:project_rj_admin_panel/view/providers/products_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/drop_down_widget/dropdown_field_widget.dart';
import 'package:project_rj_admin_panel/view/widgets/simple_text_label.dart';
import 'package:project_rj_admin_panel/repository/common.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../data/models/storage_image_model.dart';
import '../../../utils/isolates.dart';
import '../../../utils/text_controllers.dart';
import '../custom_elevated_button.dart';
import '../drop_down_widget/dropdown_edit_field_widget.dart';
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
    context.read<ProductsProvider>().getImagesForUpdate(
        widget.model!.imagesList);
    context.read<PickImageProvider>().addToImages(widget.model!.imagesList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("data")));
    productDescriptionController.text = widget.model!.description;
    productSubCategoryController;
    productQuantityController.text = widget.model!.stock;
    productSellingPriceController.text = widget.model!.sellingPrize;
    productPriceController.text = widget.model!.price;
    productNameController.text = widget.model!.itemName;
    productBrandController.text = widget.model!.itemBrand;

    //productSubCategoryController.text=model.su
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          _textFieldContent(context),
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
          Row(
            children: [
              Consumer<CommonProvider>(
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
              )
            ],
          ),
          sizedHeight10,
          _price_quantity(),
          //sizedHeight10,
          //_variant(),
          sizedHeight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Elev_Button(
                onPressed: () => Navigator.pop(context),
                borderColor: primaryColor,
                buttonBackground: secondaryColor,
                textColor: primaryColor,
                text: 'Cancel',
              ),
              Elev_Button(
                onPressed: () async {
                  productServices.checkAndUpdate(context, widget.model);
                },
                buttonBackground: primaryColor,
                textColor: secondaryColor,
                text: 'Update',
              ),
            ],
          )
        ],
      ),
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
          const Expanded(
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
