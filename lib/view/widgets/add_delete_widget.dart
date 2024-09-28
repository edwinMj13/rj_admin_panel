import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/services/navigate_to_popup_services.dart';
import 'package:project_rj_admin_panel/view/providers/brand_provider.dart';
import 'package:project_rj_admin_panel/view/providers/home_provider.dart';
import 'package:project_rj_admin_panel/view/widgets/popupcard_title_image_widget.dart';
import 'package:provider/provider.dart';

import '../../utils/common_methods.dart';
import '../../utils/constants.dart';
import 'custom_icon_button.dart';

class AddDeleteWidget extends StatelessWidget {
  const AddDeleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: secondaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Row(
            children: [
              Elev_Custom_IconButton(
                callback: () => NavigateToPopupServices.openPopup(context),
                icon: Icons.add,
                buttonText: "Create New",
                backgroundColor: primaryColor,
                textColor: secondaryColor,
                iconColor: secondaryColor,
              ),
              sizedWidth10,
              /*Elev_Custom_IconButton(
                callback: () => openPopup(context),
                icon: Icons.delete,
                buttonText: 'Delete',
                backgroundColor: deleteColor,
                textColor: Colors.red,
                iconColor: Colors.red,
              ),*/
            ],
          ),
        ],
      ),
    );


  }
}
