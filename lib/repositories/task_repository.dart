// lib/repositories/task_repository.dart
import '../db/database_helper.dart';
import '../models/task.dart';

class TaskRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Task>> getTasks() async {
    return await _dbHelper.getTasks();
  }

  Future<void> updateTask(Task task) async {
    await _dbHelper.updateTask(task);
  }

  Future<void> deleteTask(String taskId) async {
    await _dbHelper.deleteTask(taskId);
  }

  Future<void> addTask(Task newTask) async {
      await _dbHelper.insertTask(newTask);
  }
}