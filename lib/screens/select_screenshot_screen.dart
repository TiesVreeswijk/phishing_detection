import 'package:flutter/material.dart';

class SelectScreenshotScreen extends StatelessWidget {
  const SelectScreenshotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF3B6EF5);
    const textDark = Color(0xFF1F2937);
    const textGray = Color(0xFF4B5563);
    const screenBg = Color(0xFFF3F4F6);
    const cardBorder = Color(0xFFD9DEE8);

    return Scaffold(
      backgroundColor: screenBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: primaryBlue),
        ),
        title: const Text(
          'Select Screenshot',
          style: TextStyle(
            color: textDark,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Choose a screenshot from your phone.',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: open gallery / image picker
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Open Gallery',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryBlue,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: cardBorder),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const _TipsCard(
                title: 'Tips',
                tips: [
                  'Make sure the sender, link, or message is visible.',
                  'Use a clear screenshot, not a photo of the screen.',
                  'Crop out extra private information if possible.',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TipsCard extends StatelessWidget {
  final String title;
  final List<String> tips;

  const _TipsCard({
    required this.title,
    required this.tips,
  });

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF3B6EF5);
    const textGray = Color(0xFF4B5563);
    const cardBorder = Color(0xFFD9DEE8);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: primaryBlue,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: cardBorder),
          const SizedBox(height: 14),
          ...tips.map(
                (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                '• $tip',
                style: const TextStyle(
                  color: textGray,
                  fontSize: 15,
                  height: 1.35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}