import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FloatingQRNavbar extends StatefulWidget {
  final Function(int) onTabChanged;
  final int currentIndex;
  final Color? primaryColor;
  final Color? secondaryColor;
  final double? height;
  final Duration? animationDuration;
  final Duration? autoHideDuration;
  final bool enableAutoHide;
  final EdgeInsetsGeometry? margin;

  const FloatingQRNavbar({
    Key? key,
    required this.onTabChanged,
    this.currentIndex = 0,
    this.primaryColor,
    this.secondaryColor,
    this.height = 70,
    this.animationDuration = const Duration(milliseconds: 200),
    this.autoHideDuration = const Duration(seconds: 5),
    this.enableAutoHide = true,
    this.margin = const EdgeInsets.all(20),
  }) : super(key: key);

  @override
  State<FloatingQRNavbar> createState() => _FloatingQRNavbarState();
}

class _FloatingQRNavbarState extends State<FloatingQRNavbar> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  double _opacity = 1.0;
  Timer? _hideTimer;

  Color get _primaryColor => widget.primaryColor ?? const Color(0xFF6366F1);
  Color get _secondaryColor => widget.secondaryColor ?? const Color(0xFF8B5CF6);

  @override
  void initState() {
    super.initState();
    _initAnimations();
    if (widget.enableAutoHide) _startHideTimer();
     _slideController.value = 1.0; // Start hidden
  _slideController.reverse();   // Animate to visible
  }

  void _initAnimations() {
    _scaleController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1.5)).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
    );
  }

  void _onTabTapped(int index) async {
    if (widget.currentIndex == index) return;
    await _scaleController.forward();
    _scaleController.reverse();
    widget.onTabChanged(index);
    HapticFeedback.selectionClick();
    if (widget.enableAutoHide) _resetHideTimer();
  }

  void _startHideTimer() {
    _hideTimer = Timer(widget.autoHideDuration!, () {
      if (mounted) setState(() => _opacity = 0.4);
    });
  }

  void _resetHideTimer() {
    _hideTimer?.cancel();
    if (mounted) setState(() => _opacity = 1.0);
    _startHideTimer();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy > 3) _slideController.forward();
    if (details.delta.dy < -3) _slideController.reverse();
  }

  void _onPanEnd(DragEndDetails details) {
    if (_slideController.value > 0.5) {
      _slideController.forward();
    } else {
      _slideController.reverse();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _slideController.dispose();
    _hideTimer?.cancel();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return Positioned(
      left: widget.margin!.horizontal / 2,
      right: widget.margin!.horizontal / 2,
      bottom: widget.margin!.vertical / 2,
      child: SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          onTap: widget.enableAutoHide ? _resetHideTimer : null,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: _opacity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.height! / 2),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: isLight
                        ? Colors.white.withOpacity(0.25)
                        : Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(widget.height! / 2),
                    border: Border.all(
                      color: Colors.white.withOpacity(isLight ? 0.4 : 0.2),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 40,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(Icons.home_filled, Icons.home_rounded, 0, 'Home'),
                      _buildQRButton(),
                      _buildNavItem(Icons.person_outline, Icons.person, 2, 'Profile'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQRButton() {
    final bool isSelected = widget.currentIndex == 1;

    return Semantics(
      button: true,
      label: 'QR Scanner',
      child: GestureDetector(
        onTap: () => _onTabTapped(1),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (_, __) {
            return Transform.scale(
              scale: isSelected && _scaleController.isAnimating
                  ? _scaleAnimation.value
                  : 1.0,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_primaryColor, _secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _primaryColor.withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: _primaryColor.withOpacity(0.2),
                      blurRadius: 32,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: AnimatedRotation(
                  turns: isSelected ? 0.25 : 0,
                  duration: widget.animationDuration!,
                  child: const Icon(Icons.qr_code_scanner_rounded,
                      color: Colors.white, size: 28),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    IconData selectedIcon,
    int index,
    String label,
  ) {
    final bool isSelected = widget.currentIndex == index;
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    final Color active = _primaryColor;
    final Color inactive = isLight ? Colors.grey.shade400 : Colors.grey.shade500;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: GestureDetector(
        onTap: () => _onTabTapped(index),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (_, __) {
            return Transform.scale(
              scale: isSelected && _scaleController.isAnimating
                  ? _scaleAnimation.value
                  : 1.0,
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSwitcher(
                      duration: widget.animationDuration!,
                      transitionBuilder: (child, anim) =>
                          ScaleTransition(scale: anim, child: child),
                      child: Icon(
                        isSelected ? selectedIcon : icon,
                        key: ValueKey(isSelected),
                        color: isSelected ? active : inactive,
                        size: 26,
                      ),
                    ),
                    if (isSelected) ...[
                      const SizedBox(height: 2),
                      AnimatedContainer(
                        duration: widget.animationDuration!,
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: active,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
