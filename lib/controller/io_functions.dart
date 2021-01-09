import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';

class IoFunctions {
  void saveOnGallery(File image) async {
    if (image != null && image.path != null) {
      GallerySaver.saveImage(image.path);
    }
  }
}