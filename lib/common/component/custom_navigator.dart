import 'package:flutter/material.dart';

class CusNav {
  static nPush(BuildContext context, Widget page) => Navigator.push(
      context,
      PageRouteBuilder(
          maintainState: true,
          pageBuilder: ((context, animation, secondaryAnimation) => page),
          transitionDuration: const Duration(seconds: 0),
          reverseTransitionDuration: Duration.zero));
  static nPushAndRemoveUntilWoAgree(BuildContext context, Widget page) =>
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
              maintainState: true,
              pageBuilder: ((context, animation, secondaryAnimation) => page),
              transitionDuration: const Duration(seconds: 0),
              reverseTransitionDuration: Duration.zero),
          ModalRoute.withName("wo_agree"));
  static nPushAndRemoveUntilWoReal(BuildContext context, Widget page) =>
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
              maintainState: true,
              pageBuilder: ((context, animation, secondaryAnimation) => page),
              transitionDuration: const Duration(seconds: 0),
              reverseTransitionDuration: Duration.zero),
          ModalRoute.withName("wo_real"));
  static nPopUntilWoAgree(BuildContext context) =>
      Navigator.popUntil(context, ModalRoute.withName("wo_agree"));
  static nPopUntilWoReal(BuildContext context) =>
      Navigator.popUntil(context, ModalRoute.withName("wo_real"));
  // static nPopUntilWoReal(BuildContext context) =>
  //     Navigator.popUntil(context, (route) {
  //       if (Route is WORealizationView) {
  //         (route.settings.arguments as Map)['value'] = true;
  //         return true;
  //       }
  //       return false;
  //     });

  static nPushReplace(BuildContext context, Widget page) =>
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) => page),
              transitionDuration: const Duration(seconds: 0),
              reverseTransitionDuration: Duration.zero));
  static nPop(BuildContext context, [Object? result]) =>
      Navigator.pop(context, result);
}
