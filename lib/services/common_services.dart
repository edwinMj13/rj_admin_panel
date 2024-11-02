import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/services/filter_services.dart';
import 'package:project_rj_admin_panel/view/providers/products_provider.dart';
import 'package:provider/provider.dart';

import '../view/providers/common_provider.dart';

class CommonServices {
   BuildContext? loadingProgress;

  static Widget showPlaceHolderImageinDataTable(
      ImageChunkEvent? loadingProgress, Widget child) {
    if (loadingProgress == null) return child;
    return const Icon(
      CupertinoIcons.cube,
      size: 20,
      color: Colors.grey,
    );
  }

  loadingDialogShow(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (contextQ) {
          loadingProgress = contextQ;
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  cancelLoading() {
    Navigator.of(loadingProgress!).pop();
  }

}
