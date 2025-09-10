import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/add_task.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = 'Default';
  dynamic task = [];
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/avatar.png"),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Evening, ${name}",
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
              Expanded(
                child: ListView.builder(
                  itemCount: task.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Container(
                        height: 56,
                        width: double.infinity,
                        child: Text(task[index].taskTitle),
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
