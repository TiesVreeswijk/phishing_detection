import 'package:flutter/material.dart';
import '../widgets/app_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //colors can be used throughout whole page so I can change easily if needed
    const primaryBlue = Color(0xFF3B6EF5);
    const textDark = Color(0xFF1F2937);
    const cardBorder = Color(0xFFD9DEE8);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F4F6),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Phishing Check',
          style: TextStyle(
            color: primaryBlue,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //pushNamed keeps the home page open as well so that people can "go back"
              Navigator.pushNamed(context, '/help');
            },
            icon: const Icon(Icons.info_outline, color: primaryBlue),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
      body: SafeArea(
        //makes it so the body is scrollable and children use the width of the page, so smaller phones also see all content
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Not sure if a message is safe?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: textDark,
                  ),
                ),
              ),
              const SizedBox(height: 22),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/upload');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Upload screenshot',
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
                    Navigator.pushNamed(context, '/screenshot-help');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryBlue,
                    side: const BorderSide(color: cardBorder),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'How to take a screenshot',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 34),

              const _InfoCard(
                title: 'What this app does',
                text: 'We look for warning signs in messages, emails, and websites.',
              ),

              const SizedBox(height: 18),

              const _InfoCard(
                title: 'What happens next',
                text: 'If something looks suspicious, we explain why and tell you what to do.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String text;

  const _InfoCard({
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF3B6EF5);
    const textDark = Color(0xFF1F2937);
    const textGray = Color(0xFF4B5563);
    const cardBorder = Color(0xFFD9DEE8);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cardBorder),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: primaryBlue,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: cardBorder),
          const SizedBox(height: 14),
          Text(
            text,
            style: const TextStyle(
              color: textGray,
              fontSize: 16,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}