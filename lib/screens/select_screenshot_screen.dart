import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/app_nav_bar.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/privacy_info_card.dart';
import '../widgets/pulsing_action_circle.dart';
import 'home_screen.dart';
import 'review_screenshot_screen.dart';

class SelectScreenshotScreen extends StatelessWidget {
  const SelectScreenshotScreen({super.key});

  void _handleNavTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    }
  }

  void _openReviewScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ReviewScreenshotScreen(),
      ),
    );
  }

  void _browseFiles(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ReviewScreenshotScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                child: Column(
                  children: [
                    const _PageHeader(),
                    const SizedBox(height: 18),
                    _UploadActionSection(
                      onOpenGallery: () => _openReviewScreen(context),
                      onBrowseFiles: () => _browseFiles(context),
                    ),
                    const SizedBox(height: 26),
                    const PrivacyInfoCard(),
                  ],
                ),
              ),
            ),
            AppNavBar(
              currentIndex: 1,
              onTap: (index) => _handleNavTap(context, index),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Select Screenshot',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 27,
            height: 1.1,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 14),
        Text(
          'Pick an image from your device to\nbegin the security analysis.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 15,
            height: 1.4,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _UploadActionSection extends StatelessWidget {
  final VoidCallback onOpenGallery;
  final VoidCallback onBrowseFiles;

  const _UploadActionSection({
    required this.onOpenGallery,
    required this.onBrowseFiles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PulsingActionCircle(
          size: 220,
          icon: Icons.photo_library_rounded,
          title: 'Open Gallery',
          onTap: onOpenGallery,
        ),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: onBrowseFiles,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.folder_rounded,
                size: 16,
                color: AppColors.primary,
              ),
              SizedBox(width: 6),
              Text(
                'Browse Files',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}