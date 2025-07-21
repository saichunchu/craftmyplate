import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/emergency/emergency_header.dart';
import '../widgets/emergency/emergency_card.dart';

class EmergencySupportScreen extends StatelessWidget {
  const EmergencySupportScreen({Key? key}) : super(key: key);

  void _handleAction(String emergency, String action) {
    HapticFeedback.heavyImpact();
    print('$action for $emergency');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          EmergencyHeader(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.83,
                  children: [
                    EmergencyCard(
                      title: 'Medical Emergency',
                      emoji: '📱',
                      decoration: '💊',
                      onMessageTap: () => _handleAction('Medical Emergency', 'message'),
                      onCallTap: () => _handleAction('Medical Emergency', 'call'),
                    ),
                    EmergencyCard(
                      title: 'Theft',
                      emoji: '👨‍🦲',
                      decoration: '🔴',
                      onMessageTap: () => _handleAction('Theft', 'message'),
                      onCallTap: () => _handleAction('Theft', 'call'),
                    ),
                    EmergencyCard(
                      title: 'Need Food',
                      emoji: '🍽️',
                      onMessageTap: () => _handleAction('Need Food', 'message'),
                      onCallTap: () => _handleAction('Need Food', 'call'),
                    ),
                    EmergencyCard(
                      title: 'Stuck In Lift',
                      emoji: '🏢',
                      onMessageTap: () => _handleAction('Stuck In Lift', 'message'),
                      onCallTap: () => _handleAction('Stuck In Lift', 'call'),
                    ),
                    EmergencyCard(
                      title: 'Natural Disaster',
                      emoji: '🌪️',
                      decoration: '🏠',
                      onMessageTap: () => _handleAction('Natural Disaster', 'message'),
                      onCallTap: () => _handleAction('Natural Disaster', 'call'),
                    ),
                    EmergencyCard(
                      title: 'Violence',
                      emoji: '✋',
                      decoration: '🔴',
                      isStop: true,
                      onMessageTap: () => _handleAction('Violence', 'message'),
                      onCallTap: () => _handleAction('Violence', 'call'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
