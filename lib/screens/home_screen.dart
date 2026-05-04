import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'routes_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = isDarkMode ? const Color(0xFF121212) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    
    final currentTime = DateFormat('hh:mm a').format(DateTime.now());

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.directions_bus, color: textColor),
            const SizedBox(width: 8),
            Text('BUTUAN TRANSIT', 
              // Fixed: Changed FontWeight.black to w900
              style: TextStyle(color: textColor, fontWeight: FontWeight.w900, fontSize: 20)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700), 
                  border: Border.all(color: Colors.black, width: 3),
                  boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(6, 6))],
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('MAAYONG ADLAW!', 
                          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.black)),
                        const Text('Where to\ntoday?', 
                          // Fixed: Changed FontWeight.black to w900
                          style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, height: 1.1, color: Colors.black)),
                        const SizedBox(height: 10),
                        Text('Butuan City • 32°C Sunny • $currentTime', 
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                      ],
                    ),
                    Positioned(
                      right: -10,
                      top: -10,
                      child: IconButton(
                        icon: Icon(isDarkMode ? Icons.light_mode : Icons.wb_sunny_outlined, color: Colors.black, size: 28),
                        onPressed: () {
                          setState(() {
                            isDarkMode = !isDarkMode;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 32),
              Text('QUICK ACTIONS', 
                // Fixed: Changed withOpacity to withValues(alpha: ...)
                style: TextStyle(color: textColor.withValues(alpha: 0.6), fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.5)),
              const SizedBox(height: 16),

              Row(
                children: [
                  _buildActionBox(
                    title: 'MAP',
                    subtitle: 'Find Routes',
                    color: const Color(0xFF0070CC), 
                    icon: Icons.map,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RoutesScreen()));
                    },
                  ),
                  const SizedBox(width: 16),
                  _buildActionBox(
                    title: 'FARES',
                    subtitle: 'Calculate',
                    color: const Color(0xFF00C853), 
                    icon: Icons.calculate,
                    onTap: () {
                      // Add fare logic later
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildActionBox(
                    title: 'AI ASK',
                    subtitle: 'Transit Help',
                    color: const Color(0xFFFF3D00), 
                    icon: Icons.auto_awesome,
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const AIChatScreen()));
                    },
                  ),
                  const SizedBox(width: 16),
                  _buildActionBox(
                    title: 'NEWS',
                    subtitle: 'Updates',
                    color: Colors.white,
                    textColor: Colors.black,
                    icon: Icons.campaign,
                    onTap: () {
                      // Add News logic later
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionBox({required String title, required String subtitle, required Color color, required IconData icon, required VoidCallback onTap, Color textColor = Colors.white}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.black, width: 3),
            boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: textColor, size: 28),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fixed: Changed FontWeight.black to w900
                  Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.w900, fontSize: 20)),
                  // Fixed: Changed withOpacity to withValues(alpha: ...)
                  Text(subtitle, style: TextStyle(color: textColor.withValues(alpha: 0.8), fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}