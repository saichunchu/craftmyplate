import 'package:flutter/material.dart';

class EmergencyCard extends StatelessWidget {
  final String title;
  final String emoji;
  final String? decoration;
  final bool isStop;
  final VoidCallback onMessageTap;
  final VoidCallback onCallTap;

  const EmergencyCard({
    Key? key,
    required this.title,
    required this.emoji,
    this.decoration,
    this.isStop = false,
    required this.onMessageTap,
    required this.onCallTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: isStop
                        ? Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Color(0xFFEF4444),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.pan_tool_outlined,
                                color: Colors.white, size: 28),
                          )
                        : Text(emoji, style: TextStyle(fontSize: 36)),
                  ),
                ),
                if (decoration != null && !isStop)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Text(decoration!, style: TextStyle(fontSize: 18)),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCircleButton(Icons.message, onMessageTap),
              const SizedBox(width: 16),
              _buildCircleButton(Icons.phone, onCallTap),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 42,
        height: 42,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Color(0xFF7C3AED), size: 20),
      ),
    );
  }
}
