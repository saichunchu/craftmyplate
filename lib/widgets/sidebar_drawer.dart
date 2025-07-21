import 'package:flutter/material.dart';

// Enhanced Sidebar Drawer with better styling and animations
class SidebarDrawer extends StatelessWidget {
  final Function(String) onItemTap;
  final String selectedItem;
  final VoidCallback? onClose;

  const SidebarDrawer({
    Key? key,
    required this.onItemTap,
    required this.selectedItem,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      _DrawerItem('Emergency Support', 'https://img.icons8.com/3d-fluency/94/siren.png', Colors.red.shade400),
      _DrawerItem('Complaint', 'https://img.icons8.com/3d-fluency/94/error.png', Colors.orange.shade400),
      _DrawerItem('Leave', 'https://img.icons8.com/3d-fluency/94/calendar.png', Colors.blue.shade400),
      _DrawerItem('Mess Management', 'https://img.icons8.com/3d-fluency/94/restaurant.png', Colors.green.shade400),
      _DrawerItem('Day / Night Out', 'https://img.icons8.com/3d-fluency/94/sun.png', Colors.amber.shade400),
      _DrawerItem('Late Entry', 'https://img.icons8.com/3d-fluency/94/hourglass.png', Colors.purple.shade400),
      _DrawerItem('My Payments', 'https://img.icons8.com/3d-fluency/94/money-bag.png', Colors.teal.shade400),
      _DrawerItem('Parcel', 'https://img.icons8.com/3d-fluency/94/shipped.png', Colors.brown.shade400),
      _DrawerItem('Polling', 'https://img.icons8.com/3d-fluency/94/survey.png', Colors.indigo.shade400),
      _DrawerItem('Amenities Booking', 'https://img.icons8.com/3d-fluency/94/swimming-pool.png', Colors.cyan.shade400),
      _DrawerItem('EV Slot Booking', 'https://img.icons8.com/3d-fluency/94/charging-station.png', Colors.lightGreen.shade400),
      _DrawerItem('Vehicle Pass', 'https://img.icons8.com/3d-fluency/94/scooter.png', Colors.deepOrange.shade400),
    ];

    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF6C40C4),
            Color(0xFF5032B5),
            Color(0xFF3D1A78),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // _buildHeader(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.82,
                  ),
                  itemBuilder: (context, index) {
                    return _buildCard(context, items[index], index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, _DrawerItem item, int index) {
    final bool isSelected = item.title == selectedItem;

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 50)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: GestureDetector(
              onTap: () {
                onItemTap(item.title);
                // Add haptic feedback
                // HapticFeedback.lightImpact();
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.98),
                      Colors.white.withOpacity(0.92),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                  border: isSelected 
                    ? Border.all(color: Color(0xFF00BCD4), width: 2.5)
                    : null,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                      spreadRadius: 1,
                    ),
                    if (isSelected)
                      BoxShadow(
                        color: Color(0xFF00BCD4).withOpacity(0.4),
                        blurRadius: 15,
                        offset: Offset(0, 6),
                        spreadRadius: 1,
                      ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon container with colored background matching reference
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            item.accentColor.withOpacity(0.15),
                            item.accentColor.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: item.accentColor.withOpacity(0.2),
                          width: 0.5,
                        ),
                      ),
                      child: Center(
                        child: Image.network(
                          item.imageUrl,
                          height: 42,
                          width: 42,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.apps,
                            size: 42,
                            color: item.accentColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Color(0xFF2196F3) : Color(0xFF424242),
                        height: 1.2,
                        letterSpacing: 0.1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (isSelected) ...[
                      SizedBox(height: 6),
                      Container(
                        width: 24,
                        height: 2.5,
                        decoration: BoxDecoration(
                          color: Color(0xFF2196F3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/Mask group.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.person,
                    size: 30,
                    color: Color(0xFF6C40C4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Sai Chunchu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          if (onClose != null)
            IconButton(
              onPressed: onClose,
              icon: Icon(
                Icons.close,
                color: Colors.white.withOpacity(0.8),
                size: 24,
              ),
            ),
        ],
      ),
    );
  }
}
class _DrawerItem {
  final String title;
  final String imageUrl;
  final Color accentColor;

  _DrawerItem(this.title, this.imageUrl, this.accentColor);
}