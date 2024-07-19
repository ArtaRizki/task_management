import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:task_management/common/helper/constant.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task_management/src/splash_view.dart';
import 'package:task_management/src/task/provider/task_provider.dart';
import 'package:timeago/timeago.dart' as TIMEAGO;
import 'common/component/timezone.dart';

import 'utils/nav_observer.dart';
import 'dart:io';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'utils/utils.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

part 'common/routes.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  String initialRoute = '/';
  log("INITIAL ROUTE : $initialRoute");
  runApp(MyApp());
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<TaskProvider>(
                create: (context) => TaskProvider()),
          ],
          child: MaterialApp(
            title: 'Task Management',
            restorationScopeId: 'root',
            navigatorObservers: [XNObsever()],
            navigatorKey: NavigationService.navigatorKey,
            theme: Constant.mainThemeData,
            color: Constant.primaryColor,
            initialRoute: '/',
            routes: _routes,
            builder: (context, child) {
              child = EasyLoading.init()(
                  context, child); // assuming this is returning a widget
              log(MediaQuery.of(context).size.toString());
              return MediaQuery(
                child: child,
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.linear(1)),
              );
            },
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
