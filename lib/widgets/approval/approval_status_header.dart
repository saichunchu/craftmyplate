import 'package:craftmyplate/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'approval_status_toggle.dart';

class ApprovalStatusHeader extends StatefulWidget {
  final ApprovalStatus selectedStatus;
  final VoidCallback onBack;
  final ValueChanged<ApprovalStatus> onStatusChanged;
  final VoidCallback? onNotificationTap;
  final String? title;
  final bool showNotificationBadge;
  final Color? primaryColor;
  final Color? secondaryColor;

  const ApprovalStatusHeader({
    Key? key,
    required this.selectedStatus,
    required this.onBack,
    required this.onStatusChanged,
    this.onNotificationTap,
    this.title = 'APPROVAL STATUS',
    this.showNotificationBadge = false,
    this.primaryColor = const Color(0xFF8B5FBF),
    this.secondaryColor = const Color(0xFF7B4CB8),
  }) : super(key: key);

  @override
  State<ApprovalStatusHeader> createState() => _ApprovalStatusHeaderState();
}

class _ApprovalStatusHeaderState extends State<ApprovalStatusHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _showNotificationbadge= true;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback? onTap,
    bool showBadge = false,
    double size = 24,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Icon(icon, color: Colors.white, size: size),
            if (showBadge)
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getStatusDescription(ApprovalStatus status) {
    switch (status) {
      case ApprovalStatus.pending:
        return 'Awaiting Review';
      case ApprovalStatus.approved:
        return 'Request Approved';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.primaryColor!,
            widget.secondaryColor!,
            widget.primaryColor!.withOpacity(0.8),
          ],
          stops: const [0.0, 0.7, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: widget.primaryColor!.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // Top navigation bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildActionButton(
                        icon: Icons.arrow_back_ios,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> DashboardScreen()));
                        },
                        size: 20,
                      ),
                      _buildActionButton(
                        icon: Icons.notifications_outlined,
                        onTap: widget.onNotificationTap,
                        showBadge: widget.showNotificationBadge,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Title section
                  Center(
                    child: Column(
                      children: [
                        Text(
                          widget.title!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                        // const SizedBox(height: 4),
                        // Container(
                        //   height: 3,
                        //   width: 40,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white.withOpacity(0.6),
                        //     borderRadius: BorderRadius.circular(2),
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                  // const SizedBox(height: 20),

                  // Status description
                  // Center(
                  //   child: AnimatedSwitcher(
                  //     duration: const Duration(milliseconds: 300),
                  //     child: Text(
                  //       _getStatusDescription(widget.selectedStatus),
                  //       key: ValueKey(widget.selectedStatus),
                  //       style: TextStyle(
                  //         color: Colors.white.withOpacity(0.9),
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // const SizedBox(height: 20),

                  // Status toggle
                  ApprovalStatusToggle(
                    selectedStatus: widget.selectedStatus,
                    onChanged: widget.onStatusChanged,
                    backgroundColor: Colors.white.withOpacity(0.15),
                    height: 55,
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
