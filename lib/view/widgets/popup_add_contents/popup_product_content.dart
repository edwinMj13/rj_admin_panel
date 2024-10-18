import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/product_model.dart';
import 'package:project_rj_admin_panel/services/filter_services.dart';
import 'package:project_rj_admin_panel/services/products_services/products_services.dart';
import 'package:project_rj_admin_panel/utils/common_methods.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/category_provider.dart';
import 'package:project_rj_admin_panel/view/providers/common_provider.dart';
import 'package:project_rj_admin_panel/view/providers/pick_image_provider.dart';
import 'package:project_rj_admin_panel/view/providers/products_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/alternative_like_dropdown_but_popup.dart';
import 'package:project_rj_admin_panel/view/widgets/simple_text_label.dart';
import 'package:project_rj_admin_panel/repository/common.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../data/models/storage_image_model.dart';
import '../../../utils/text_controllers.dart';
import '../custom_elevated_button.dart';
import '../multiple_images_widget.dart';

class PopupProductContent extends StatefulWidget {
  final String title;

  PopupProductContent({super.key, required this.title});

  @override
  State<PopupProductContent> createState() => _PopupProductContentState();
}

class _PopupProductContentState extends State<PopupProductContent> {
  ProductServices productServices = ProductServices();

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    await context.read<CommonProvider>().getBrandsNames();
    await context.read<CommonProvider>().getCategoryNames();
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
      child: Form(
        key: productServices.formKeyProductAdd,
        child: _textFieldContent(context),
      ),
    );
  }

  Widget _textFieldContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SimpleTextLabel(
          controller: productNameController,
          labelText: "Product Name",
          errorLabel: "Enter Product Name",
        ),
        sizedHeight10,
        _description_images(),
        sizedHeight10,
        _brand_category_sub_section(),
        sizedHeight10,
        _price_quantity(),
        //sizedHeight10,
        //_variant(),
        sizedHeight20,
        _actionButtonSection(context)
      ],
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
          onPressed: () =>productServices.checkAndAdd(context),
          buttonBackground: primaryColor,
          textColor: secondaryColor,
          text: 'Add',
        ),
      ],
    );
  }

  Row _brand_category_sub_section() {
    return Row(
      children: [
        Expanded(
            child: AlternativeForDropDown(
          label: "Brand",
              listenable: FilterServices.brandNotifier,
        )),
        sizedWidth10,
        Expanded(
            child: AlternativeForDropDown(
          label: "Category",
              listenable: FilterServices.categoryNotifier,
        )),
        sizedWidth10,
        Expanded(
            child: _listenableSubcategoryWIdget()),
      ],
    );
  }

  ValueListenableBuilder _listenableSubcategoryWIdget() {
    return ValueListenableBuilder(
      valueListenable: FilterServices.subCategoryListNotifier,
      builder: (context,snap,_) {
        return AlternativeForDropDown(
            label: "Sub-Category",
                listenable: FilterServices.subCategoryNotifier,
          subList: snap,
          );
      }
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
              controller: productMrpController,
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
              const Text("Add Images (Min. 2 images and Max. 6 images)"),
              MultipleImagesWidget(
                tag: "add",
              ),
            ],
          )),
        ],
      ),
    );
  }
}
