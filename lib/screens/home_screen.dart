import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/app_nav_bar.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/home_action_card.dart';
import '../widgets/pulsing_action_circle.dart';
import 'select_screenshot_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleNavTap(BuildContext context, int index) {
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SelectScreenshotScreen(),
        ),
      );
    }
  }

  void _openSelectScreenshotScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const SelectScreenshotScreen(),
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
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                child: Column(
                  children: [
                    const _HeroSection(),
                    const SizedBox(height: 20),
                    _ScanButton(
                      onTap: () => _openSelectScreenshotScreen(context),
                    ),
                    const SizedBox(height: 18),
                    HomeActionCard(
                      icon: Icons.screenshot_monitor_rounded,
                      iconBg: AppColors.mint,
                      iconColor: AppColors.mintIcon,
                      title: 'Check Screenshot',
                      subtitle: 'Upload a capture of suspicious messages',
                      onTap: () => _openSelectScreenshotScreen(context),
                    ),
                    const SizedBox(height: 18),
                    HomeActionCard(
                      icon: Icons.shield_rounded,
                      iconBg: AppColors.green,
                      iconColor: AppColors.greenIcon,
                      title: 'Safe History',
                      subtitle: 'Review your last 12 verified links',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            AppNavBar(
              currentIndex: 0,
              onTap: (index) => _handleNavTap(context, index),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 8),
        Text(
          'Verify your digital\nsafety.',
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
          'Take a breath. We’ll look for phishing\nand threats.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 16,
            height: 1.35,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ScanButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ScanButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return PulsingActionCircle(
      size: 245,
      icon: Icons.cloud_upload_rounded,
      title: 'Start Scan',
      subtitle: 'TAP OR DRAG TO SCAN',
      onTap: onTap,
    );
  }
}