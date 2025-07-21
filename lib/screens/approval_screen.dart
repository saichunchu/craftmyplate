import 'package:craftmyplate/screens/main_screen.dart';
import 'package:craftmyplate/widgets/approval/approval_status_toggle.dart';
import 'package:flutter/material.dart';

import '../widgets/approval/approval_status_header.dart';
import '../widgets/approval/approval_status_list.dart';

class ApprovalStatusScreen extends StatefulWidget {
  @override
  _ApprovalStatusScreenState createState() => _ApprovalStatusScreenState();
}

class _ApprovalStatusScreenState extends State<ApprovalStatusScreen> {
  ApprovalStatus _currentStatus = ApprovalStatus.pending;
  bool isApprovedSelected = true;
  bool _showNotificationBadge = true;
  // Approval Data
  final List<ApprovalItem> approvedItems = [
    ApprovalItem(
      name: "Harsh Jogi",
      date: "22nd Feb, 2024 - 22nd Feb, 2024",
      time: "10:30 AM - 11:30 PM",
      icon: Icons.event_note,
      iconColor: Colors.blue,
    ),
    ApprovalItem(
      name: "Harsh Jogi",
      date: "22nd Feb, 2024 - 22nd Feb, 2024",
      time: "10:30 AM - 11:30 PM",
      icon: Icons.wb_sunny,
      iconColor: Colors.orange,
    ),
    ApprovalItem(
      name: "Vaibhav Daware",
      date: "9th Mar, 2024 - 9th Mar, 2024",
      time: "10:30 AM - 01:00 PM",
      icon: Icons.business_center,
      iconColor: Colors.brown,
    ),
    ApprovalItem(
      name: "Gym",
      date: "22nd Feb, 2024",
      time: "06:00 AM - 09:00 AM",
      icon: Icons.fitness_center,
      iconColor: Colors.teal,
    ),
  ];
  final List<ApprovalItem> pendingItems = [
    /* ... same as before ... */
    ApprovalItem(
      name: "Sakshi Patel",
      date: "24th Mar, 2024 - 25th Mar, 2024",
      time: "09:00 AM - 05:00 PM",
      icon: Icons.pending_actions,
      iconColor: Colors.amber,
    ),
    ApprovalItem(
      name: "Library Pass",
      date: "1st Apr, 2024",
      time: "02:30 PM - 03:30 PM",
      icon: Icons.menu_book,
      iconColor: Colors.deepPurple,
    ),
    ApprovalItem(
      name: "Workshop",
      date: "10th Apr, 2024 - 11th Apr, 2024",
      time: "03:00 PM - 05:00 PM",
      icon: Icons.engineering,
      iconColor: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<ApprovalItem> displayedItems = _currentStatus ==ApprovalStatus.approved
        ? approvedItems
        : pendingItems;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          ApprovalStatusHeader(
            selectedStatus: _currentStatus,
            onBack: () {
              Navigator.of(context).pop();
            },
            onStatusChanged: (ApprovalStatus status) {
              setState(() {
                _currentStatus = status;
                
              });
            },
            onNotificationTap: () {
              setState(() {
                _showNotificationBadge = false;
              });
            },
          ),
          Expanded(
            child: ApprovalStatusList(
              items: displayedItems,
            ),
          ),
        ],
      ),
    );
  }
}

// ApprovalItem Model
class ApprovalItem {
  final String name;
  final String date;
  final String time;
  final IconData icon;
  final Color iconColor;

  ApprovalItem({
    required this.name,
    required this.date,
    required this.time,
    required this.icon,
    required this.iconColor,
  });
}
