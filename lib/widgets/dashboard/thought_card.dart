import 'package:flutter/material.dart';

class ThoughtCard extends StatelessWidget {
  final bool isTablet;
  final bool isLargeTablet;

  const ThoughtCard({Key? key, required this.isTablet, required this.isLargeTablet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isLargeTablet ? 28 : (isTablet ? 24 : 20)),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 223, 207, 242).withOpacity(0.8),
        borderRadius: BorderRadius.circular(isLargeTablet ? 24 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'THOUGHT FOR THE DAY',
            style: TextStyle(
              color: Colors.white70,
              fontSize: isLargeTablet ? 14 : 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: isLargeTablet ? 16 : 12),
          Text(
            'It is always you against the World!',
            style: TextStyle(
              color: Colors.white,
              fontSize: isLargeTablet ? 18 : (isTablet ? 16 : 14),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
