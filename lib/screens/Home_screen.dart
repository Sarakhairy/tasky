// ignore: file_names
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/add_task.dart';
import 'package:tasky/screens/high_priority_tasks_screen.dart';
import 'package:tasky/widgets/high_priority_tasks_widget.dart';
import 'package:tasky/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = 'Default';
  String motivationQuote = "One task at a time. One step closer.";
  dynamic task = [];
  dynamic highPriorityTask = [];
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
    name = PreferencesManager().getString("username") ?? '';
    motivationQuote = PreferencesManager().getString("motivation_quote") ?? "One task at a time. One step closer.";

    setState(() {});
  }

  void _loadTasks() async {
    final finalTask = PreferencesManager().getString("tasks");
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        highPriorityTask = taskAfterDecode
            .map((e) {
              return TaskModel.fromJson(e);
            })
            .where((element) => element.isHighPriority == true)
            .toList();
        highPriorityTask = highPriorityTask.reversed.take(4).toList();
        task = taskAfterDecode.map((e) {
          return TaskModel.fromJson(e);
        }).toList();
        _calculateProgress();
      });
    }
  }

  Future<void> _calculateProgress() async {

    final finalTask = PreferencesManager().getString("tasks");
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      final allTasks = taskAfterDecode
          .map((e) => TaskModel.fromJson(e))
          .toList();

      setState(() {
        totalTasks = allTasks.length;
        doneTasks = allTasks.where((e) => e.isCompleted == true).length;
        percent = totalTasks == 0 ? 0 : doneTasks / totalTasks;
      });
    }
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
                              motivationQuote,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              backgroundColor: Color(
                                                0xFF6D6D6D,
                                              ),
                                              valueColor:
                                                  AlwaysStoppedAnimation(
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
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () async{
                                   await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return HighPriorityTasksScreen();
                                        },
                                      ),
                                    );
                                    _loadTasks();
                                  },
                                  child: HighPriorityTasks(
                                    task: highPriorityTask,
                                    calculateProgress: () async {
                                      _loadTasks();
                                      await _calculateProgress();
                                    },
                                  ),
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "My Tasks",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TaskWidget(
                                  task: task[index],
                                  onChanged: (value) async {
                                    setState(() {
                                      task[index].isCompleted = value ?? false;
                                      _calculateProgress();
                                    });
                                    final String encodedData = jsonEncode(
                                      task.map((e) => e.toJson()).toList(),
                                    );
                                    await PreferencesManager().setString("tasks", encodedData);
                                    _loadTasks();
                                    await _calculateProgress();
                                  },
                                ),
                              );
                            }, childCount: task.length),
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 60)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
