import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/add_task.dart';
import 'package:tasky/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = 'Default';
  dynamic task = [];
  int totalTasks = 0;
  int doneTasks = 0;
  double percent = 0;
  @override
  void initState() {
    _loadTasks();
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("username") ?? '';
    setState(() {});
  }

  void _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final finalTask = prefs.getString("tasks");
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        task = taskAfterDecode.map((e) {
          return TaskModel.fromJson(e);
        }).toList();
        _calculateProgress();
      });

    }
  }

  _calculateProgress() {
    totalTasks = task.length;
    doneTasks = task.where((element) => element.isCompleted == true).length;
    percent = totalTasks == 0 ? 0 : doneTasks / totalTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddTask();
              },
            ),
          );
        },
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF15B86C),
        label: Text("Add New Task"),
        icon: Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: task.isEmpty
            ? Center(child: Text("No Tasks Added Yet"))
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/avatar.png",
                          ),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good Evening, $name",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "One task at a time. One step closer.",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Yuhuu, Your work is\nalmost done",
                      style: TextStyle(fontSize: 32),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Achieved Tasks",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "$doneTasks Out of $totalTasks Done",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Transform.rotate(
                                angle: -pi / 2,
                                child: CircularProgressIndicator(
                                  value: percent,
                                  backgroundColor: Color(0xFF6D6D6D),
                                  valueColor: AlwaysStoppedAnimation(
                                    Color(0xFF15B86C),
                                  ),
                                  strokeWidth: 4,
                                ),
                              ),
                              Text(
                                "${percent * 100 ~/ 1}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
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
                                  _calculateProgress();
                                });
                                final prefs =
                                    await SharedPreferences.getInstance();
                                final String encodedData = jsonEncode(
                                  task.map((e) => e.toJson()).toList(),
                                );
                                await prefs.setString("tasks", encodedData);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
