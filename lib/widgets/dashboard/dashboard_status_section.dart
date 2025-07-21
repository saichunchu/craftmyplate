import 'package:flutter/material.dart';
import '../side_toggle_button.dart';

class DashboardStatusSection extends StatelessWidget {
  final bool isTablet;
  final bool isSmallScreen;
  final bool isLargeTablet;
  final Animation<double> cardsAnim;
  final bool sidebarOpen;
  final VoidCallback toggleSidebar;

  const DashboardStatusSection({
    Key? key,
    required this.isTablet,
    required this.isSmallScreen,
    required this.isLargeTablet,
    required this.cardsAnim,
    required this.sidebarOpen,
    required this.toggleSidebar,
  }) : super(key: key);

  Widget _buildStatusCard(
    String title,
    String count,
    Color color,
    Image image,
    int index,
  ) {
    final isLightColor = color == Color(0xFFE5E7EB);
    final textColor = isLightColor ? Color(0xFF6B7280) : Colors.white;
    final countColor = isLightColor ? Color(0xFF374151) : Colors.white;

    return Transform.scale(
      scale: cardsAnim.value * 0.2 + 0.8,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  count,
                  style: TextStyle(
                    color: countColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(child: image, width: 60, height: 60),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
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
                'Quick Status',
                style: TextStyle(
                  color: Color(0xFF374151),
                  fontWeight: FontWeight.bold,
                  fontSize: isLargeTablet
                      ? 20
                      : (isTablet ? 18 : (isSmallScreen ? 16 : 17)),
                ),
              ),
              SizedBox(height: isLargeTablet ? 20 : (isSmallScreen ? 12 : 16)),
              AnimatedBuilder(
                animation: cardsAnim,
                builder: (_, __) => LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount;
                    double childAspectRatio;

                    if (isLargeTablet) {
                      crossAxisCount = 4;
                      childAspectRatio = 1.1;
                    } else if (isTablet) {
                      crossAxisCount = 4;
                      childAspectRatio = 1.0;
                    } else if (constraints.maxWidth > 400) {
                      crossAxisCount = 2;
                      childAspectRatio = 1.2;
                    } else {
                      crossAxisCount = 2;
                      childAspectRatio = 1.0;
                    }

                    return GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: isLargeTablet
                          ? 20
                          : (isTablet ? 16 : 12),
                      mainAxisSpacing: isLargeTablet
                          ? 20
                          : (isTablet ? 16 : 12),
                      childAspectRatio: childAspectRatio,
                      children: [
                        _buildStatusCard(
                          'Events\nStatus',
                          '3',
                          Color(0xFFFCD34D),
                          Image.asset('assets/images/Tag.png'),
                          0,
                        ),
                        _buildStatusCard(
                          'Announcement',
                          '0',
                          Color(0xFF6C40C4),
                          Image.asset('assets/images/Mic.png'),
                          1,
                        ),
                        _buildStatusCard(
                          'Approval\nStatus',
                          '4',
                          Color(0xFFE5E7EB),
                          Image.asset('assets/images/Tick.png'),
                          2,
                        ),
                        _buildStatusCard(
                          'Complaint\nManagement',
                          '0',
                          Color.fromARGB(255, 62, 38, 109),
                          Image.asset('assets/images/Danger.png'),
                          3,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 176,
          right: -20,
          child: Container(
            width: 45,
            height: 45,
            child: SideToggleButton(
              isOpen: sidebarOpen,
              onTap: toggleSidebar,
            ),
          ),
        ),
      ],
    );
  }
}
