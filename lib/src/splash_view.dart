import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/common/component/custom_navigator.dart';
import '../common/helper/constant.dart';
import 'task/view/task_view.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    init();
    super.didChangeDependencies();
  }

  void init() async {
    await Timer(Duration(seconds: 0), () => CusNav.nPush(context, TaskView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text(
            'Memuat, Harap Tunggu',
            style: Constant.blackBold20,
          ),
        ),
      ),
    );
  }
}
