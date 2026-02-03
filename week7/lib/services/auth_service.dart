import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  static const String _currentUserKey = 'current_user';
  static const String _usersDbKey = 'users_database';

  /* ================= USERS DATABASE ================= */

  Future<Map<String, String>> _getUsersDb() async {
    final prefs = await SharedPreferences.getInstance();
    final dbJson = prefs.getString(_usersDbKey);

    if (dbJson != null) {
      return Map<String, String>.from(jsonDecode(dbJson));
    }

    final defaultDb = {
      'test@uth.edu.vn': '123456',
    };
    await prefs.setString(_usersDbKey, jsonEncode(defaultDb));
    return defaultDb;
  }

  Future<void> _saveUsersDb(Map<String, String> usersDb) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usersDbKey, jsonEncode(usersDb));
  }

  /* ================= CURRENT USER ================= */

  Future<void> _saveCurrentUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, jsonEncode(user.toMap()));
  }

  Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_currentUserKey);
    if (json == null) return null;
    return UserModel.fromMap(jsonDecode(json));
  }

  Future<void> _clearCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  /* ================= AUTH ================= */

  Future<UserModel> signInWithEmail(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final usersDb = await _getUsersDb();
    final cleanEmail = email.trim().toLowerCase();
    final cleanPassword = password.trim();

    if (usersDb[cleanEmail] == cleanPassword) {
      final user = UserModel(
        id: cleanEmail.hashCode.toString(),
        email: cleanEmail,
        displayName: cleanEmail.split('@')[0].toUpperCase(),
        createdAt: DateTime.now(),
      );
      await _saveCurrentUser(user);
      return user;
    }

    throw Exception('Email hoặc mật khẩu không đúng');
  }

  Future<UserModel?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final user = UserModel(
      id: googleUser.id,
      email: googleUser.email,
      displayName: googleUser.displayName,
      photoUrl: googleUser.photoUrl,
      createdAt: DateTime.now(),
    );

    await _saveCurrentUser(user);
    return user;
  }

  Future<UserModel> signUp(String email, String password) async {
    final usersDb = await _getUsersDb();
    final cleanEmail = email.trim().toLowerCase();

    if (usersDb.containsKey(cleanEmail)) {
      throw Exception('Email đã tồn tại');
    }

    usersDb[cleanEmail] = password;
    await _saveUsersDb(usersDb);

    final user = UserModel(
      id: cleanEmail.hashCode.toString(),
      email: cleanEmail,
      displayName: cleanEmail.split('@')[0].toUpperCase(),
      createdAt: DateTime.now(),
    );

    await _saveCurrentUser(user);
    return user;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _clearCurrentUser();
  }
}
