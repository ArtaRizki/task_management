import 'dart:io';
import 'package:flutter/material.dart';

class CustomImage{

  static ClipRRect imgCircular(double radius, Image image){
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: image,
    );
  }

}

class ImageDialog extends StatelessWidget {
  ImageDialog(this.path);
  final path;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Image.file(
          File(path ?? ""),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
