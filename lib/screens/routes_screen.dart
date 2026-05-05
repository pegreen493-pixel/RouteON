import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Routes & Zones',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DottedBorder(
            color: Colors.red,
            dashPattern: const [6, 3],
            borderType: BorderType.RRect,
            radius: const Radius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: Assistance Widget (Top Left)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.star, color: Colors.black, size: 24),
                        const SizedBox(width: 8),
                        // Use aiAsk asset or a fallback icon
                        Image.asset(
                          'assets/icons/aiAsk.png',
                          width: 32,
                          height: 32,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.smart_toy, size: 32),
                        ),
                        const SizedBox(width: 8),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Need Assistance?',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Section 2: Mode Selection List
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MapViewerScreen(
                              title: 'PUJ Routes',
                              imagePath: 'assets/Butuan_map.png',
                            ),
                          ),
                        );
                      },
                      child: const ModeCard(
                        title: 'PUJ',
                        subtitle: 'Routes',
                        imagePath: 'assets/images/Puj.png',
                      ),
                    ),
                    const SizedBox(height: 16),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MapViewerScreen(
                              title: 'Tricycle Zones',
                              imagePath: 'assets/Tricycle_map.png',
                            ),
                          ),
                        );
                      },
                      child: const ModeCard(
                        title: 'TRICYCLE',
                        subtitle: 'Zones',
                        imagePath: 'assets/images/Tricycle.png',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const ModeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
    );
  }
}

// ---------------------------------------------------------
// THE MAP VIEWER PAGE (Handles the flip and pinch-to-zoom)
// ---------------------------------------------------------
class MapViewerScreen extends StatelessWidget {
  final String title;
  final String imagePath;

  // Fixed: Added super.key
  const MapViewerScreen({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 1.0,
          maxScale: 5.0,
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
