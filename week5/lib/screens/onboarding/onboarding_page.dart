import 'package:flutter/material.dart';
import '../../models/onboarding_model.dart';
import '../../constants/colors.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          // Illustration
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: _buildIllustration(),
          ),
          const SizedBox(height: 50),
          // Title
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          // Description
          Text(
            model.description,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textLight,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    // Placeholder illustrations matching the design
    if (model.imagePath.contains('onboarding1')) {
      return _buildCalendarIllustration();
    } else if (model.imagePath.contains('onboarding2')) {
      return _buildChartIllustration();
    } else {
      return _buildNotificationIllustration();
    }
  }

  Widget _buildCalendarIllustration() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background decoration
          Positioned(
            bottom: 20,
            left: 20,
            child: Icon(Icons.eco, size: 40, color: AppColors.primary.withOpacity(0.3)),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Icon(Icons.eco, size: 40, color: AppColors.primary.withOpacity(0.3)),
          ),
          // Main calendar icon
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (i) =>
                      Container(
                        margin: const EdgeInsets.all(5),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (i) =>
                      Container(
                        margin: const EdgeInsets.all(5),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                  ),
                ),
              ],
            ),
          ),
          // Decorative papers
          Positioned(
            top: 30,
            right: 10,
            child: Icon(Icons.description, size: 40, color: Colors.grey.withOpacity(0.5)),
          ),
          Positioned(
            top: 80,
            left: 10,
            child: Icon(Icons.task_alt, size: 35, color: Colors.grey.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildChartIllustration() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background decoration
          Positioned(
            bottom: 20,
            left: 20,
            child: Icon(Icons.eco, size: 40, color: AppColors.primary.withOpacity(0.3)),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Icon(Icons.eco, size: 40, color: AppColors.primary.withOpacity(0.3)),
          ),
          // Main board
          Container(
            width: 200,
            height: 250,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                // Chart bars
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildBar(60, Colors.grey.shade300),
                    _buildBar(100, AppColors.primary),
                    _buildBar(80, Colors.grey.shade300),
                    _buildBar(40, Colors.grey.shade300),
                  ],
                ),
                const SizedBox(height: 20),
                // Circles
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) =>
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 3),
                        ),
                      ),
                  ),
                ),
                const SizedBox(height: 15),
                // Line chart
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomPaint(
                    painter: LineChartPainter(),
                  ),
                ),
              ],
            ),
          ),
          // People avatars
          Positioned(
            left: 10,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person, color: Colors.white, size: 30),
            ),
          ),
          Positioned(
            right: 10,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(double height, Color color) {
    return Container(
      width: 25,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _buildNotificationIllustration() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background decoration
          Positioned(
            bottom: 20,
            left: 20,
            child: Icon(Icons.eco, size: 40, color: AppColors.primary.withOpacity(0.3)),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Icon(Icons.eco, size: 40, color: AppColors.primary.withOpacity(0.3)),
          ),
          // Phone
          Container(
            width: 160,
            height: 280,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.black, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 15),
                // Status bar
                Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 20),
                // Notification card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.white, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Moon icon
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.nightlight_round, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.lineTo(size.width * 0.3, size.height * 0.3);
    path.lineTo(size.width * 0.6, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}