import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/src/platform_file.dart';
import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/storage_image_model.dart';
import 'package:project_rj_admin_panel/services/common_services.dart';
import 'package:project_rj_admin_panel/view/providers/pick_image_provider.dart';
import 'package:project_rj_admin_panel/utils/common_methods.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class MultipleImagesWidget extends StatelessWidget {
  final String tag;
  final commonServices = CommonServices();

  MultipleImagesWidget({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PickImageProvider>(
      builder: (context, value, child) {
        return Container(
          height: 130,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: selectionColor, width: 0.5),
          ),
          child: value.imagesUrl == null || value.imagesUrl.isEmpty
              ? dummyList(context)
              : Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.center,
                  spacing: 5,
                  children: buildList(value.imagesUrl, context),
                ),
        );
      },
    );
  }

  Widget dummyList(BuildContext context) {
    return InkWell(
      onTap: () => context
          .read<PickImageProvider>()
          .pickMultipleImages(tag, () => moreThanSix(context),context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Center(
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo),
                      Text("Tap to Add images"),
                    ],
                  )),
      ),
    );
  }

  List<Widget> buildList(List<StorageImageModel> images, BuildContext context) {
    return List.generate(images.length, (index) {
      return InkWell(
        onTap: () {
          context
              .read<PickImageProvider>()
              .pickMultipleImages(tag, () => moreThanSix(context),context);
        },
        child: Container(
          height: 80,
          width: 40,
          padding: const EdgeInsets.all(1.0),
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(5.0)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Container(
                      margin: const EdgeInsets.only(top: 2.0, right: 2.0),
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),
                      child: InkWell(
                        onTap: () {
                          context
                              .read<PickImageProvider>()
                              .deleteImageFromMultiple(index);
                        },
                        child: const Icon(
                          Icons.close,
                          size: 7,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
              _getImage(images[index].downloadUrl),
            ],
          ),
        ),
      );
    });
  }

  moreThanSix(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Cannot select more-than 6 images"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("OK"))
            ],
          );
        });
  }

  _getImage(String file) {
    return ClipRRect(
        child: Image.network(
      file,
      fit: BoxFit.cover,
      scale: 5,
    ));
  }
}
