import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../widgets/custom_button.dart';
import 'forgot_password_screen.dart';

class ConfirmScreen extends StatelessWidget {
  final String email;
  final String verificationCode;
  final String password;

  const ConfirmScreen({
    Key? key,
    required this.email,
    required this.verificationCode,
    required this.password,
  }) : super(key: key);

  void _onSubmit(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      ForgotPasswordScreen.routeName,
      arguments: {
        'email': email,
        'verificationCode': verificationCode,
        'password': password,
      },
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Logo
              _buildLogo(),
              const SizedBox(height: 40),
              // Title
              const Text(
                'Confirm',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 15),
              // Description
              Text(
                AppStrings.confirmInfo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textLight,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              // Email Display
              _buildInfoField(
                icon: Icons.person_outline,
                text: email,
              ),
              const SizedBox(height: 20),
              // Verification Code Display
              _buildInfoField(
                icon: Icons.confirmation_number_outlined,
                text: verificationCode,
              ),
              const SizedBox(height: 20),
              // Password Display (masked)
              _buildInfoField(
                icon: Icons.lock_outline,
                text: '••••••••••',
              ),
              const SizedBox(height: 30),
              // Submit Button
              CustomButton(
                text: 'Summit',
                onPressed: () => _onSubmit(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Image.asset(
            'assets/images/logoUTH.png',
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          AppStrings.appName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.uthBlue,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoField({required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textLight),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}