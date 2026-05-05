import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingCard(),
            SizedBox(height: 24),
            Text(
              'QUICK ACTIONS',
              style: TextStyle(
                color: Color(0xFF2E2E2E), // Dark Gray
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 16),
            QuickActionsGrid(),
          ],
        ),
      ),
    );
  }
}

class GreetingCard extends StatelessWidget {
  const GreetingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFFF6026),
          width: 2,
        ), // Primary Orange
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MAAYONG ADLAW!',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Icon(Icons.wb_sunny, color: Color(0xFFFF6026), size: 16),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Where do you\nwant to go?',
            style: TextStyle(
              color: Color(0xFFFF6026),
              fontWeight: FontWeight.bold,
              fontSize: 28,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                child: Text(
                  'Butuan City • 32°C Sunny • 04:31 PM',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Image.asset(
                'assets/icons/logo_divider.png',
                width: 120,
                height: 30,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final List<Color> gradientColors;

  const ActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            width: 40,
            height: 40,
            color: Colors.white, // This ensures the PNG turns white
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        ActionCard(
          title: 'MAP',
          subtitle: 'Find Routes',
          imagePath: 'assets/icons/maps.png',
          gradientColors: [Color(0xFF4DB6FF), Color(0xFF18A0FB)],
        ),
        ActionCard(
          title: 'FEES',
          subtitle: 'Calculate',
          imagePath: 'assets/icons/fees.png',
          gradientColors: [Color(0xFFA6E464), Color(0xFF81D135)],
        ),
        ActionCard(
          title: 'AI ASK',
          subtitle: 'AI Assistance',
          imagePath: 'assets/icons/aiAsk.png',
          gradientColors: [Color(0xFFFF885A), Color(0xFFFF6026)],
        ),
        ActionCard(
          title: 'NEWS',
          subtitle: 'Intes Updates',
          imagePath: 'assets/icons/news.png',
          gradientColors: [Color(0xFF595959), Color(0xFF2E2E2E)],
        ),
      ],
    );
  }
}
