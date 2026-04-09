import 'dart:io';

import 'package:flutter/material.dart';

import '../models/analysis_result.dart';
import '../theme/app_colors.dart';
import '../widgets/app_nav_bar.dart';
import '../widgets/app_top_bar.dart';
import 'home_screen.dart';
import 'select_screenshot_screen.dart';

class SecureResultScreen extends StatelessWidget {
  final File imageFile;
  final AnalysisResult result;

  const SecureResultScreen({
    super.key,
    required this.imageFile,
    required this.result,
  });

  void _handleNavTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
      );
    } else if (index == 1) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const SelectScreenshotScreen()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final reasons = result.redFlags.take(3).toList();

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
                    _ScoreCircle(
                      score: result.confidence,
                      color: const Color(0xFF44C978),
                      icon: Icons.check_circle_rounded,
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Verified Secure',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 27,
                        height: 1.1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      result.summary,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 15,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _SectionCard(
                      title: 'Why we verified this',
                      icon: Icons.receipt_long_rounded,
                      children: [
                        for (final item in reasons)
                          _ReasonTile(
                            title: _secureTitleFromFlag(item),
                            description: item,
                            icon: Icons.verified_user_rounded,
                            iconColor: const Color(0xFF77BA8B),
                            iconBg: const Color(0xFFEAF6EE),
                          ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const _ActionInfoCard(
                      title: 'Safe to proceed',
                      subtitle:
                      'This analysis is complete. Choose your next step below.',
                    ),
                    const SizedBox(height: 14),
                    _MainBlueButton(
                      text: 'Delete Screenshot',
                      icon: Icons.delete_rounded,
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SelectScreenshotScreen(),
                          ),
                              (route) => false,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    _TextButtonAction(
                      text: 'Save Result',
                      icon: Icons.bookmark_rounded,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Save result not added yet')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            AppNavBar(
              currentIndex: 3,
              onTap: (index) => _handleNavTap(context, index),
            ),
          ],
        ),
      ),
    );
  }

  String _secureTitleFromFlag(String flag) {
    final lower = flag.toLowerCase();

    if (lower.contains('trusted') || lower.contains('sender')) {
      return 'Trusted Origin';
    }
    if (lower.contains('link') || lower.contains('domain')) {
      return 'Safe Content';
    }
    if (lower.contains('secure') || lower.contains('auth') || lower.contains('encrypt')) {
      return 'Encrypted Pathway';
    }
    return 'Verified Signal';
  }
}

class _ScoreCircle extends StatelessWidget {
  final int score;
  final Color color;
  final IconData icon;

  const _ScoreCircle({
    required this.score,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 110,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 92,
            height: 92,
            child: CircularProgressIndicator(
              value: score / 100,
              strokeWidth: 5,
              backgroundColor: color.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          Text(
            '$score',
            style: TextStyle(
              color: color,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          Positioned(
            right: 8,
            bottom: 16,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3F6),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}

class _ReasonTile extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const _ReasonTile({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12.5,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionInfoCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _ActionInfoCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3F6),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 13.5,
              height: 1.45,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _MainBlueButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const _MainBlueButton({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
      ),
    );
  }
}

class _TextButtonAction extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const _TextButtonAction({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16, color: AppColors.textDark),
      label: Text(
        text,
        style: const TextStyle(
          color: AppColors.textDark,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}