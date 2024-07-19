import 'package:task_management/common/base/base_state.dart';
import 'package:task_management/common/component/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/common/component/custom_container.dart';

import '../../../../common/helper/constant.dart';
import '../../../common/component/custom_navigator.dart';
import '../../../utils/utils.dart';
import '../model/task_model.dart';
import '../provider/task_provider.dart';
import 'task_add_view.dart';

class TaskDetailView extends StatefulWidget {
  final int id;
  final TaskModel data;

  const TaskDetailView({super.key, required this.id, required this.data});

  @override
  State<TaskDetailView> createState() => _TaskDetailViewState();
}

class _TaskDetailViewState extends BaseState<TaskDetailView> {
  @override
  void initState() {
    final p = context.read<TaskProvider>();
    p.fetchTaskDetail(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskDetail = context.watch<TaskProvider>().taskDetail;

    Widget content() {
      return CustomContainer.mainCard(
        color: Constant.tableBlueColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constant.xSizedBox4,
            // Text("ID : ${taskDetail.id}"),
            Text("ID : ${widget.data.id}"),
            Constant.xSizedBox4,
            // Text("USER ID : ${taskDetail.userId}"),
            Text("USER ID : ${widget.data.userId}"),
            Constant.xSizedBox4,
            // Text(taskDetail.title ?? 'Untitled', style: Constant.blackBold16),
            Text(widget.data.title ?? 'Untitled', style: Constant.blackBold16),
            Constant.xSizedBox4,
            // Text(taskDetail.completed == true ? "Selesai" : "Belum Selesai"),
            Text(widget.data.completed == true ? "Selesai" : "Belum Selesai"),
            Constant.xSizedBox4,
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar.appBar(
        context,
        "Detail Task",
        action: [
          IconButton(
            onPressed: () => CusNav.nPush(
              context,
              TaskAddView(data: taskDetail),
            ),
            icon: Icon(Icons.edit, color: Constant.primaryColor),
          ),
          IconButton(
            onPressed: () {
              Utils.showYesNoDialogWithWarning(
                  context: context,
                  title: "Konfirmasi Penghapusan",
                  desc: "Apakah anda yakin ingin\nmenghapus task yang dipilih?",
                  yesCallback: () async {
                    Navigator.pop(context);
                    await context
                        .read<TaskProvider>()
                        .deleteTask(context, widget.id);
                  },
                  noCallback: () async {
                    Navigator.pop(context);
                  });
            },
            icon: Icon(
              Icons.delete,
              color: Constant.redColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: Constant.primaryColor,
          onRefresh: () async =>
              await context.read<TaskProvider>().fetchTaskDetail(widget.id),
          child: taskDetail.id == null
              ? Center(child: Text('Memuat'))
              : ListView(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  children: [content()],
                ),
        ),
      ),
    );
  }
}
