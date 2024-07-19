import 'package:flutter/material.dart';
import 'package:task_management/utils/utils.dart';
import 'package:provider/provider.dart';
import '../../../common/base/base_state.dart';
import '../../../common/component/custom_textfield.dart';
import '../../../common/helper/constant.dart';
import '../../../common/component/custom_appbar.dart';
import '../../../common/component/custom_button.dart';
import '../model/task_model.dart';
import '../provider/task_provider.dart';

class TaskAddView extends StatefulWidget {
  TaskAddView({super.key, this.data});
  TaskModel? data;

  @override
  State<TaskAddView> createState() => _TaskAddViewState();
}

class _TaskAddViewState extends BaseState<TaskAddView> {
  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    if (widget.data == null) {
      final p = context.read<TaskProvider>();
      p.titleC.clear();
      p.completed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<TaskProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.data != null
          ? CustomAppBar.appBar(context, "Edit Task")
          : CustomAppBar.appBar(context, "Add Task"),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(children: [
            Expanded(
              child: ListView(
                children: [
                  Text("Input Data Task", style: Constant.blackBold20),
                  Constant.xSizedBox8,
                  Text("Masukkan data task pada field dibawah",
                      style: Constant.grayMedium),
                  Constant.xSizedBox16,
                  CustomTextField.borderTextField(
                    controller: p.titleC,
                    textInputType: TextInputType.name,
                    labelText: "Judul",
                  ),
                  Constant.xSizedBox16,
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: p.completed,
                          onChanged: (check) {
                            context.read<TaskProvider>().completed =
                                check ?? false;
                            setState(() {});
                          },
                        ),
                      ),
                      Constant.xSizedBox8,
                      Text('Completed'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: widget.data != null
                  ? CustomButton.mainButton(
                      'Submit',
                      () async {
                        final p = context.read<TaskProvider>();
                        FocusManager.instance.primaryFocus?.unfocus();
                        String? msg;
                        await Utils.showYesNoDialog(
                            context: context,
                            title: "Konfirmasi",
                            desc: "Apakah Data Anda Sudah Benar?",
                            yesCallback: () => handleTap(() async {
                                  if (widget.data?.id != null)
                                    Navigator.pop(context);
                                  await p.editTask(
                                      context, widget.data?.id ?? 0);
                                }),
                            noCallback: () => Navigator.pop(context));
                      },
                    )
                  : CustomButton.mainButton(
                      'Submit',
                      () async {
                        final p = context.read<TaskProvider>();
                        FocusManager.instance.primaryFocus?.unfocus();
                        await Utils.showYesNoDialog(
                            context: context,
                            title: "Konfirmasi",
                            desc: "Apakah Data Anda Sudah Benar?",
                            yesCallback: () => handleTap(() async {
                                  Navigator.pop(context);
                                  if (widget.data != null)
                                    p.editTask(context, widget.data?.id ?? 0);
                                  else
                                    p.addTask(context);
                                }),
                            noCallback: () => Navigator.pop(context));
                      },
                    ),
            ),
          ])),
    );
  }
}
