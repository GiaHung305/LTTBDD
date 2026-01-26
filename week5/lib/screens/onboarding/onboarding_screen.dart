import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../models/onboarding_model.dart';
import '../../widgets/page_indicator.dart';
import '../../widgets/custom_button.dart';
import 'onboarding_page.dart';
import '../auth/forgot_password_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingModel> _pages = [
    OnboardingModel(
      title: AppStrings.onboarding1Title,
      description: AppStrings.onboarding1Description,
      imagePath: 'assets/images/onboarding1.png',
    ),
    OnboardingModel(
      title: AppStrings.onboarding2Title,
      description: AppStrings.onboarding2Description,
      imagePath: 'assets/images/onboarding2.png',
    ),
    OnboardingModel(
      title: AppStrings.onboarding3Title,
      description: AppStrings.onboarding3Description,
      imagePath: 'assets/images/onboarding3.png',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _completeOnboarding() {
    // Chuyển đến ForgotPasswordScreen khi click Get Started
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button (only show if not on first page)
                  _currentPage > 0
                      ? IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    onPressed: _previousPage,
                  )
                      : const SizedBox(width: 48),

                  // Page indicators
                  PageIndicator(
                    currentPage: _currentPage,
                    pageCount: _pages.length,
                  ),

                  // Skip button
                  TextButton(
                    onPressed: _completeOnboarding,
                    child: Text(
                      AppStrings.skip,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(model: _pages[index]);
                },
              ),
            ),

            // Bottom button
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      onPressed: _previousPage,
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      text: _currentPage == _pages.length - 1
                          ? AppStrings.getStarted
                          : AppStrings.next,
                      onPressed: _nextPage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}