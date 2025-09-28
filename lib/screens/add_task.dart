import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/main_screen.dart';
import 'package:tasky/widgets/custom_text_form_field.dart';
class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController taskTitleController = TextEditingController();
  List<dynamic> tasks = [];

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
                      CustomTextFormField(
                        title: "Task Title",
                        controller: taskTitleController,
                        hintText: "Finish UI design for login screen",
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter task title";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8),
                      CustomTextFormField(
                        title: "Task Description",
                        controller: taskDescriptionController,
                        hintText:
                            "Finish onboarding UI and hand off to devs by Thursday.",
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter task description";
                          }
                          return null;
                        },
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
                    final prefs = await SharedPreferences.getInstance();
                    final taskJson = prefs.getString('tasks');
                    if (taskJson != null) {
                      tasks = jsonDecode(taskJson);
                    }
                    final model = TaskModel(
                      id: tasks.length * 1,
                      taskTitle: taskTitleController.text,
                      taskDescription: taskDescriptionController.text,
                      isHighPriority: isHighPriority,
                    );
                    tasks.add(model.toJson());
                    final taskEncoded = jsonEncode(tasks);
                    await prefs.setString('tasks', taskEncoded);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return MainScreen();
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
