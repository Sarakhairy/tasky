import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
   AddTask({super.key});
  final TextEditingController taskTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, title: Text("Add Task")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Title",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: taskTitleController,
                decoration: InputDecoration(
                  hintText: "Finish UI design for login screen",
                  hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey[500]!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
