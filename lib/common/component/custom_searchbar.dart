import 'package:flutter/material.dart';

import 'custom_textfield.dart';

class CustomSearchBar {
  static Widget searchBarProduct(
      {required TextEditingController controller,
      VoidCallback? onTap,
      String? hint}) {
    return CustomTextField.normalTextField(
      controller: controller,
      hintText: hint ?? "Search Products...",
      prefixIcon: Icon(Icons.search),
      padding: EdgeInsets.zero,
      readOnly: true,
      onTap: onTap,
    );
  }
}
