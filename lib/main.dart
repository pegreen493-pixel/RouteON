import 'package:flutter/material.dart';

// --- YOUR SCREENS ---
import 'screens/home_screen.dart'; 
import 'screens/routes_screen.dart';
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
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFFFF6026)),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/icons/logo_main.png',
          height: 30,
          fit: BoxFit.contain,
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.white,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: const Color(0xFFFF6026),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_awesome),
              label: 'AI',
            ),
          ],
        ),
      ),
    );
  }
}