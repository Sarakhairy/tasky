import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/home_screen.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController taskTitleController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  bool isHighPriority = false;

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, title: Text("Add Task")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Task Title",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: taskTitleController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter task title";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Finish UI design for login screen",
                          hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey[500]!),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Task Description",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        maxLines: 5,
                        controller: taskDescriptionController,
                        decoration: InputDecoration(
                          hintText:
                              "Finish onboarding UI and hand off to devs by Thursday.",
                          hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey[500]!),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "High Priority",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Switch(
                            value: isHighPriority,
                            onChanged: (value) {
                              isHighPriority = value;
                              setState(() {});
                            },
                            activeTrackColor: Color(0xFF15B86C),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  if (key.currentState!.validate()) {
                    final model = TaskModel(
                      id: DateTime.now().millisecondsSinceEpoch,
                      taskTitle: taskTitleController.text,
                      taskDescription: taskDescriptionController.text,
                      isHighPriority: isHighPriority,
                    );
                    final prefs = await SharedPreferences.getInstance();
                    final taskJson = prefs.getString('tasks');
                    List<dynamic> tasks = [];
                    if (taskJson != null) {
                      tasks = jsonDecode(taskJson);
                    }
                    tasks.add(model.toJson());
                    final taskEncoded = jsonEncode(tasks);
                    await prefs.setString('tasks', taskEncoded);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return HomeScreen();
                        },
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF15B86C),
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  foregroundColor: Colors.white,
                ),
                label: Text("Add Task"),
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
