import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

// ignore: must_be_immutable
class HighPriorityTasks extends StatefulWidget {
  List<TaskModel> task;
  Function() calculateProgress;
  HighPriorityTasks({
    super.key,
    required this.calculateProgress,
    required this.task,
  });

  @override
  State<HighPriorityTasks> createState() => _HighPriorityTasksState();
}

class _HighPriorityTasksState extends State<HighPriorityTasks> {
  int totalTasks = 0;
  int doneTasks = 0;
  double percent = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.task.isEmpty) {
      return SizedBox.shrink();
    }
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "High Priority Tasks",
              style: TextStyle(color: Color(0xFF15B86C), fontSize: 14),
            ),
          ),

          Stack(
            children: [
              SizedBox(height: 60),
              Positioned(
                bottom: 16,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.grey.shade500),
                  ),
                  child: Transform.rotate(
                    angle: pi / 4,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.arrow_upward, size: 30),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.task.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Checkbox(
                        value: widget.task[index].isCompleted,
                        onChanged: (value) async {
                          setState(() {
                            widget.task[index].isCompleted = value ?? false;
                          });

                          final allData = PreferencesManager().getString(
                            'tasks',
                          );
                          if (allData != null) {
                            List<TaskModel> allDataList =
                                (jsonDecode(allData) as List<dynamic>)
                                    .map((e) => TaskModel.fromJson(e))
                                    .toList();
                            final int newIndex = allDataList.indexWhere(
                              (element) => element.id == widget.task[index].id,
                            );

                            allDataList[newIndex] = widget.task[index];
                            await PreferencesManager().setString(
                              "tasks",
                              jsonEncode(allDataList),
                            );
                          }
                          widget.calculateProgress();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        activeColor: Color(0xFF15B86C),
                      ),
                      SizedBox(width: 8),
                      Text(
                        widget.task[index].taskTitle,
                        style: 
                        widget.task[index].isCompleted
                            ? Theme.of(context).textTheme.titleLarge
                            :
                        Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
