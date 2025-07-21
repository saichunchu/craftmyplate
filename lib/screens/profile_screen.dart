import 'package:craftmyplate/widgets/profile/profile_roomates_section.dart';
import 'package:flutter/material.dart';
import '../widgets/profile/profile_header.dart';
import '../widgets/profile/profile_info_section.dart';
import '../widgets/profile/profile_menu_item.dart';
import '../widgets/profile/profile_privacy_toggle.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isPrivate = true;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF8B5FBF),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF8B5FBF), Color(0xFF6B46C1)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              ProfileHeader(
                onBack: () => Navigator.pop(context),
                onShare: () => _showSnackBar('Share clicked'),
                onLogout: () => _showSnackBar('Logout clicked'),
              ),
              ProfileInfoSection(),
              SizedBox(height: 30),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ProfileRoommatesSection(),
                        SizedBox(height: 20),
                        ProfileMenuItem(
                          title: 'Hostel Details',
                          icon: Icons.arrow_forward_sharp,
                          onTap: () => _showSnackBar('Hostel Details clicked'),
                        ),
                        ProfileMenuItem(
                          title: 'Family / Personal Details',
                          icon: Icons.arrow_forward_sharp,
                          onTap: () =>
                              _showSnackBar('Family / Personal Details clicked'),
                        ),
                        ProfileMenuItem(
                          title: 'Upload KYC Documents',
                          icon: Icons.arrow_forward_sharp,
                          onTap: () =>
                              _showSnackBar('Upload KYC Documents clicked'),
                        ),
                        ProfileMenuItem(
                          title: 'Report of Indisciplinary Actions',
                          icon: Icons.arrow_forward_sharp,
                          onTap: () => _showSnackBar(
                              'Report of Indisciplinary Actions clicked'),
                        ),
                        ProfileMenuItem(
                          title: 'Vehicle Details',
                          icon: Icons.arrow_forward_sharp,
                          onTap: () => _showSnackBar('Vehicle Details clicked'),
                        ),
                        SizedBox(height: 8),
                        ProfilePrivacyToggle(
                          value: _isPrivate,
                          onChanged: (value) {
                            setState(() => _isPrivate = value);
                            _showSnackBar(_isPrivate
                                ? 'Profile set to private'
                                : 'Profile set to public');
                          },
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
