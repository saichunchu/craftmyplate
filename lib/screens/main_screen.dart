import 'package:craftmyplate/screens/approval_screen.dart';
import 'package:craftmyplate/screens/dashboard_screen.dart';
import 'package:craftmyplate/screens/emergency_screen.dart';
import 'package:craftmyplate/screens/profile_screen.dart';
import 'package:craftmyplate/screens/qr_screen.dart';
import 'package:craftmyplate/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    DashboardScreen(),
    QRScannerPage(),
    ApprovalStatusScreen(),
    ProfileScreen(),
    EmergencySupportScreen(),
  ];

  void _onTabChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: IndexedStack(
              index: _currentPageIndex,
              children: _pages,
            ),
          ),

          // Floating bottom nav bar
          Positioned(
  left: 0,
  right: 0,
  bottom: 0,
  child: FloatingQRNavbar(
    currentIndex: _currentPageIndex,
    onTabChanged: _onTabChanged,
  ),
),

     

        ],
      ),
    );
  }
}
