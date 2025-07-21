import 'package:flutter/material.dart';
import 'package:craftmyplate/screens/profile_screen.dart';
import 'package:craftmyplate/screens/emergency_screen.dart';

class DashboardHeader extends StatelessWidget {
  final bool isTablet;
  final bool isSmallScreen;
  final bool isLargeTablet;
  final Function(String) showMsg;

  const DashboardHeader({
    Key? key,
    required this.isTablet,
    required this.isSmallScreen,
    required this.isLargeTablet,
    required this.showMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: isLargeTablet
                ? 35
                : (isTablet ? 30 : (isSmallScreen ? 22 : 25)),
            backgroundColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 240, 242, 241),
                    Color(0xFF22C55E),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                  child: Image.asset('assets/images/Mask group.png'),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: isLargeTablet ? 20 : (isTablet ? 16 : 12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: isLargeTablet
                      ? 18
                      : (isTablet ? 16 : (isSmallScreen ? 12 : 14)),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Sai Chunchu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isLargeTablet
                      ? 26
                      : (isTablet ? 24 : (isSmallScreen ? 18 : 20)),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      ' Boys Hostel',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: isLargeTablet
                            ? 18
                            : (isTablet ? 16 : (isSmallScreen ? 12 : 14)),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: isLargeTablet
                        ? 16
                        : (isTablet ? 14 : (isSmallScreen ? 10 : 12)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmergencySupportScreen(),
                  ),
                );
              },
              icon: Container(
                padding: EdgeInsets.all(isLargeTablet ? 10 : 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.help_outline,
                  color: Colors.white,
                  size: isLargeTablet ? 26 : (isTablet ? 24 : 20),
                ),
              ),
            ),
            IconButton(
              onPressed: () => showMsg('Notifications clicked'),
              icon: Container(
                padding: EdgeInsets.all(isLargeTablet ? 10 : 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: isLargeTablet ? 26 : (isTablet ? 24 : 20),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
