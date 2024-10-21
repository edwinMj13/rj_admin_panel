import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';
import 'package:project_rj_admin_panel/data/models/storage_image_model.dart';
import 'package:project_rj_admin_panel/repository/common.dart';
import 'package:project_rj_admin_panel/services/common_services.dart';
import 'package:project_rj_admin_panel/utils/common_methods.dart';
import 'package:project_rj_admin_panel/utils/text_controllers.dart';

import '../../repository/database_services_brand.dart';

class PickImageProvider extends ChangeNotifier {
  PlatformFile? _file;
  PlatformFile? get imageFile => _file;

  List<StorageImageModel> _imagesUrl = [];
  List<StorageImageModel> get imagesUrl => _imagesUrl;

  List<Uint8List> multiple_Files = [];

  bool _imageLoading=false;
  bool get imageLoading=>_imageLoading;

  CommonServices commonServices = CommonServices();

  //List<PlatformFile>?  get multiple_Files=>_multiple_Files;

  List<Uint8List> bannerImages =[];

  List<String>? _bannerShowImages =[];
  List<String>? get bannerShowImages => _bannerShowImages;

  Future<void> pickImage(String tag, VoidCallback callBack) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      // print(result!.files);
      if (result != null) {
        _file = result.files.first;
        if (tag == "update") {
          callBack();
        }
        // print("Image ${_file ?? "ergf"}");
      }
    } catch (e) {
      print("Pick Image Exception ${e.toString()}");
    }
    notifyListeners();
  }

  fileSetToNull() {
    _file = null;
  }

  getBannerImagesToShow(List<String> images){
    _bannerShowImages = images;
  }

  Future<void> pickMultipleImages(String tag, VoidCallback callBack,BuildContext context) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        for (int i = 0; i < result.files.length; i++) {
          if (multiple_Files.length < 6) {
            multiple_Files.add(result.files[i].bytes!);
          } else {
            callBack();
          }
        }
        _imageLoading=true;
        commonServices.loadingDialogShow(context);
        await _addImages(tag).then((_){
          _imageLoading=false;
          commonServices.cancelLoading();
        });
        //print("result.files ${result.files ?? "ergf"}");
      }
    } catch (e) {
      print("Pick Multiple Image Exception ${e.toString()}");
    }
    notifyListeners();
  }

  Future<void> _addImages(String tag) async {
    if (tag == "update") {
      _imagesUrl.addAll(await getFirebaseStorageMULTIPLEImageUrl(
        multiple_Files,
        productName: productEDITNameController.text,
      ));
    } else {
      _imagesUrl = await getFirebaseStorageMULTIPLEImageUrl(
        multiple_Files,
        productName: productNameController.text,
      );
    }
  }

  deleteImageFromMultiple(int index) {
    _imagesUrl.removeAt(index);
    notifyListeners();
  }

  addToImages(List<dynamic> images){
    _imagesUrl= images.isNotEmpty ?getImageListFromDynamic(images) : [];
    print("_imageURL $_imagesUrl");
  }

}
