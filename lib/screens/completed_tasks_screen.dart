import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_widget.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreen();
}

class _CompletedTasksScreen extends State<CompletedTasksScreen> {
  dynamic task = [];

  @override
  void initState() {
    _loadTasks();
    super.initState();
  }

  void _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final finalTask = prefs.getString("tasks");
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        task = taskAfterDecode
            .map((e) {
              return TaskModel.fromJson(e);
            })
            .where((element) => element.isCompleted == true)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Completed Tasks"),centerTitle: true,),
      body: task.isEmpty
          ? Center(child: Text("No Completed Tasks"))
          : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
                padding: EdgeInsets.only(bottom: 60),
                itemCount: task.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: TaskWidget(
                      task: task[index],
                      onChanged: (value) async {
                        setState(() {
                          task[index].isCompleted = value ?? false;
                        });
                        final prefs = await SharedPreferences.getInstance();
                        final allData = prefs.getString('tasks');
                        if (allData != null) {
                          List<TaskModel> allDataList =
                              (jsonDecode(allData) as List<dynamic>)
                                  .map((e) => TaskModel.fromJson(e))
                                  .toList();
                          final int newIndex = allDataList.indexWhere(
                            (element) => element.id == task[index].id,
                          );
            
                          allDataList[newIndex] = task[index];
                          print("$newIndex .... $index");
                          await prefs.setString("tasks", jsonEncode(allDataList));
                          _loadTasks();
                        }
                      },
                    ),
                  );
                },
              ),
          ),
    );
  }
}
