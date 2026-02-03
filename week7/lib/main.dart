import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/task_viewmodel.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// 🔥 FIX QUAN TRỌNG Ở ĐÂY
        ChangeNotifierProvider(
          create: (_) => AuthViewModel()..loadCurrentUser(),
        ),

        ChangeNotifierProvider(
          create: (_) => TaskViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'UTH SmartTasks',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF00A896),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF00A896),
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF00A896),
            elevation: 0,
          ),
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authVM, _) {
        if (authVM.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF00A896),
              ),
            ),
          );
        }

        return authVM.currentUser == null
            ? const LoginScreen()
            : const HomeScreen();
      },
    );
  }
}
