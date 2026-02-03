import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/task_viewmodel.dart';
import '../models/task_model.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTasks();
    });
  }

  void _loadTasks() {
    final authVM = context.read<AuthViewModel>();
    final taskVM = context.read<TaskViewModel>();
    if (authVM.currentUser != null) {
      taskVM.loadTasks(authVM.currentUser!.id);
    }
  }

  Future<void> _handleLogout() async {
    final authVM = context.read<AuthViewModel>();
    final taskVM = context.read<TaskViewModel>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc muốn đăng xuất?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await authVM.signOut();
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Homework':
        return const Color(0xFFB3E5FC);
      case 'Work':
        return const Color(0xFFC8E6C9);
      case 'Personal':
        return const Color(0xFFFFF9C4);
      case 'Shopping':
        return const Color(0xFFF8BBD0);
      case 'Health':
        return const Color(0xFFFFCCBC);
      default:
        return const Color(0xFFE0E0E0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () {},
        ),
        title: const Text(
          'List',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF00BCD4),
        elevation: 0,
        actions: [
          Consumer<AuthViewModel>(
            builder: (context, authVM, _) {
              return PopupMenuButton<String>(
                icon: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                onSelected: (value) {
                  if (value == 'logout') {
                    _handleLogout();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    enabled: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          authVM.currentUser?.displayName ?? 'User',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          authVM.currentUser?.email ?? '',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 20),
                        SizedBox(width: 8),
                        Text('Đăng xuất'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, taskVM, _) {
          if (taskVM.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF00BCD4)),
            );
          }

          if (taskVM.tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task_outlined, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  const Text('Không có task nào'),
                  const SizedBox(height: 8),
                  const Text('Nhấn + để thêm task mới'),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _loadTasks(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: taskVM.tasks.length,
              itemBuilder: (context, index) {
                final task = taskVM.tasks[index];
                return _TaskCard(
                  task: task,
                  color: _getCategoryColor(task.category),
                  onToggle: () =>
                      taskVM.toggleTaskComplete(task.id),
                  onDelete: () =>
                      _showDeleteDialog(task.id),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF00BCD4),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );
          if (result == true) _loadTasks();
        },
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.home, color: Color(0xFF00BCD4)),
              Icon(Icons.calendar_today, color: Colors.grey),
              SizedBox(width: 40),
              Icon(Icons.description, color: Colors.grey),
              Icon(Icons.settings, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog(String taskId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa task'),
        content: const Text('Bạn có chắc muốn xóa task này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      context.read<TaskViewModel>().deleteTask(taskId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã xóa task')),
      );
    }
  }
}

class _TaskCard extends StatelessWidget {
  final TaskModel task;
  final Color color;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const _TaskCard({
    required this.task,
    required this.color,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration:
              task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            task.description,
            style: TextStyle(
              decoration: task.isCompleted
                  ? TextDecoration.lineThrough
                  : null,
            ),
            ),
        ],
      ),
    );
  }
}
