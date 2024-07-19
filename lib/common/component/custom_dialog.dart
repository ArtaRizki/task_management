import 'package:flutter/material.dart';

import '../helper/constant.dart';

class CustomDialog {
  static Future woFormDialog(
      {required BuildContext context,
      required String title,
      bool dismissable = false,
      required Widget logPopUp}) {
    return showDialog(
      context: context,
      barrierDismissible: dismissable,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => dismissable,
          child: AlertDialog(
            title: Text(title,
                style: Constant.iPrimaryMedium8.copyWith(fontSize: 16)),
            content: logPopUp,
          ),
        );
      },
    );
  }
}
