import 'package:flutter/material.dart';
import 'meal_dialog.dart';

class MealBookingSection extends StatelessWidget {
  final bool isTablet;
  final bool isSmallScreen;
  final bool isLargeTablet;
  final bool mealBooked;
  final VoidCallback toggleMeal;
  final Function(String) showMsg;

  const MealBookingSection({
    Key? key,
    required this.isTablet,
    required this.isSmallScreen,
    required this.isLargeTablet,
    required this.mealBooked,
    required this.toggleMeal,
    required this.showMsg,
  }) : super(key: key);

  Widget _buildMealButton({
    required String text,
    required bool isActive,
    required VoidCallback? onPressed,
    required bool isTablet,
    required bool isSmallScreen,
    required bool isLargeTablet,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.white : Color(0xFFE5E7EB),
        foregroundColor: isActive ? Colors.black : Color(0xFF6B7280),
        elevation: isActive ? 3 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isLargeTablet ? 18 : 16),
          side: BorderSide(
            color: isActive
                ? Color(0xFF6C40C4).withOpacity(0.3)
                : Colors.grey.shade200,
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: isLargeTablet
              ? 18
              : (isTablet ? 16 : (isSmallScreen ? 12 : 14)),
          horizontal: 16,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isLargeTablet
              ? 16
              : (isTablet ? 15 : (isSmallScreen ? 12 : 14)),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

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
          Text(
            'Meal Booking',
            style: TextStyle(
              color: Color(0xFF374151),
              fontWeight: FontWeight.bold,
              fontSize: isLargeTablet
                  ? 20
                  : (isTablet ? 18 : (isSmallScreen ? 16 : 17)),
            ),
          ),
          SizedBox(height: isLargeTablet ? 20 : (isSmallScreen ? 12 : 16)),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 300) {
                return Row(
                  children: [
                    _buildMealButton(
                      text: '+ BOOK MEAL',
                      isActive: !mealBooked,
                      onPressed: mealBooked
                          ? null
                          : () {
                              toggleMeal();
                              showMealDialog(context);
                            },
                      isTablet: isTablet,
                      isSmallScreen: isSmallScreen,
                      isLargeTablet: isLargeTablet,
                    ),
                    SizedBox(width: 12),
                    _buildMealButton(
                      text: '- CANCEL MEAL',
                      isActive: mealBooked,
                      onPressed: !mealBooked
                          ? null
                          : () {
                              toggleMeal();
                              showMealDialog(context);
                            },
                      isTablet: isTablet,
                      isSmallScreen: isSmallScreen,
                      isLargeTablet: isLargeTablet,
                    ),
                  ],
                );
              } else {
                return Row(
                  children: [
                    Expanded(
                      child: _buildMealButton(
                        text: '✓ BOOK MEAL',
                        isActive: !mealBooked,
                        onPressed: mealBooked
                            ? null
                            : () {
                                toggleMeal();
                                showMsg('Meal booked successfully');
                              },
                        isTablet: isTablet,
                        isSmallScreen: isSmallScreen,
                        isLargeTablet: isLargeTablet,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildMealButton(
                        text: '- CANCEL MEAL',
                        isActive: mealBooked,
                        onPressed: !mealBooked
                            ? null
                            : () {
                                toggleMeal();
                              },
                        isTablet: isTablet,
                        isSmallScreen: isSmallScreen,
                        isLargeTablet: isLargeTablet,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
