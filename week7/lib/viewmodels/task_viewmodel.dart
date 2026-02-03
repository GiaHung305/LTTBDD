// lib/viewmodels/task_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/database_service.dart';

class TaskViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();

  List<TaskModel> _tasks = [];
  bool _isLoading = false;
  String _selectedCategory = 'All';

  // Getters
  List<TaskModel> get tasks {
    if (_selectedCategory == 'All') {
      return _tasks;
    }
    return _tasks.where((task) => task.category == _selectedCategory).toList();
  }

  List<TaskModel> get completedTasks {
    return tasks.where((task) => task.isCompleted).toList();
  }

  List<TaskModel> get incompleteTasks {
    return tasks.where((task) => !task.isCompleted).toList();
  }

  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;

  // Available categories
  List<String> get categories => [
    'All',
    'Homework',
    'Work',
    'Personal',
    'Shopping',
    'Health',
  ];

  // Set selected category
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Load all tasks for user
  Future<void> loadTasks(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _tasks = await _databaseService.getTasks(userId);
    } catch (e) {
      debugPrint('Error loading tasks: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add new task
  Future<void> addTask(TaskModel task) async {
    try {
      await _databaseService.insertTask(task);
      _tasks.insert(0, task);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding task: $e');
      rethrow;
    }
  }

  // Update existing task
  Future<void> updateTask(TaskModel task) async {
    try {
      await _databaseService.updateTask(task);
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating task: $e');
      rethrow;
    }
  }

  // Toggle task completion
  Future<void> toggleTaskComplete(String taskId) async {
    try {
      final index = _tasks.indexWhere((t) => t.id == taskId);
      if (index != -1) {
        final updatedTask = _tasks[index].copyWith(
          isCompleted: !_tasks[index].isCompleted,
        );
        await updateTask(updatedTask);
      }
    } catch (e) {
      debugPrint('Error toggling task: $e');
      rethrow;
    }
  }

  // Delete task
  Future<void> deleteTask(String taskId) async {
    try {
      await _databaseService.deleteTask(taskId);
      _tasks.removeWhere((t) => t.id == taskId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting task: $e');
      rethrow;
    }
  }

  // Clear all tasks (for logout)
  Future<void> clearTasks(String userId) async {
    try {
      await _databaseService.deleteAllTasks(userId);
      _tasks.clear();
      _selectedCategory = 'All';
      notifyListeners();
    } catch (e) {
      debugPrint('Error clearing tasks: $e');
    }
  }
}