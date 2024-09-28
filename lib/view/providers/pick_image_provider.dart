import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_rj_admin_panel/data/models/brand_model.dart';

import '../../repository/database_services_brand.dart';

class PickImageProvider extends ChangeNotifier {
  PlatformFile? _file;

  PlatformFile? get imageFile => _file;

  List<Uint8List> multiple_Files = [];

  //List<PlatformFile>?  get multiple_Files=>_multiple_Files;

  Future<void> pickImage(String tag,VoidCallback callBack) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      // print(result!.files);
      if (result != null) {
        _file = result.files.first;
        if(tag=="update") {
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

  Future<void> pickMultipleImages(VoidCallback callBack) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      //print(result!.files.length);
      if (result != null) {
        for (int i = 0; i < result.files.length; i++) {
          if (multiple_Files.length < 6) {
            multiple_Files.add(result.files[i].bytes!);
          } else {
            callBack();
          }
        }

        //print("result.files ${result.files ?? "ergf"}");
      }
    } catch (e) {
      print("Pick Multiple Image Exception ${e.toString()}");
    }
    notifyListeners();
  }

  deleteImageFromMultiple(int index) {
    multiple_Files.removeAt(index);
    notifyListeners();
  }
}
