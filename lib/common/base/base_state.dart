import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'base_controller.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  // FirebaseManager firebaseManager = FirebaseManager();
  BaseController? baseC;
  StreamSubscription? firebaseSubs;

  reload({VoidCallback? f}) {
    setState(() {
      if (f != null) f.call();
    });
  }

  void pop() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    ///
  }

  setController<C extends BaseController>(C controller) {
    baseC = controller;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (baseC != null) baseC!.dispose();
    if (EasyLoading.isShow) loading(false);
    if (firebaseSubs != null) firebaseSubs!.cancel();
  }

  dynamic args() {
    return ModalRoute.of(context)?.settings.arguments;
  }

  loading(bool show) {
    if (show)
      EasyLoading.show(dismissOnTap: false);
    else
      EasyLoading.dismiss();
  }

  bool isLoading() {
    if (EasyLoading.isShow) return true;
    return false;
  }

  bool _isProcessing = false;

  isBusy() => _isProcessing;

  Future<void> handleTap(Future<void> Function() onTap) async {
    if (_isProcessing) return;
    _isProcessing = true;
    try {
      await onTap();
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }
}
