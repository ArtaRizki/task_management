import 'package:flutter/material.dart';

import '../helper/constant.dart';

class CustomButton {
  static Widget mainButton(String text, VoidCallback onClick,
      {Color? color,
      EdgeInsetsGeometry? margin,
      bool stretched = true,
      EdgeInsetsGeometry? contentPadding,
      TextStyle? textStyle,
      double? fontSize,
      BorderRadiusGeometry? borderRadius}) {
    return Padding(
      padding: margin ?? EdgeInsets.all(0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(color ?? Constant.primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(25))),
          elevation: MaterialStateProperty.all<double>(0),
        ),
        onPressed: onClick,
        child: Container(
          padding: contentPadding ?? EdgeInsets.all(8),
          alignment: stretched ? Alignment.center : null,
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  fontWeight: Constant.medium,
                  fontSize: fontSize ?? 16,
                  color: Colors.white,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  static Widget mainButtonWithIcon(
      Widget icon, String text, VoidCallback onClick,
      {Color? color,
      EdgeInsetsGeometry? margin,
      bool stretched = true,
      EdgeInsetsGeometry? contentPadding,
      TextStyle? textStyle,
      double? fontSize,
      BorderRadiusGeometry? borderRadius}) {
    return Padding(
      padding: margin ?? EdgeInsets.all(0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(color ?? Constant.primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(25))),
          elevation: MaterialStateProperty.all<double>(0),
        ),
        onPressed: onClick,
        child: Container(
          padding: contentPadding ?? EdgeInsets.all(8),
          alignment: stretched ? Alignment.center : null,
          child: Row(
            children: [
              icon,
              SizedBox(width: 4),
              Text(
                text,
                style: textStyle ??
                    TextStyle(
                      fontWeight: Constant.medium,
                      fontSize: fontSize ?? 16,
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget smallMainButton(String text, VoidCallback onClick,
      {Color? color,
      EdgeInsetsGeometry? margin,
      bool stretched = true,
      EdgeInsetsGeometry? contentPadding,
      TextStyle? textStyle,
      double? fontSize,
      BorderRadiusGeometry? borderRadius}) {
    return Padding(
      padding: margin ?? EdgeInsets.all(0),
      child: InkWell(
        onTap: onClick,
        child: Container(
          decoration: BoxDecoration(
              color: color ?? Constant.primaryColor,
              borderRadius: borderRadius ?? BorderRadius.circular(15)),
          padding: contentPadding ?? EdgeInsets.all(8),
          alignment: stretched ? Alignment.center : null,
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  fontWeight: Constant.medium,
                  fontSize: fontSize ?? 16,
                  color: Colors.white,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  static Widget smallMainButtonWithIcon(
      Widget icon, String text, VoidCallback onClick,
      {Color? color,
      EdgeInsetsGeometry? margin,
      bool stretched = true,
      EdgeInsetsGeometry? contentPadding,
      TextStyle? textStyle,
      double? fontSize,
      BorderRadiusGeometry? borderRadius}) {
    return Padding(
      padding: margin ?? EdgeInsets.all(0),
      child: InkWell(
        onTap: onClick,
        child: Container(
          decoration: BoxDecoration(
              color: color ?? Constant.primaryColor,
              borderRadius: borderRadius ?? BorderRadius.circular(25)),
          padding: contentPadding ?? EdgeInsets.all(8),
          alignment: stretched ? Alignment.center : null,
          child: Row(
            children: [
              icon,
              SizedBox(width: 2),
              Text(
                text,
                style: textStyle ??
                    TextStyle(
                      fontWeight: Constant.medium,
                      fontSize: fontSize ?? 16,
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget secondaryButton(String text, VoidCallback onClick,
      {EdgeInsetsGeometry? margin,
      bool stretched = true,
      EdgeInsetsGeometry? contentPadding,
      TextStyle? textStyle,
      BorderRadiusGeometry? borderRadius}) {
    return Padding(
      padding: margin ?? EdgeInsets.all(0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(25),
              side: BorderSide(color: Constant.primaryColor, width: 2),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(0),
        ),
        onPressed: onClick,
        child: Container(
          padding: contentPadding ?? EdgeInsets.all(8),
          alignment: stretched ? Alignment.center : null,
          child: Center(
            child: Text(
              text,
              style: textStyle ??
                  TextStyle(
                    color: Constant.primaryColor,
                    fontWeight: Constant.medium,
                    fontSize: 16,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  static Widget secondaryButtonWithicon(
    Widget icon,
    String text,
    VoidCallback onClick, {
    Color? borderColor,
    EdgeInsetsGeometry? margin,
    bool stretched = true,
    EdgeInsetsGeometry? contentPadding,
    TextStyle? textStyle,
    double? fontSize,
    double? borderWidth,
    BorderRadiusGeometry? borderRadius,
    MainAxisAlignment? mainAxisAlignment,
  }) {
    return Padding(
      padding: margin ?? EdgeInsets.all(0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(25),
              side: BorderSide(
                color: borderColor ?? Constant.primaryColor,
                width: borderWidth ?? 2,
              ),
            ),
          ),
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
          elevation: MaterialStateProperty.all<double>(0),
        ),
        onPressed: onClick,
        child: Container(
          padding: contentPadding ?? EdgeInsets.all(8),
          alignment: stretched ? Alignment.center : null,
          child: Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            children: [
              icon,
              SizedBox(width: 4),
              Text(
                text,
                style: textStyle ??
                    TextStyle(
                      color: borderColor,
                      fontWeight: Constant.medium,
                      fontSize: fontSize ?? 16,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget secondaryButtonBlack(String text, VoidCallback onClick,
      {EdgeInsetsGeometry? margin, BorderRadiusGeometry? borderRadius}) {
    return Padding(
      padding: margin ?? EdgeInsets.all(0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12.0),
              side: BorderSide(color: Colors.black),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(0),
        ),
        onPressed: onClick,
        child: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: Constant.medium,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  static Widget logoutButton(String text, VoidCallback onClick,
      {EdgeInsetsGeometry? margin}) {
    return Padding(
      padding: margin ?? EdgeInsets.all(0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.red),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(0),
        ),
        onPressed: onClick,
        child: Container(
          padding: EdgeInsets.all(12),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.red,
              fontWeight: Constant.medium,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  static Widget absentButton(
    String tag,
    Color color,
    VoidCallback callback,
  ) {
    return ElevatedButton(
      child: Container(
        width: 80,
        child: Text(
          tag,
          style: TextStyle(
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      onPressed: callback,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          color,
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.only(
            right: 8,
            left: 8,
          ),
        ),
        elevation: MaterialStateProperty.all(1),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
