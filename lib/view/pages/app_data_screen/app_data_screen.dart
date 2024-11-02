import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_rj_admin_panel/data/models/product_model.dart';
import 'package:project_rj_admin_panel/utils/common_methods.dart';
import 'package:project_rj_admin_panel/view/pages/app_data_screen/widgets/add_banner_image_widget.dart';
import 'package:project_rj_admin_panel/view/providers/app_data_provider.dart';
import 'package:project_rj_admin_panel/services/products_services/products_services.dart';
import 'package:project_rj_admin_panel/utils/constants.dart';
import 'package:project_rj_admin_panel/view/providers/products_provider.dart';
import 'package:provider/provider.dart';

import '../../../config/color.dart';
import '../../../data/models/storage_image_model.dart';
import '../../../utils/text_controllers.dart';
import '../../providers/banner_provider.dart';
import '../../providers/pick_image_provider.dart';
import '../../widgets/title_content_name_widget.dart';

class AppDataScreen extends StatefulWidget {
  AppDataScreen({super.key});

  @override
  State<AppDataScreen> createState() => _AppDataScreenState();
}

class _AppDataScreenState extends State<AppDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<BannerProvider>().getBannerProvider(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleContentNameWidget(title: "App Data"),
        sizedHeight40,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _setOfferSection(),
            const AddBannerImageWidget()
          ],
        )
      ],
    );
  }

  final _setOfferFormKey = GlobalKey<FormState>();

  OverlayEntry? _overLayEntry;

  // for overlaying the reference
  final LayerLink layerLink = LayerLink();

  @override
  void dispose() {
    super.dispose();
    _removeOverlay();
  } // to position the
  /*_onsearchChanged() {
    if (appDataProductSearchController.text.isNotEmpty) {
      print(appDataProductSearchController.text);
      context
          .read<ProductsProvider>()
          .getFilteredProducts(appDataProductSearchController.text);
        _showOverlay();
    } else {
      _removeOverlay();
    }
  }*/

  void _showOverlay() {
    _removeOverlay(); // Remove any existing overlay before inserting a new one
    _overLayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overLayEntry!);
  }

  void _removeOverlay() {
    _overLayEntry?.remove();
    _overLayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    // Find the position and size of the TextField
    final RenderBox renderBox =
    _setOfferFormKey.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) =>
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height, // Place it below the TextField
            width: size.width,
            child: Material(
              elevation: 4.0,
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 300, // Limit max height to allow scrolling
                ),
                child: ValueListenableBuilder(
                  valueListenable: AppDataProvider.filteredList,
                  builder: (context, value, _) {
                    return Scrollbar(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              appDataProductSearchController.text =
                                  value[index].itemName;
                              _removeOverlay(); // Close the overlay after selection
                              appDataProductMrpController.text =
                                  value[index].itemMrp;
                              appDataProductSalePriceController.text =
                                  value[index].sellingPrize;
                              context
                                  .read<AppDataProvider>()
                                  .selectedProduct(value[index]);
                            },
                            child: Text(
                              value[index].itemName,
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
    );
  }

  Container _setOfferSection() {
    return Container(
      height: 400,
      width: 350,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Set Offer",
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Search Product"),
              SizedBox(
                width: 150,
                child: Form(
                  key: _setOfferFormKey,
                  child: TextField(
                    controller: appDataProductSearchController,
                    decoration: const InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        context
                            .read<AppDataProvider>()
                            .getFilteredProducts(value);
                        _showOverlay();
                      } else {
                        _removeOverlay();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          sizedHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Mrp"),
              Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blueGrey,
                ),
                child: TextField(
                  controller: appDataProductMrpController,
                  enabled: false,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(5),
                  ),
                ),
              ),
            ],
          ),
          sizedHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Sale Price"),
              Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blueGrey,
                ),
                child: TextField(
                  controller: appDataProductSalePriceController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  enabled: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(5),
                  ),
                ),
              ),
            ],
          ),
          sizedHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Offer %"),
              SizedBox(
                width: 150,
                child: TextField(
                  controller: appDataProductOfferPercentController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.isNotEmpty &&
                        appDataProductSalePriceController.text.isNotEmpty) {
                      final lastAmt = int.parse(
                          appDataProductSalePriceController.text) -
                          (int.parse(appDataProductSalePriceController.text) /
                              100) *
                              int.parse(value);
                      appDataProductLastAmountController.text =
                          lastAmt.toStringAsFixed(2);
                    } else {
                      appDataProductLastAmountController.text = "";
                    }
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Offer",
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: Icon(Icons.percent)),
                ),
              ),
            ],
          ),
          sizedHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Last Amount"),
              Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blueGrey,
                ),
                child: TextField(
                  controller: appDataProductLastAmountController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  enabled: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(5),
                  ),
                ),
              ),
            ],
          ),
          sizedHeight10,
          ElevatedButton(
              onPressed: () {
                if (appDataProductOfferPercentController.text.isNotEmpty &&
                    appDataProductLastAmountController.text.isNotEmpty) {
                  context
                      .read<AppDataProvider>()
                      .updateProductDetailWithOffer(context);
                }
              },
              child: const Text("Save"))
        ],
      ),
    );
  }
}
