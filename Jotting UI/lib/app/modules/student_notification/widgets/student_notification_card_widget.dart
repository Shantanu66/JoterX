import 'package:diary_ui/app/data/model/todo.dart';
import 'package:flutter/material.dart';

class StudentNotificationCardWidget extends StatelessWidget {
  final Todo todo;
  const StudentNotificationCardWidget({Key? key, required this.todo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      margin: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        // color: notification.CourseId == null ? Colors.white : Colors.blue[100],
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                todo.title.length > 30
                    ? todo.title.substring(0, 30) + '...'
                    : todo.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF211551),
                ),
              ),
              Spacer(),
              Text(
                todo.dueDate,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF211551),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              todo.description.length > 70
                  ? todo.description.substring(0, 70) + '...'
                  : todo.description,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF86829D),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
