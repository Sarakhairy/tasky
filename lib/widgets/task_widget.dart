
import 'package:flutter/material.dart';

import 'package:tasky/models/task_model.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task, this.onChanged});
  final TaskModel task;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 56,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: task.isCompleted,
            onChanged: onChanged,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            activeColor: Color(0xFF15B86C),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  task.taskTitle,
                  textAlign: TextAlign.center,
                  style: task.isCompleted
                            ? Theme.of(context).textTheme.titleLarge
                            :
                        Theme.of(context).textTheme.titleMedium,
                ),
                if(task.taskDescription.isNotEmpty) 
                    Text(
                        task.taskDescription,
                        style: 
                        task.isCompleted
                            ? Theme.of(context).textTheme.titleLarge
                            :
                        Theme.of(context).textTheme.titleMedium,
                      )
              ],
            ),
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}
