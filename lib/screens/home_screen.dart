import 'package:flutter/material.dart';
import '../theme/miffy_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 1. VIBRANT WELCOME BANNER ---
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD500), // Bright Miffy Yellow
              border: Border.all(color: Colors.black, width: 3),
              boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(6, 6))],
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('MAAYONG ADLAW!', style: MiffyStyle.overline.copyWith(color: Colors.black87, fontSize: 14)),
                    const Icon(Icons.wb_sunny, color: Colors.black, size: 20),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Where to\ntoday?',
                  style: MiffyStyle.headerBlack.copyWith(color: Colors.black, fontSize: 36, height: 1.0),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          Text('QUICK ACTIONS', style: MiffyStyle.overline.copyWith(color: Colors.black54)),
          const SizedBox(height: 12),

          // --- 2. COLORFUL ACTION GRID ---
          Row(
            children: [
              Expanded(child: _buildActionCard('MAP', 'Find Routes', Icons.map, const Color(0xFF0066CC), Colors.white)), // Blue
              const SizedBox(width: 16),
              Expanded(child: _buildActionCard('FARES', 'Calculate', Icons.calculate, const Color(0xFF00CC66), Colors.black)), // Green
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildActionCard('AI ASK', 'Transit Help', Icons.auto_awesome, const Color(0xFFFF3300), Colors.white)), // Red
              const SizedBox(width: 16),
              Expanded(child: _buildActionCard('NEWS', 'Updates', Icons.campaign, Colors.white, Colors.black)), // White
            ],
          ),

          const SizedBox(height: 32),
          Text('SYSTEM STATUS', style: MiffyStyle.overline.copyWith(color: Colors.black54)),
          const SizedBox(height: 12),

          // --- 3. SLEEK COMPLIANCE & STATUS SECTION ---
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2),
              boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
            ),
            child: Column(
              children: [
                _buildStatusRow(Icons.gavel, 'SP ORDINANCE 6824-2023', 'Active & Enforced', Colors.green),
                Container(height: 2, color: Colors.black),
                _buildStatusRow(Icons.route, 'LPTRP 7194-2024', '7 Routes Verified', Colors.blue),
                Container(height: 2, color: Colors.black),
                _buildStatusRow(Icons.memory, 'AI ENGINE', 'Online', Colors.orange),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // Helper widget for the colorful Quick Action cards
  Widget _buildActionCard(String title, String subtitle, IconData icon, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: textColor),
          const SizedBox(height: 16),
          Text(title, style: MiffyStyle.headerBlack.copyWith(fontSize: 20, color: textColor)),
          const SizedBox(height: 4),
          Text(subtitle, style: MiffyStyle.overline.copyWith(fontSize: 10, color: textColor.withValues(alpha: 0.8))),
        ],
      ),
    );
  }

  // Helper widget for the System Status rows
  Widget _buildStatusRow(IconData icon, String title, String status, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black),
          const SizedBox(width: 16),
          Expanded(
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.2),
              border: Border.all(color: statusColor, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 9, color: statusColor),
            ),
          ),
        ],
      ),
    );
  }
}