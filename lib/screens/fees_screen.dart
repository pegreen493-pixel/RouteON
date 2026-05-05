import 'package:flutter/material.dart';

class FeesScreen extends StatefulWidget {
  const FeesScreen({super.key});

  @override
  State<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  bool isTricycle = true;
  int selectedRouteIndex = 1; // 1 to 13

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Fare Guide', style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Toggle Buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isTricycle = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: isTricycle ? const Color(0xFFFF6026) : Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            if (isTricycle)
                              const BoxShadow(
                                color: Colors.black,
                                offset: Offset(3, 3),
                              ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Tricycle',
                            style: TextStyle(
                              color: isTricycle ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isTricycle = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: !isTricycle ? const Color(0xFFFF6026) : Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            if (!isTricycle)
                              const BoxShadow(
                                color: Colors.black,
                                offset: Offset(3, 3),
                              ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Multicab (PUJ)',
                            style: TextStyle(
                              color: !isTricycle ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Route Selection for Multicab
            if (!isTricycle)
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    final availableRoutes = [1, 2, 4, 7, 8, 10, 12, 13];
                    final routeNum = availableRoutes[index];
                    final isSelected = selectedRouteIndex == routeNum;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRouteIndex = routeNum;
                        });
                      },
                      child: Container(
                        width: 50,
                        margin: const EdgeInsets.only(right: 12, bottom: 8, top: 4),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFFF6026) : Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                          shape: BoxShape.circle,
                          boxShadow: [
                            if (isSelected)
                              const BoxShadow(
                                color: Colors.black,
                                offset: Offset(2, 2),
                              ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '$routeNum',
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

            // The Interactive Viewer
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: InteractiveViewer(
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: Center(
                    child: Image.asset(
                      isTricycle 
                          ? 'assets/images/tricycle_fare.png'
                          : 'assets/images/puj_route_$selectedRouteIndex.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image, size: 80, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              'Fare matrix image not available yet',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        );
                      },
                    ),
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
