import 'package:image_picker/image_picker.dart';

class Widgets{
  static Future<XFile?> takeSelfie() async {
    XFile? f = await ImagePicker().pickImage(
      source: ImageSource.camera,
      // maxWidth: 480,
      // maxHeight: 480,
      // imageQuality: 75,
      preferredCameraDevice: CameraDevice.rear,
    );
    return f;
  }

  static Future<XFile?> selectImageFromGallery() async {
    XFile? f = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 100,
    );
    return f;
  }
}