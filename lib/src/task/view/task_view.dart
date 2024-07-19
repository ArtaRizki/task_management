import 'dart:async';

import 'package:task_management/common/component/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management/common/component/custom_button.dart';
import 'package:task_management/common/component/custom_container.dart';
import 'package:task_management/common/component/custom_navigator.dart';
import 'package:task_management/src/task/view/task_add_view.dart';
import 'package:task_management/src/task/view/task_detail_view.dart';

import '../../../../common/base/base_state.dart';
import '../../../../common/component/custom_loading_indicator.dart';
import '../../../../common/component/custom_textfield.dart';
import '../../../../common/helper/constant.dart';
import '../../../../utils/utils.dart';
import '../provider/task_provider.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});
  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends BaseState<TaskView> {
  @override
  void initState() {
    final p = context.read<TaskProvider>();
    p.taskScrollC = ScrollController()..addListener(() {});
    p.fetchTaskLocal(withLoading: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskP = context.watch<TaskProvider>();

    Widget search() => CustomTextField.borderTextField(
          controller: taskP.taskSearchC,
          required: false,
          hintText: "Search",
          hintColor: Constant.textHintColor,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              'assets/icons/ic-search.png',
              width: 5,
              height: 5,
            ),
          ),
          onChange: (val) {
            if (taskP.searchOnStoppedTyping != null) {
              taskP.searchOnStoppedTyping!.cancel();
            }
            taskP.searchOnStoppedTyping = Timer(taskP.duration, () {
              taskP.taskScrollC?.jumpTo(0);
              taskP.fetchTaskLocal(withLoading: true);
            });
          },
        );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar.appBar(
        isLeading: false,
        titleSpacing: 16,
        context,
        "Task List",
        textStyle: TextStyle(
          fontWeight: Constant.semibold,
          color: Colors.black,
          fontSize: 20,
        ),
        action: [
          Container(
            margin: EdgeInsets.only(right: 8),
            height: 30,
            child: CustomButton.smallMainButton(
              'Sync API',
              () async {
                final p = context.read<TaskProvider>();
                await p.fetchTask(withLoading: true);
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: RefreshIndicator(
            color: Constant.primaryColor,
            onRefresh: () async {
              taskP.taskScrollC?.jumpTo(0);
              taskP.fetchTaskLocal(withLoading: true);
            },
            child: taskP.taskList.isEmpty
                ? Center(
                    child: Text('Tidak ada data, Silahkan Klik Sync API'),
                  )
                : ListView.separated(
                    controller: taskP.taskScrollC,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    itemCount: taskP.taskList.length,
                    separatorBuilder: (_, __) => Constant.xSizedBox12,
                    itemBuilder: (context, index) {
                      final item = taskP.taskList[index];
                      return InkWell(
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (item.id != null) {
                            await CusNav.nPush(context,
                                TaskDetailView(id: item.id ?? 0, data: item));
                            setState(() {});
                            taskP.taskScrollC?.jumpTo(0);
                            await taskP.fetchTaskLocal(withLoading: true);
                          }
                        },
                        child: CustomContainer.mainCard(
                          color: Colors.blue.shade50,
                          isShadow: true,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${index + 1}.',
                                  style: Constant.blackBold15),
                              Constant.xSizedBox16,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text((item.title ?? "Untitled"),
                                        style: Constant.blackBold),
                                    Text(
                                      item.completed == true
                                          ? "Selesai"
                                          : "Belum Selesai",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Task'),
        backgroundColor: Constant.primaryColor,
        foregroundColor: Colors.white,
        onPressed: () async {
          await CusNav.nPush(context, TaskAddView());
          taskP.taskScrollC?.jumpTo(0);
          taskP.fetchTaskLocal(withLoading: true);
        },
        icon: Icon(
          Icons.add,
          size: 25,
        ),
      ),
    );
  }
}
