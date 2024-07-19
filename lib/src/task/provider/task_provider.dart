import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/common/base/base_controller.dart';
import 'package:task_management/common/component/custom_alert.dart';
import 'package:task_management/common/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:task_management/src/task/model/task_model.dart';

import '../../../../common/base/base_response.dart';
import '../../../main.dart';
import '../../../utils/utils.dart';

class TaskProvider extends BaseController with ChangeNotifier {
  GlobalKey<FormState> createAssetKey = GlobalKey<FormState>();

  ScrollController? _taskScrollC;
  ScrollController? get taskScrollC => this._taskScrollC;
  set taskScrollC(ScrollController? value) => this._taskScrollC = value;

  Duration duration = const Duration(seconds: 2);
  Timer? _searchOnStoppedTyping;
  Timer? get searchOnStoppedTyping => this._searchOnStoppedTyping;

  set searchOnStoppedTyping(Timer? value) {
    this._searchOnStoppedTyping = value;
    notifyListeners();
  }

  bool _isFetching = false;
  bool get isFetching => this._isFetching;

  set isFetching(bool value) {
    this._isFetching = value;
  }

  int pageSize = 0;

  get getPageSize => this.pageSize;

  set setPageSize(pageSize) {
    this.pageSize;
  }

  TextEditingController titleC = TextEditingController();
  bool _completed = false;
  bool get completed => this._completed;

  set completed(bool value) => this._completed = value;
  TextEditingController taskSearchC = TextEditingController();

  FocusNode descNode = FocusNode();

  TaskModel? _categoryV;

  TaskModel? get categoryV => this._categoryV;

  set categoryV(TaskModel? value) {
    this._categoryV = value;
    notifyListeners();
  }

  List<TaskModel> _taskList = [];
  List<TaskModel> get taskList => this._taskList;
  set taskList(List<TaskModel> value) => this._taskList = value;

  // List<TaskModel> _taskListLocal = [];
  // List<TaskModel> get taskListLocal => this._taskListLocal;
  // set taskListLocal(List<TaskModel> value) => this._taskListLocal = value;

  TaskModel _taskDetail = TaskModel();
  TaskModel get taskDetail => this._taskDetail;
  set taskDetail(TaskModel value) => this._taskDetail = value;

  Future<void> fetchTaskLocal({bool withLoading = false}) async {
    if (!isFetching) {
      isFetching = true;
      if (withLoading) loading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var taskLocal = prefs.getString(Constant.kTaskList);
      if (taskLocal != null) {
        taskList = taskListFromJson(taskLocal);
        log("TASK LIST LOCAL : $taskLocal");
        notifyListeners();
      }
      isFetching = false;
      loading(false);
    }
  }

  Future<void> fetchTask({bool withLoading = false}) async {
    if (!isFetching) {
      try {
        taskList = [];
        isFetching = true;
        if (withLoading) loading(true);

        final response = await get(Constant.BASE_API_FULL + '/todos');

        if (response.statusCode == 201 || response.statusCode == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove(Constant.kTaskList);
          await prefs.setString(
              Constant.kTaskList, jsonEncode(taskListFromJson(response.body)));
          var taskLocal = prefs.getString(Constant.kTaskList);
          log("TASK LIST LOCAL : $taskLocal");
          final model = taskListFromJson(response.body);
          taskList = model;
          notifyListeners();
          if (withLoading) loading(false);
          isFetching = false;
        } else {
          final message = jsonDecode(response.body)["message"];
          loading(false);
          isFetching = false;
          throw Exception(message);
        }
      } catch (e) {
        final message = e.toString();
        loading(false);
        isFetching = false;
        throw Exception(message);
      }
    }
  }

  Future<void> fetchTaskDetail(int id) async {
    if (!isFetching) {
      try {
        taskDetail = TaskModel();
        isFetching = true;
        loading(true);
        final response = await get(Constant.BASE_API_FULL + '/todos/$id');

        if (response.statusCode == 201 || response.statusCode == 200) {
          final model = TaskModel.fromJson(jsonDecode(response.body));
          taskDetail = model;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          var taskLocal = prefs.getString(Constant.kTaskList);
          List<TaskModel> taskList = [];

          if (taskLocal != null) {
            taskList = taskListFromJson(taskLocal);
            int index = taskList.indexWhere((item) => item.id == id);
            if (index != -1) {
              titleC.text = taskList[index].title ?? '';
              completed = taskList[index].completed ?? false;
              log("TASKLIST $index : ${taskList[index].completed}");
            }
          }
          notifyListeners();
          loading(false);
          isFetching = false;
        } else {
          final message = jsonDecode(response.body)["message"];
          loading(false);
          isFetching = false;
          BuildContext? context = NavigationService.navigatorKey.currentContext;
          if (context != null) CustomAlert.showSnackBar(context, message, true);
          throw Exception(message);
        }
      } catch (e) {
        final message = e.toString();
        loading(false);
        isFetching = false;
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        if (context != null) CustomAlert.showSnackBar(context, message, true);
        throw Exception(message);
      }
    }
  }

  Future<void> addTask(BuildContext context) async {
    try {
      loading(true);
      if (titleC.text.isEmpty) throw 'Harap isi judul';
      FocusManager.instance.primaryFocus?.unfocus();
      Map<String, String> param = {
        'title': titleC.text,
        'completed': completed.toString(),
        'userId': '1',
      };
      final response =
          await post(Constant.BASE_API_FULL + '/todos', body: param);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final model = BaseResponse.from(response);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        var taskLocal = prefs.getString(Constant.kTaskList);
        List<TaskModel> taskList = [];
        if (taskLocal != null) {
          taskList = taskListFromJson(taskLocal);
          taskList.insert(
            0,
            TaskModel(
              id: taskDetail.id,
              userId: taskDetail.userId,
              title: titleC.text,
              completed: completed,
            ),
          );
          await prefs.setString(Constant.kTaskList, jsonEncode(taskList));
          var taskLocal2 = prefs.getString(Constant.kTaskList);
          log("TASK LIST LOCAL : $taskLocal2");
        }
        loading(false);
        await Utils.showSuccess(msg: "Sukses Tambah Data");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);
        titleC.clear();
        completed = false;
      } else {
        final message = jsonDecode(response.body)["message"];
        loading(false);
        throw Exception(message);
      }
    } catch (e) {
      final message = '$e';
      loading(false);
      CustomAlert.showSnackBar(context, message, true);
      throw Exception(message);
    }
  }

  Future<void> editTask(BuildContext context, int id) async {
    try {
      loading(true);
      if (titleC.text.isEmpty) throw 'Harap isi judul';
      FocusManager.instance.primaryFocus?.unfocus();
      Map<String, String> param = {
        'id': '${taskDetail.id ?? 0}',
        'title': titleC.text,
        'completed': completed.toString(),
        'userId': '${taskDetail.userId ?? 0}',
      };
      final response =
          await put(Constant.BASE_API_FULL + '/todos/$id', body: param);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final model = BaseResponse.from(response);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        var taskLocal = prefs.getString(Constant.kTaskList);
        List<TaskModel> taskList = [];
        if (taskLocal != null) {
          taskList = taskListFromJson(taskLocal);
          int index = taskList.indexWhere((item) => item.id == id);
          if (index != -1) {
            taskList[index] = TaskModel(
              id: taskDetail.id,
              userId: taskDetail.userId,
              title: titleC.text,
              completed: completed,
            );
            log("TASKLIST $index : ${taskList[index].completed}");
          }
          await prefs.setString(Constant.kTaskList, jsonEncode(taskList));
          var taskLocal2 = prefs.getString(Constant.kTaskList);
          log("TASK LIST LOCAL : $taskLocal2");
        }

        loading(false);
        await Utils.showSuccess(msg: "Sukses Edit Data");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);
        Navigator.pop(context);
        titleC.clear();
        completed = false;
      } else {
        final message = jsonDecode(response.body)["message"];
        loading(false);
        CustomAlert.showSnackBar(context, message, true);
        throw Exception(message);
      }
    } catch (e) {
      final message = '$e';
      loading(false);
      CustomAlert.showSnackBar(context, message, true);
      throw Exception(message);
    }
  }

  Future<void> deleteTask(BuildContext context, int id) async {
    try {
      loading(true);
      FocusManager.instance.primaryFocus?.unfocus();
      final response = await delete(Constant.BASE_API_FULL + '/todos/$id');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final model = BaseResponse.from(response);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        var taskLocal = prefs.getString(Constant.kTaskList);
        List<TaskModel> taskList = [];
        if (taskLocal != null) {
          taskList = taskListFromJson(taskLocal);
          taskList.removeWhere((item) => item.id == id);
          await prefs.setString(Constant.kTaskList, jsonEncode(taskList));
          var taskLocal2 = prefs.getString(Constant.kTaskList);
          log("TASK LIST LOCAL : $taskLocal2");
        }

        loading(false);
        await Utils.showSuccess(msg: "Sukses Hapus Tugas");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);
        titleC.clear();
        completed = false;
      } else {
        final message = jsonDecode(response.body)["message"];
        loading(false);

        CustomAlert.showSnackBar(context, message, true);
        throw Exception(message);
      }
    } catch (e) {
      final message = '$e';
      loading(false);

      CustomAlert.showSnackBar(context, message, true);
      throw Exception(message);
    }
  }

  Future<void> clearTaskForm() async {
    titleC.clear();
    completed = false;
  }
}
