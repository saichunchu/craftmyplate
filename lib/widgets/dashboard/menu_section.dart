import 'package:flutter/material.dart';
import 'menu_item.dart';

class MenuSection extends StatelessWidget {
  final bool isTablet;
  final bool isSmallScreen;
  final bool isLargeTablet;
  final Function(String) showMsg;

  const MenuSection({
    Key? key,
    required this.isTablet,
    required this.isSmallScreen,
    required this.isLargeTablet,
    required this.showMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          isLargeTablet ? 28 : (isTablet ? 24 : 20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(isLargeTablet ? 28 : (isTablet ? 24 : 20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Menu",
                style: TextStyle(
                  color: Color(0xFF8B5FBF),
                  fontWeight: FontWeight.bold,
                  fontSize: isLargeTablet
                      ? 20
                      : (isTablet ? 18 : (isSmallScreen ? 16 : 17)),
                ),
              ),
              GestureDetector(
                onTap: () => showMsg("See all menu"),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFF8B5FBF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: Color(0xFF8B5FBF),
                      fontSize: isLargeTablet
                          ? 16
                          : (isTablet ? 15 : (isSmallScreen ? 12 : 14)),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isLargeTablet ? 20 : (isSmallScreen ? 12 : 16)),
          MenuItem(title: 'BREAKFAST:', items: 'Poha, Upma, Idli, Dosa & more'),
          Divider(height: isLargeTablet ? 28 : 24, color: Colors.grey.shade300),
          MenuItem(title: 'LUNCH:', items: 'Veg Kolahapuri, Rice, Roti & more'),
          Divider(height: isLargeTablet ? 28 : 24, color: Colors.grey.shade300),
          MenuItem(
            title: 'HIGH TEA:',
            items: 'Bajero, Moda & many more',
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
