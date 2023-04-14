import 'package:flutter/material.dart';

class Tasks {
  final int id;
  final String groop;
  final String taskTitle;
  final String time_start;
  final String time_end;

  const Tasks({
    required this.id,
    required this.taskTitle,
    required this.time_start,
    required this.time_end,
    required this.groop,
  });

  static Tasks fromJson(json) => Tasks(
      id: json['id'],
      taskTitle: json['taskTitle'],
      time_start: json['time_start'],
      time_end: json['time_end'],
      groop: json['groop']);
}
