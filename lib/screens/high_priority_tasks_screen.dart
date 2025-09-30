import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_widget.dart';

class HighPriorityTasksScreen extends StatefulWidget {
  const HighPriorityTasksScreen({super.key});

  @override
  State<HighPriorityTasksScreen> createState() => _HighPriorityTasksScreenState();
}

class _HighPriorityTasksScreenState extends State<HighPriorityTasksScreen> {
   dynamic task = [];

  @override
  void initState() {
    _loadTasks();
    super.initState();
  }

  void _loadTasks() async {
    final finalTask = PreferencesManager().getString("tasks");
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        task = taskAfterDecode
            .map((e) {
              return TaskModel.fromJson(e);
            })
            .where((element) => element.isHighPriority == true)
            .toList();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("High Priority Tasks"),),
      body: task.isEmpty
          ? Center(child: Text("No High Priority Tasks"))
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

                        final allData = PreferencesManager().getString('tasks');
                        if (allData != null) {
                          List<TaskModel> allDataList =
                              (jsonDecode(allData) as List<dynamic>)
                                  .map((e) => TaskModel.fromJson(e))
                                  .toList();
                          final int newIndex = allDataList.indexWhere(
                            (element) => element.id == task[index].id,
                          );
            
                          allDataList[newIndex] = task[index];
                          await PreferencesManager().setString("tasks", jsonEncode(allDataList));
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