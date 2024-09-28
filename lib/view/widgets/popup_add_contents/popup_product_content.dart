import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/product_model.dart';
import 'package:project_rj_admin_panel/utils/common_methods.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/category_provider.dart';
import 'package:project_rj_admin_panel/view/providers/common_provider.dart';
import 'package:project_rj_admin_panel/view/providers/pick_image_provider.dart';
import 'package:project_rj_admin_panel/view/providers/products_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/dropdown_field_widget.dart';
import 'package:project_rj_admin_panel/view/widgets/simple_text_label.dart';
import 'package:project_rj_admin_panel/repository/common.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../data/models/storage_image_model.dart';
import '../../../utils/isolates.dart';
import '../../../utils/text_controllers.dart';
import '../custom_elevated_button.dart';
import '../multiple_images_widget.dart';

class PopupProductContent extends StatelessWidget {
  final String title;

  PopupProductContent({super.key, required this.title});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("data")));
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

  validate() {
    final isTrue = _formKey.currentState!.validate();
    if (isTrue) {
      return true;
    }
    return false;
  }

  Widget _textFieldContent(BuildContext context) {
    return Form(
      key: _formKey,
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
                      child: DropDownFormWidget(
                    items: value.brandsNames!,
                    label: "Select Brand",
                  ));
                },
              ),
              sizedWidth10,
              Consumer<CommonProvider>(
                builder: (context, value, _) {
                  return Expanded(
                      child: DropDownFormWidget(
                    items: value.categoryNames!,
                    label: "Select Category",
                  ));
                },
              ),
              sizedWidth10,
              Consumer<CommonProvider>(
                builder: (context, value, _) {
                  print("Value subListProducts ${value.subListProducts}");
                  return Expanded(
                      child: DropDownFormWidget(
                    items: value.subListProducts! ?? ["", ""],
                    label: "Select Sub-Category",
                  ));
                },
              ),
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
                  checkPopupFields(context);
                },
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
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Images (Min. 2 images and Max. 6 images)"),
              MultipleImagesWidget(),
            ],
          )),
        ],
      ),
    );
  }

  Future<void> checkPopupFields(BuildContext context) async {
    print("QWERTYHGFDS${context.read<CommonProvider>().selectedBrand!}");
    if (validate()) {
      if (context.read<PickImageProvider>().multiple_Files.length >= 2) {
        List<StorageImageModel> imageLIst =
            await getFirebaseStorageMULTIPLEImageUrl(
          context.read<PickImageProvider>().multiple_Files,
          refName: "productIMages",
          productName: productNameController.text,
        );
        final model = ProductModel(
          imagesList: imageLIst,
          firebaseNodeId: "",
          //image: "image",
          itemName: productNameController.text,
          category: context.read<CommonProvider>().selectedCategory!,
          itemBrand: context.read<CommonProvider>().selectedBrand!,
          price: productPriceController.text,
          sellingPrize: productSellingPriceController.text,
          stock: productQuantityController.text,
          status: "Selling",
          subCategory: context.read<CommonProvider>().selectedCategory!,
          description: productDescriptionController.text,
        );
        context.read<ProductsProvider>().addProductData(model).then((_) {
          refresh(context);
        });
      }
    }
    if (context.read<PickImageProvider>().multiple_Files.length < 2){
      showSnackbar(context, "Select atleast 2 images");
    }
  }

  void refresh(BuildContext context) {
    Navigator.pop(context);
    context.read<ProductsProvider>().getProductsDataProvider();
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
