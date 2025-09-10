class TaskModel {
  final String taskTitle;
  final String taskDescription;
  final bool isHighPriority;

  TaskModel({
    required this.taskTitle,
    required this.taskDescription,
    required this.isHighPriority,
  });
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskTitle: json['taskTitle'],
      taskDescription: json['taskDescription'],
      isHighPriority: json['isHighPriority'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'taskTitle': taskTitle,
      'taskDescription': taskDescription,
      'isHighPriority': isHighPriority,
    };
  }
}
