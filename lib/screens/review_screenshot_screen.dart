import 'dart:io';

import 'package:flutter/material.dart';

import '../models/analysis_result.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';
import '../widgets/app_nav_bar.dart';
import '../widgets/app_top_bar.dart';
import 'home_screen.dart';
import 'phishing_result_screen.dart';
import 'secure_result_screen.dart';
import 'select_screenshot_screen.dart';

class ReviewScreenshotScreen extends StatefulWidget {
  final File imageFile;

  const ReviewScreenshotScreen({
    super.key,
    required this.imageFile,
  });

  @override
  State<ReviewScreenshotScreen> createState() => _ReviewScreenshotScreenState();
}

class _ReviewScreenshotScreenState extends State<ReviewScreenshotScreen> {
  bool _isLoading = false;
  String? _error;

  void _handleNavTap(BuildContext context, int index) {
    if (_isLoading) return;

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

  Future<void> _checkScreenshot(BuildContext context) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final AnalysisResult result =
      await ApiService.analyzeScreenshot(widget.imageFile);

      if (!context.mounted) return;

      if (result.isLegitimate) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SecureResultScreen(
              imageFile: widget.imageFile,
              result: result,
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => PhishingResultScreen(
              imageFile: widget.imageFile,
              result: result,
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _chooseAnother(BuildContext context) {
    if (_isLoading) return;

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
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                child: Column(
                  children: [
                    const _PageHeader(),
                    const SizedBox(height: 26),
                    _ScreenshotPreviewCard(imageFile: widget.imageFile),
                    const SizedBox(height: 20),
                    if (_error != null) ...[
                      Text(
                        _error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    _PrimaryActionButton(
                      text: _isLoading
                          ? 'Checking screenshot...'
                          : 'Check this screenshot',
                      onTap: () => _checkScreenshot(context),
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 12),
                    _SecondaryActionButton(
                      text: 'Choose Another',
                      onTap: () => _chooseAnother(context),
                      isDisabled: _isLoading,
                    ),
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
          'Review Screenshot',
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
          'Let’s verify the security of this image.\nEnsure all details are visible before we\nbegin the analysis.',
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

class _ScreenshotPreviewCard extends StatelessWidget {
  final File imageFile;

  const _ScreenshotPreviewCard({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        height: 300,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: const Color(0xFFF0F2F4),
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: Color(0xFF6FA8D3),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;

  const _PrimaryActionButton({
    required this.text,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: isLoading
            ? const SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.4,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _SecondaryActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isDisabled;

  const _SecondaryActionButton({
    required this.text,
    required this.onTap,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: isDisabled ? null : onTap,
        icon: const Icon(Icons.photo_library_rounded, size: 18),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xFFD7DDE2),
          foregroundColor: const Color(0xFF5F6973),
          disabledBackgroundColor: const Color(0xFFD7DDE2),
          disabledForegroundColor: const Color(0xFF8E98A3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }
}