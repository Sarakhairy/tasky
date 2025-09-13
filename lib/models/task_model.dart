class TaskModel {
  final String taskTitle;
  final int id;
  final String taskDescription;
  final bool isHighPriority;
  bool isCompleted;
  TaskModel({
     required this.id,
    required this.taskTitle,
    required this.taskDescription,
    required this.isHighPriority,
    this.isCompleted = false,
  });
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ,
      taskTitle: json['taskTitle'],
      taskDescription: json['taskDescription'],
      isHighPriority: json['isHighPriority'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskTitle': taskTitle,
      'taskDescription': taskDescription,
      'isHighPriority': isHighPriority,
      'isCompleted': isCompleted,
    };
  }
}
