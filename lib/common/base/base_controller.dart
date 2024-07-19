import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
// import 'package:task_management/src/auth/view/login_view.dart';

import '../../main.dart';
import '../../utils/utils.dart';
import '../component/custom_alert.dart';
import 'base_state.dart';

class BaseController<S extends BaseState> {
  List<StreamSubscription> streams = List.empty(growable: true);
  List<TextEditingController> controllers = List.empty(growable: true);
  SharedPreferences? _preferences;

  Future<SharedPreferences?> preferences() async {
    if (_preferences == null)
      _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  T registerStream<T extends StreamSubscription>(T stream) {
    streams.add(stream);
    return stream;
  }

  T registerController<T extends TextEditingController>(T c) {
    controllers.add(c);
    return c;
  }

  TextEditingController createTextController({String text = ''}) {
    return registerController(TextEditingController(text: text));
  }

  dispose() {
    streams.forEach((element) {
      element.cancel();
    });
    controllers.forEach((element) => element.dispose());
    controllers.clear();
    streams.clear();
    Utils.dismissLoading();
  }

  Future<String?> getToken() async {
    return (await preferences())!.getString('token');
  }

  Future<http.Response> get(String url,
      {Map? headers, Map<String, String?>? body}) async {
    Map<String, String> h = Map<String, String>();
    h.putIfAbsent('Connection', () => 'Keep-Alive');
    h.putIfAbsent('accept', () => 'application/json');
    var token = await getToken();
    if (token != null) h.putIfAbsent('Authorization', () => 'Bearer ' + token);
    if (headers != null) h.addAll(headers as Map<String, String>);

    final uri = Uri.parse(url);
    final bodyUri = Uri.https(uri.authority, uri.path, body);

    log("==== PARAMETERS ====");
    log("URL : $url");
    log("BODY: $bodyUri");
    Response response = await http.get(bodyUri, headers: h).timeout(
        Duration(minutes: 1),
        onTimeout: () => http.Response("Timeout", 504));
    log("RESPONSE GET $url : ${response.body}");
    log("====================");

    String log2 = "Log : " +
        "==== PARAMETERS ===="
            '\r\n' +
        "URL : $url"
            '\r\n' +
        "BODY: $bodyUri"
            '\r\n' +
        "RESPONSE GET $url : ${response.body}"
            '\r\n' +
        "===================="
            '\r\n';
    // if (kDebugMode) {
    // XenoLog("GET").save(log2, alwaysLog: true);
    // }
    Utils.dismissLoading();
    if (response.body.toLowerCase().contains("timeout")) {
      BuildContext? context = NavigationService.navigatorKey.currentContext;
      if (context != null) {
        CustomAlert.showSnackBar(context, 'Timeout', true);
        throw 'Timeout';
      }
    }
    if (response.body.toLowerCase().contains("unauthorized") ||
        response.body.toLowerCase().contains("missing authorization header")) {
      _preferences!.clear();
      BuildContext? context = NavigationService.navigatorKey.currentContext;
      if (context != null) {
        CustomAlert.showSnackBar(context, 'Harap Login Ulang', true);
        // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      }
    }
    if (response.body.toLowerCase().contains("refresh token tidak valid") ||
        response.body.toLowerCase().contains("refresh token kedaluarsa")) {
      BuildContext? context = NavigationService.navigatorKey.currentContext;
      _preferences!.clear();
      if (context != null) {
        CustomAlert.showSnackBar(context, 'Harap Login Ulang', true);
        // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      }
    }
    if (response.body.toLowerCase().contains("invalid token") ||
        response.body.toLowerCase().contains("expired token")) {
      BuildContext? context = NavigationService.navigatorKey.currentContext;
      if (context != null) {
        // await context.read<AuthProvider>().refreshToken();
        // if (url != 'http://103.59.94.19/turbines')
        await get(url, body: body);
        Utils.dismissLoading();
      }
    }

    if (response.body.toLowerCase().contains("unauthorized")) {
      // _preferences!.clear();
    }
    if (response.body.toLowerCase().contains("gateway time") ||
        response.body
            .toString()
            .toLowerCase()
            .contains("Internal Server Error")) {
      throw 'Internal Server Error';
    }

    return response;
  }

  Future<http.Response> post(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? body,
      List<http.MultipartFile>? files}) async {
    // log(body);
    Map<String, String> h = Map<String, String>();
    h.putIfAbsent('Connection', () => 'Keep-Alive');
    h.putIfAbsent('accept', () => 'application/json');
    var token = await getToken();
    if (token != null) h.putIfAbsent('Authorization', () => 'Bearer ' + token);
    if (headers != null) h.addAll(headers);

    if (files == null) {
      log("==== PARAMETERS ====");
      log("URL : $url");
      log("BODY : $body");
      Response response = await http
          .post(Uri.parse(url),
              headers: h, body: body, encoding: Encoding.getByName("utf-8"))
          .timeout(Duration(minutes: 1),
              onTimeout: () => http.Response("Timeout", 504));
      log("RESPONSE POST $url : ${response.body}");
      log("====================");

      String log2 = "Log : " +
          "==== PARAMETERS ===="
              '\r\n' +
          "URL : $url"
              '\r\n' +
          "BODY : $body"
              '\r\n' +
          "FILES : $files"
              '\r\n' +
          "RESPONSE POST $url : ${response.body}"
              '\r\n' +
          "===================="
              '\r\n';
      // if (kDebugMode) {
      // XenoLog("POST").save(log2, alwaysLog: true);
      // }Utils.dismissLoading();
      if (response.body.contains("timeout")) {
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        if (context != null) {
          CustomAlert.showSnackBar(context, 'Timeout', true);
          throw 'Timeout';
        }
      }
      if (response.body.contains("unauthorized") ||
          response.body.contains("missing authorization header")) {
        _preferences!.clear();
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        if (context != null) {
          CustomAlert.showSnackBar(context, 'Harap Login Ulang', true);
          // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      }
      if (response.body.contains("refresh token tidak valid") ||
          response.body.contains("refresh token kedaluarsa")) {
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        _preferences!.clear();
        if (context != null) {
          CustomAlert.showSnackBar(context, 'Harap Login Ulang', true);
          // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      }
      if (response.body.contains("invalid token") ||
          response.body.contains("expired token")) {
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        if (context != null) {
          // await context.read<AuthProvider>().refreshToken();
          await post(url, body: body);
          Utils.dismissLoading();
        }
      }
      if (response.body.toLowerCase().contains("unauthorized")) {
        // _preferences!.clear();
      }
      if (response.body.toLowerCase().contains("gateway time") ||
          response.body
              .toString()
              .toLowerCase()
              .contains("Internal Server Error")) {
        throw 'Internal Server Error';
      }
      return response;
    } else {
      var req = http.MultipartRequest("POST", Uri.parse(url));
      h.putIfAbsent("Content-Type", () => 'multipart/form-data');
      req.headers.addAll(h);
      if (body != null)
        req.fields
            .addAll(body.map((key, value) => MapEntry(key, value.toString())));
      req.files.addAll(files);
      log("==== PARAMETERS ====");
      log("URL : $url");
      log("BODY : $body");
      Response response = await http.Response.fromStream(await req.send())
          .timeout(Duration(minutes: 1),
              onTimeout: () => http.Response("Timeout", 504));
      log("RESPONSE POST FILE $url : ${response.body}");
      log("====================");

      String log2 = "Log : " +
          "==== PARAMETERS ===="
              '\r\n' +
          "URL : $url"
              '\r\n' +
          "BODY : $body"
              '\r\n' +
          "FILES : $files"
              '\r\n' +
          "RESPONSE POST $url : ${response.body}"
              '\r\n' +
          "===================="
              '\r\n';
      // if (kDebugMode) {
      // XenoLog("POST").save(log2, alwaysLog: true);
      // }Utils.dismissLoading();
      if (response.body.contains("timeout")) {
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        if (context != null) {
          CustomAlert.showSnackBar(context, 'Timeout', true);
          throw 'Timeout';
        }
      }
      if (response.body.contains("unauthorized") ||
          response.body.contains("missing authorization header")) {
        _preferences!.clear();
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        if (context != null) {
          CustomAlert.showSnackBar(context, 'Harap Login Ulang', true);
          // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      }
      if (response.body.contains("refresh token tidak valid") ||
          response.body.contains("refresh token kedaluarsa")) {
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        _preferences!.clear();
        if (context != null) {
          CustomAlert.showSnackBar(context, 'Harap Login Ulang', true);
          // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      }
      if (response.body.contains("invalid token") ||
          response.body.contains("expired token")) {
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        if (context != null) {
          // await context.read<AuthProvider>().refreshToken();
          await post(url, body: body);
          Utils.dismissLoading();
        }
      }

      if (response.body.toLowerCase().contains("unauthorized")) {
        // _preferences!.clear();
      }
      if (response.body.toLowerCase().contains("gateway time") ||
          response.body
              .toString()
              .toLowerCase()
              .contains("Internal Server Error")) {
        throw 'Internal Server Error';
      }
      return response;
    }
  }

  Future<http.Response> put(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? body,
      List<http.MultipartFile>? files}) async {
    // log(body);
    Map<String, String> h = Map<String, String>();
    h.putIfAbsent('Connection', () => 'Keep-Alive');
    h.putIfAbsent('accept', () => 'application/json');
    var token = await getToken();
    if (token != null) h.putIfAbsent('Authorization', () => 'Bearer ' + token);
    if (headers != null) h.addAll(headers);

    if (files == null) {
      log("==== PARAMETERS ====");
      log("URL : $url");
      log("BODY : $body");
      Response response = await http
          .put(Uri.parse(url),
              headers: h, body: body, encoding: Encoding.getByName("utf-8"))
          .timeout(Duration(minutes: 1),
              onTimeout: () => http.Response("Timeout", 504));
      log("RESPONSE PUT $url : ${response.body}");
      log("====================");

      String log2 = "Log : " +
          "==== PARAMETERS ===="
              '\r\n' +
          "URL : $url"
              '\r\n' +
          "BODY : $body"
              '\r\n' +
          "FILES : $files"
              '\r\n' +
          "RESPONSE PUT $url : ${response.body}"
              '\r\n' +
          "===================="
              '\r\n';
      // if (kDebugMode) {
      // XenoLog("POST").save(log2, alwaysLog: true);
      // }Utils.dismissLoading();
      if (response.body.contains("timeout")) {
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        if (context != null) {
          CustomAlert.showSnackBar(context, 'Timeout', true);
          throw 'Timeout';
        }
      }
      if (response.body.contains("unauthorized") ||
          response.body.contains("missing authorization header")) {
        _preferences!.clear();
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        if (context != null) {
          CustomAlert.showSnackBar(context, 'Harap Login Ulang', true);
          // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      }
      if (response.body.contains("refresh token tidak valid") ||
          response.body.contains("refresh token kedaluarsa")) {
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        _preferences!.clear();
        if (context != null) {
          CustomAlert.showSnackBar(context, 'Harap Login Ulang', true);
          // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      }
      if (response.body.contains("invalid token") ||
          response.body.contains("expired token")) {
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        if (context != null) {
          // await context.read<AuthProvider>().refreshToken();
          await post(url, body: body);
          Utils.dismissLoading();
        }
      }
      if (response.body.toLowerCase().contains("unauthorized")) {
        // _preferences!.clear();
      }
      if (response.body.toLowerCase().contains("gateway time") ||
          response.body
              .toString()
              .toLowerCase()
              .contains("Internal Server Error")) {
        throw 'Internal Server Error';
      }
      return response;
    } else {
      var req = http.MultipartRequest("PUT", Uri.parse(url));
      h.putIfAbsent("Content-Type", () => 'multipart/form-data');
      req.headers.addAll(h);
      if (body != null)
        req.fields
            .addAll(body.map((key, value) => MapEntry(key, value.toString())));
      req.files.addAll(files);
      log("==== PARAMETERS ====");
      log("URL : $url");
      log("BODY : $body");
      Response response = await http.Response.fromStream(await req.send())
          .timeout(Duration(minutes: 1),
              onTimeout: () => http.Response("Timeout", 504));
      log("RESPONSE PUT FILE $url : ${response.body}");
      log("====================");

      String log2 = "Log : " +
          "==== PARAMETERS ===="
              '\r\n' +
          "URL : $url"
              '\r\n' +
          "BODY : $body"
              '\r\n' +
          "FILES : $files"
              '\r\n' +
          "RESPONSE PUT $url : ${response.body}"
              '\r\n' +
          "===================="
              '\r\n';
      // if (kDebugMode) {
      // XenoLog("POST").save(log2, alwaysLog: true);
      // }Utils.dismissLoading();
      if (response.body.contains("timeout")) {
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        if (context != null) {
          CustomAlert.showSnackBar(context, 'Timeout', true);
          throw 'Timeout';
        }
      }
      if (response.body.contains("unauthorized") ||
          response.body.contains("missing authorization header")) {
        _preferences!.clear();
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        if (context != null) {
          CustomAlert.showSnackBar(context, 'Harap Login Ulang', true);
          // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      }
      if (response.body.contains("refresh token tidak valid") ||
          response.body.contains("refresh token kedaluarsa")) {
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        _preferences!.clear();
        if (context != null) {
          CustomAlert.showSnackBar(context, 'Harap Login Ulang', true);
          // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      }
      if (response.body.contains("invalid token") ||
          response.body.contains("expired token")) {
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        if (context != null) {
          // await context.read<AuthProvider>().refreshToken();
          await post(url, body: body);
          Utils.dismissLoading();
        }
      }

      if (response.body.toLowerCase().contains("unauthorized")) {
        // _preferences!.clear();
      }
      if (response.body.toLowerCase().contains("gateway time") ||
          response.body
              .toString()
              .toLowerCase()
              .contains("Internal Server Error")) {
        throw 'Internal Server Error';
      }
      return response;
    }
  }

  Future<http.Response> delete(String url,
      {Map? headers, Map<String, String?>? body}) async {
    Map<String, String> h = Map<String, String>();
    h.putIfAbsent('Connection', () => 'Keep-Alive');
    h.putIfAbsent('accept', () => 'application/json');
    var token = await getToken();
    if (token != null) h.putIfAbsent('Authorization', () => 'Bearer ' + token);
    if (headers != null) h.addAll(headers as Map<String, String>);

    final uri = Uri.parse(url);
    final bodyUri = Uri.https(uri.authority, uri.path, body);

    log("==== PARAMETERS ====");
    log("URL : $url");
    log("BODY: $bodyUri");
    Response response = await http.delete(bodyUri, headers: h).timeout(
        Duration(minutes: 1),
        onTimeout: () => http.Response("Timeout", 504));
    log("RESPONSE DELETE $url : ${response.body}");
    log("====================");

    String log2 = "Log : " +
        "==== PARAMETERS ===="
            '\r\n' +
        "URL : $url"
            '\r\n' +
        "BODY : $body"
            '\r\n' +
        "RESPONSE DELETE $url : ${response.body}"
            '\r\n' +
        "===================="
            '\r\n';
    // if (kDebugMode) {
    // XenoLog("DELETE").save(log2, alwaysLog: true);
    // }
    Utils.dismissLoading();
    if (response.body.toLowerCase().contains("timeout")) {
      BuildContext? context = NavigationService.navigatorKey.currentContext;
      if (context != null) {
        CustomAlert.showSnackBar(context, 'Timeout', true);
        throw 'Timeout';
      }
    }
    if (response.body.toLowerCase().contains("unauthorized") ||
        response.body.toLowerCase().contains("missing authorization header")) {
      // _preferences!.clear();
      BuildContext? context = NavigationService.navigatorKey.currentContext;
      if (context != null) {
        CustomAlert.showSnackBar(context, 'Harap Login Ulang', true);
        // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      }
    }
    if (response.body.toLowerCase().contains("refresh token tidak valid") ||
        response.body.toLowerCase().contains("refresh token kedaluarsa")) {
      BuildContext? context = NavigationService.navigatorKey.currentContext;
      _preferences!.clear();
      if (context != null) {
        CustomAlert.showSnackBar(context, 'Harap Login Ulang', true);
        // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      }
    }
    if (response.body.toLowerCase().contains("invalid token") ||
        response.body.toLowerCase().contains("expired token")) {
      BuildContext? context = NavigationService.navigatorKey.currentContext;
      if (context != null) {
        // await context.read<AuthProvider>().refreshToken();
        await delete(url, body: body);
        Utils.dismissLoading();
      }
    }

    if (response.body.toLowerCase().contains("unauthorized")) {
      // _preferences!.clear();
    }
    if (response.body.toLowerCase().contains("gateway time") ||
        response.body
            .toString()
            .toLowerCase()
            .contains("Internal Server Error")) {
      throw 'Internal Server Error';
    }
    return response;
  }

  loading(bool show) async {
    if (show)
      await Utils.showLoading();
    else
      await Utils.dismissLoading();
  }
}
