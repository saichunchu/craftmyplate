import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onShare;
  final VoidCallback onLogout;

  const ProfileHeader({
    Key? key,
    required this.onBack,
    required this.onShare,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          Spacer(),
          Text(
            'PROFILE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          Spacer(),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.share, color: Colors.white),
                onPressed: onShare,
              ),
              IconButton(
                icon: Icon(Icons.power_settings_new, color: Colors.white),
                onPressed: onLogout,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
