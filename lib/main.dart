import 'package:flutter/material.dart';

// --- YOUR SCREENS ---
import 'screens/home_screen.dart'; 
import 'screens/routes_screen.dart';
import 'screens/fares_screen.dart'; // <-- THIS LINKS THE FARES SCREEN
import 'screens/assistant_screen.dart';

void main() {
  runApp(const ButuanTransitApp());
}

class ButuanTransitApp extends StatelessWidget {
  const ButuanTransitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Butuan Transit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter',
      ),
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  // Opens to the FARES tab so you can test it immediately
  int _currentIndex = 0; 

  // --- THE NAVIGATION LOGIC ---
  final List<Widget> _screens = [
    const HomeScreen(), 
    const RoutesScreen(), 
    const AssistantScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.directions_bus, color: Colors.black),
            SizedBox(width: 8),
            Text(
              'BUTUAN TRANSIT', 
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: -0.5)
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: Colors.black, height: 2),
        ),
      ),
      
      body: _screens[_currentIndex],
      
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black, width: 2)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 10),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 10),
          items: const [
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.home)),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.map)),
              label: 'ROUTES',
            ),
            
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.help_outline)),
              label: 'AI ASK',
            ),
          ],
        ),
      ),
    );
  }
}