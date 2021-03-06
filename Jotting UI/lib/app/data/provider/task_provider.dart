import 'dart:convert';

import 'package:diary_ui/app/data/model/api_response.dart';
import 'package:diary_ui/app/data/model/task.dart';
import 'package:diary_ui/app/data/provider/database_provider.dart';
import 'package:http/http.dart' as http;

class TaskProvider {
  static Future<APIResponse<List<Task>>> getStudentTasks() async {
    return http
        .get(
      Uri.parse(DatabaseProvider.BASE_URL + '/api/task/student'),
      headers: DatabaseProvider.getHeaders(),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        Map<String, dynamic> mappedData = jsonData;
        List<dynamic> listedData = mappedData['data'];
        // List<dynamic> == List<Map<String, dynamic>>
        // var listedTask = [];
        // for (var i = 0; i < listedData.length; i++) {
        //   listedTask.add(Map<String, dynamic>.from(listedData[i]));
        // }
        final tasks = List.generate(
          listedData.length,
          (index) => Task.fromJsonMongo(listedData[index]),
        );
        return APIResponse<List<Task>>(data: tasks);
      } else {
        return APIResponse<List<Task>>(
          error: true,
          errorMessage: 'An error occured',
        );
      }
    }).catchError((_) => APIResponse<List<Task>>(
            error: true, errorMessage: 'An error occured'));
  }

  static Future<APIResponse<List<Task>>> getCourseTasks(String CourseId) async {
    return http
        .get(
      Uri.parse(DatabaseProvider.BASE_URL + '/api/task/course/' + CourseId),
      headers: DatabaseProvider.getHeaders(),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        Map<String, dynamic> mappedData = jsonData;
        List<dynamic> listedData = mappedData['data'];
        final tasks = List.generate(
          listedData.length,
          (index) => Task.fromJsonMongo(listedData[index]),
        );
        return APIResponse<List<Task>>(data: tasks);
      } else {
        return APIResponse<List<Task>>(
          error: true,
          errorMessage: 'An error occured',
        );
      }
    }).catchError((_) => APIResponse<List<Task>>(
            error: true, errorMessage: 'An error occured'));
  }

  static Future<APIResponse<Task>> getTask(String id) async {
    return http
        .get(
      Uri.parse(DatabaseProvider.BASE_URL + '/api/task/' + id),
      headers: DatabaseProvider.getHeaders(),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        Map<String, dynamic> taskMap = jsonData;
        final task = Task.fromJsonMongo(taskMap['data']);
        return APIResponse<Task>(data: task);
      } else {
        return APIResponse<Task>(
          error: true,
          errorMessage: 'An error occured',
        );
      }
    }).catchError((_) =>
            APIResponse<Task>(error: true, errorMessage: 'An error occured'));
  }

  static Future<APIResponse<String>> createStudentTask(Task task) async {
    return http
        .post(
      Uri.parse(DatabaseProvider.BASE_URL + '/api/task/student'),
      body: json.encode(task.toJsonExceptId()),
      headers: DatabaseProvider.getHeaders(),
    )
        .then((data) {
      if (data.statusCode == 201) {
        final jsonData = jsonDecode(data.body);
        Map<String, dynamic> taskMap = jsonData;
        final task = Task.fromJsonMongo(taskMap['data']);
        return APIResponse<String>(data: task.id);
      } else {
        return APIResponse<String>(
          error: true,
          errorMessage: 'An error occured',
        );
      }
    }).catchError((_) =>
            APIResponse<String>(error: true, errorMessage: 'An error occured'));
  }

  static Future<APIResponse<String>> createCourseTask(Task task) async {
    return http
        .post(
      Uri.parse(DatabaseProvider.BASE_URL + '/api/task/course'),
      body: json.encode(task.toJsonExceptId()),
      headers: DatabaseProvider.getHeaders(),
    )
        .then((data) {
      if (data.statusCode == 201) {
        final jsonData = jsonDecode(data.body);
        Map<String, dynamic> taskMap = jsonData;
        final task = Task.fromJsonMongo(taskMap['data']);
        return APIResponse<String>(data: task.id);
      } else {
        return APIResponse<String>(
          error: true,
          errorMessage: 'An error occured',
        );
      }
    }).catchError((_) =>
            APIResponse<String>(error: true, errorMessage: 'An error occured'));
  }

  static Future<APIResponse<bool>> updateTask(Task task) async {
    return http
        .put(
      Uri.parse(DatabaseProvider.BASE_URL + '/api/task/' + task.id),
      body: json.encode(task.toJsonExceptId()),
      headers: DatabaseProvider.getHeaders(),
    )
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      } else {
        return APIResponse<bool>(
          error: true,
          errorMessage: 'An error occured',
        );
      }
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  static Future<APIResponse<bool>> deleteTask(String id) async {
    return http
        .delete(
      Uri.parse(DatabaseProvider.BASE_URL + '/api/task/' + id),
      headers: DatabaseProvider.getHeaders(),
    )
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      } else {
        return APIResponse<bool>(
          error: true,
          errorMessage: 'An error occured',
        );
      }
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}
