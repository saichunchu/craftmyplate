

import 'package:flutter/material.dart';

class ProfileRoommatesSection extends StatelessWidget {
  const ProfileRoommatesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ROOM MATES',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                '(4)',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: List.generate(
              4,
              (index) => Padding(
                padding: EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.purple.shade100,
                  child: Icon(
                    Icons.person,
                    color: Colors.purple.shade400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
