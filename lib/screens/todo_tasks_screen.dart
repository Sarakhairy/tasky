import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_widget.dart';

class TodoTasksScreen extends StatefulWidget {
  const TodoTasksScreen({super.key});

  @override
  State<TodoTasksScreen> createState() => _TodoTasksScreenState();
}

class _TodoTasksScreenState extends State<TodoTasksScreen> {
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
            .where((element) => element.isCompleted == false)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Do Tasks"),centerTitle: true,),
      body: task.isEmpty
          ? Center(child: Text("No To Do Tasks"))
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
