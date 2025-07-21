import 'package:flutter/material.dart';

enum ApprovalStatus { pending, approved }

class ApprovalStatusToggle extends StatefulWidget {
  final ApprovalStatus selectedStatus;
  final ValueChanged<ApprovalStatus> onChanged;
  final bool isEnabled;
  final Color primaryColor;
  final Color backgroundColor;
  final Duration animationDuration;
  final double height;
  final EdgeInsetsGeometry? margin;
  
  const ApprovalStatusToggle({
    Key? key,
    required this.selectedStatus,
    required this.onChanged,
    this.isEnabled = true,
    this.primaryColor = const Color(0xFF8B5FBF),
    this.backgroundColor = const Color(0x33FFFFFF),
    this.animationDuration = const Duration(milliseconds: 200),
    this.height = 50.0,
    this.margin,
  }) : super(key: key);

  @override
  State<ApprovalStatusToggle> createState() => _ApprovalStatusToggleState();
}

class _ApprovalStatusToggleState extends State<ApprovalStatusToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  late Animation<double> _scaleAnimation;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    
    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    
    _updateAnimation();
  }

  void _updateAnimation() {
    switch (widget.selectedStatus) {
      case ApprovalStatus.pending:
        _animationController.animateTo(0.0);
        break;
      case ApprovalStatus.approved:
        _animationController.animateTo(0.5);
        break;
     
    }
  }

  @override
  void didUpdateWidget(ApprovalStatusToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedStatus != widget.selectedStatus) {
      _updateAnimation();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getStatusColor(ApprovalStatus status) {
    switch (status) {
      case ApprovalStatus.pending:
        return Colors.orange;
      case ApprovalStatus.approved:
        return Colors.green;
 
    }
  }

  IconData _getStatusIcon(ApprovalStatus status) {
    switch (status) {
      case ApprovalStatus.pending:
        return Icons.schedule;
      case ApprovalStatus.approved:
        return Icons.check_circle;
    
    }
  }

  String _getStatusText(ApprovalStatus status) {
    switch (status) {
      case ApprovalStatus.pending:
        return 'Pending';
      case ApprovalStatus.approved:
        return 'Approved';
    }
  }

  Widget _buildToggleButton({
    required ApprovalStatus status,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.isEnabled ? onTap : null,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isSelected ? _scaleAnimation.value : 1.0,
              child: Container(
                height: widget.height - 8,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? _getStatusColor(status)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(widget.height / 2 - 4),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: _getStatusColor(status).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: widget.animationDuration,
                      child: Icon(
                        _getStatusIcon(status),
                        key: ValueKey('${status.toString()}_icon'),
                        size: 18,
                        color: isSelected 
                            ? Colors.white 
                            : Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(width: 6),
                    AnimatedDefaultTextStyle(
                      duration: widget.animationDuration,
                      style: TextStyle(
                        color: isSelected 
                            ? Colors.white 
                            : Colors.white.withOpacity(0.7),
                        fontWeight: isSelected 
                            ? FontWeight.w600 
                            : FontWeight.w500,
                        fontSize: 14,
                      ),
                      child: Text(_getStatusText(status)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.isEnabled 
            ? widget.backgroundColor 
            : widget.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(widget.height / 2),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Opacity(
        opacity: widget.isEnabled ? 1.0 : 0.6,
        child: Row(
          children: [
            _buildToggleButton(
              status: ApprovalStatus.pending,
              isSelected: widget.selectedStatus == ApprovalStatus.pending,
              onTap: ()=> widget.onChanged(ApprovalStatus.pending),
            ),
            _buildToggleButton(
              status: ApprovalStatus.approved,
              isSelected: widget.selectedStatus == ApprovalStatus.approved,
              onTap: () => widget.onChanged(ApprovalStatus.approved),
            ),
          ],
        ),
      ),
    );
  }
}
