import 'package:flutter/material.dart';

class ProfilePrivacyToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const ProfilePrivacyToggle({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Keep My Profile Private:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFF8B5FBF),
          ),
        ],
      ),
    );
  }
}
