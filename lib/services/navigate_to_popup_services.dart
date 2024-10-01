import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/common_methods.dart';
import '../view/providers/brand_provider.dart';
import '../view/providers/home_provider.dart';
import '../view/widgets/popupcard_title_image_widget.dart';

class NavigateToPopupServices {
  static openPopup(BuildContext context) {
    String title=getScreenTag(context.read<HomeProvider>().index);
    String label=getScreenLabel(context.read<HomeProvider>().index);
    context.read<BrandProvider>().notifyWidgetListener();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>  AlertDialog(
        contentPadding: const EdgeInsets.all(0.0),
        content: PopupCardTitleImageWidget(
          title: title,
          labelText: label,
        ),),
    );
  }
}