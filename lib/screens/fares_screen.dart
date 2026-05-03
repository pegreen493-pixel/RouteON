import 'package:flutter/material.dart';
import '../theme/miffy_style.dart';

class FaresScreen extends StatefulWidget {
  const FaresScreen({super.key});

  @override
  State<FaresScreen> createState() => _FaresScreenState();
}

class _FaresScreenState extends State<FaresScreen> {
  // Journey variables
  int pujLegs = 0;
  int trikeLegs = 0;

  // Constants based on SP Ordinance 6824-2023
  final double pujBaseFare = 14.0;
  final double trikeBaseFare = 10.0;

  double get totalExpense => (pujLegs * pujBaseFare) + (trikeLegs * trikeBaseFare);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 1. HEADER ---
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.black, width: 2),
              boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calculate, color: Colors.white, size: 20),
                    const SizedBox(width: 12),
                    Text('FARE CALCULATOR', style: MiffyStyle.headerBlack.copyWith(color: Colors.white, fontSize: 20)),
                  ],
                ),
                const SizedBox(height: 8),
                Text('SP ORDINANCE 6824-2023 MATRIX', style: MiffyStyle.overline.copyWith(color: Colors.white60)),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          Text('BASE FARES (REGULAR)', style: MiffyStyle.overline.copyWith(color: Colors.black54)),
          const SizedBox(height: 12),

          // --- 2. OFFICIAL MATRIX ROW ---
          Row(
            children: [
              Expanded(child: _buildBaseFareCard('PUJ / Multicab', '₱14.00', Colors.white)),
              const SizedBox(width: 16),
              Expanded(child: _buildBaseFareCard('Tricycle (Zoned)', '₱10.00', Colors.white)),
            ],
          ),

          const SizedBox(height: 32),
          Text('MULTI-LEG JOURNEY PLANNER', style: MiffyStyle.overline.copyWith(color: Colors.black54)),
          const SizedBox(height: 12),

          // --- 3. INTERACTIVE CALCULATOR ---
          Container(
            decoration: MiffyStyle.cardDecoration,
            child: Column(
              children: [
                _buildStepperRow(
                  title: 'PUJ Rides Required',
                  subtitle: 'Highway travel (R1-R7)',
                  count: pujLegs,
                  onDecrement: () => setState(() { if (pujLegs > 0) pujLegs--; }),
                  onIncrement: () => setState(() => pujLegs++),
                ),
                Container(height: 2, color: Colors.black),
                _buildStepperRow(
                  title: 'Tricycle Rides Required',
                  subtitle: 'Barangay/Inner city drop-offs',
                  count: trikeLegs,
                  onDecrement: () => setState(() { if (trikeLegs > 0) trikeLegs--; }),
                  onIncrement: () => setState(() => trikeLegs++),
                ),
                Container(height: 4, color: Colors.black),
                
                // TOTAL EXPENSE DISPLAY
                Container(
                  padding: const EdgeInsets.all(24),
                  color: Colors.black,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ESTIMATED TOTAL EXPENSE', style: MiffyStyle.overline.copyWith(color: Colors.white70)),
                      const SizedBox(height: 8),
                      Text(
                        '₱${totalExpense.toStringAsFixed(2)}',
                        style: MiffyStyle.headerBlack.copyWith(color: Colors.greenAccent, fontSize: 40),
                      ),
                      if (pujLegs > 0 || trikeLegs > 0) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Breakdown: ${pujLegs}x PUJ + ${trikeLegs}x Trike',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          // RESET BUTTON
          if (pujLegs > 0 || trikeLegs > 0)
            SizedBox(
              width: double.infinity,
              child: MiffyButton(
                text: 'RESET CALCULATOR',
                isOutline: true,
                onPressed: () => setState(() { pujLegs = 0; trikeLegs = 0; }),
              ),
            ),
        ],
      ),
    );
  }

  // Visual card for the base matrix
  Widget _buildBaseFareCard(String vehicle, String fare, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(3, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(vehicle, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
          const SizedBox(height: 8),
          Text(fare, style: MiffyStyle.headerBlack.copyWith(fontSize: 24)),
        ],
      ),
    );
  }

  // Interactive +/- Stepper Row
  Widget _buildStepperRow({
    required String title,
    required String subtitle,
    required int count,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black54)),
              ],
            ),
          ),
          Row(
            children: [
              _buildRoundButton(Icons.remove, onDecrement, count > 0),
              SizedBox(
                width: 40,
                child: Center(
                  child: Text(count.toString(), style: MiffyStyle.headerBlack.copyWith(fontSize: 20)),
                ),
              ),
              _buildRoundButton(Icons.add, onIncrement, true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoundButton(IconData icon, VoidCallback onPressed, bool enabled) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: enabled ? Colors.black : Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: enabled ? Colors.white : Colors.grey.shade500, size: 20),
      ),
    );
  }
}