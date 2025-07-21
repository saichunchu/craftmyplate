import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:craftmyplate/widgets/dashboard/dashboard_header.dart';
import 'package:craftmyplate/widgets/dashboard/dashboard_status_section.dart';
import 'package:craftmyplate/widgets/dashboard/meal_booking_section.dart';
import 'package:craftmyplate/widgets/dashboard/menu_section.dart';
import 'package:craftmyplate/widgets/sidebar_drawer.dart';
import 'package:craftmyplate/widgets/dashboard/thought_card.dart';

const _bgColor = Color(0xFF6C40C4);
const _sidebarRadius = Radius.circular(32);
const _snackBarBg = _bgColor;
const _sidebarBackdropBlur = 25.0;
const _sidebarBackdropOpacity = 0.35;
const _drawerWidths = [0.85, 0.55, 0.40]; // [mobile, tablet, large tablet]

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with TickerProviderStateMixin {
  bool _mealBooked = false;
  bool _sidebarOpen = false;
  bool _isAnimating = false;

  late final AnimationController _staggerCtrl;
  late final AnimationController _sidebarCtrl;
  late final AnimationController _contentCtrl;

  late final Animation<double> _headerFadeAnim;
  late final Animation<Offset> _headerSlideAnim;
  late final Animation<double> _thoughtCardAnim;
  late final Animation<Offset> _thoughtCardSlideAnim;
  late final Animation<double> _statusSectionAnim;
  late final Animation<Offset> _statusSlideAnim;
  late final Animation<double> _mealSectionAnim;
  late final Animation<Offset> _mealSlideAnim;
  late final Animation<double> _menuSectionAnim;
  late final Animation<Offset> _menuSlideAnim;

  late final Animation<Offset> _sidebarSlideAnim;
  late final Animation<double> _sidebarFadeAnim;
  late final Animation<double> _backdropBlurAnim;
  late final Animation<double> _backdropOpacityAnim;
  late final Animation<Offset> _contentShiftAnim;
  late final Animation<double> _contentScaleAnim;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _triggerStaggerLaunch();
  }

  void _initAnimations() {
    _staggerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _sidebarCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Reduced for snappier sidebar
    );
    _contentCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _headerFadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _staggerCtrl, curve: const Interval(0, 0.3, curve: Curves.easeOutQuart)),
    );
    _headerSlideAnim = Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _staggerCtrl, curve: const Interval(0, 0.4, curve: Curves.easeOutCubic)),
    );
    _thoughtCardAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _staggerCtrl, curve: const Interval(0.15, 0.5, curve: Curves.easeOutQuart)),
    );
    _thoughtCardSlideAnim = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _staggerCtrl, curve: const Interval(0.15, 0.5, curve: Curves.easeOutCubic)),
    );
    _statusSectionAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _staggerCtrl, curve: const Interval(0.3, 0.65, curve: Curves.easeOutQuart)),
    );
    _statusSlideAnim = Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _staggerCtrl, curve: const Interval(0.3, 0.65, curve: Curves.easeOutCubic)),
    );
    _mealSectionAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _staggerCtrl, curve: const Interval(0.45, 0.8, curve: Curves.easeOutQuart)),
    );
    _mealSlideAnim = Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _staggerCtrl, curve: const Interval(0.45, 0.8, curve: Curves.easeOutCubic)),
    );
    _menuSectionAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _staggerCtrl, curve: const Interval(0.6, 1, curve: Curves.easeOutQuart)),
    );
    _menuSlideAnim = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _staggerCtrl, curve: const Interval(0.6, 1, curve: Curves.easeOutCubic)),
    );
    _sidebarSlideAnim = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _sidebarCtrl, curve: Curves.easeOutQuad), // Updated for snap speed
    );
    _sidebarFadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _sidebarCtrl, curve: Curves.easeOutCubic), // Updated for snap speed
    );
    _backdropBlurAnim = Tween<double>(begin: 0, end: _sidebarBackdropBlur).animate(
      CurvedAnimation(parent: _sidebarCtrl, curve: Curves.easeOutQuad),
    );
    _backdropOpacityAnim = Tween<double>(begin: 0, end: _sidebarBackdropOpacity).animate(
      CurvedAnimation(parent: _sidebarCtrl, curve: Curves.easeOutCubic),
    );
    _contentShiftAnim = Tween<Offset>(begin: Offset.zero, end: const Offset(-0.12, 0)).animate(
      CurvedAnimation(parent: _contentCtrl, curve: Curves.easeOutExpo),
    );
    _contentScaleAnim = Tween<double>(begin: 1, end: 0.88).animate(
      CurvedAnimation(parent: _contentCtrl, curve: Curves.easeOutExpo),
    );
  }

  Future<void> _triggerStaggerLaunch() async {
    await Future.delayed(const Duration(milliseconds: 80));
    if (mounted) _staggerCtrl.forward();
  }

  @override
  void dispose() {
    _staggerCtrl.dispose();
    _contentCtrl.dispose();
    _sidebarCtrl.dispose();
    super.dispose();
  }

  Future<void> _toggleSidebar() async {
    if (_isAnimating) return;
    setState(() => _isAnimating = true);
    if (_sidebarOpen) {
      await Future.wait([
        _sidebarCtrl.reverse(),
        _contentCtrl.reverse(),
      ]);
    } else {
      await Future.wait([
        _contentCtrl.forward(),
        _sidebarCtrl.forward(),
      ]);
    }
    if (mounted) setState(() {
      _sidebarOpen = !_sidebarOpen;
      _isAnimating = false;
    });
  }

  void _toggleMeal() async {
    setState(() => _mealBooked = !_mealBooked);
  }

  void _showMsg(String m) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(m, style: TextStyle(fontWeight: FontWeight.w500)),
      backgroundColor: _snackBarBg,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      elevation: 8,
      duration: const Duration(milliseconds: 2000),
    ),
  );

  double _horizontalPadding(bool isLargeTablet, bool isTablet) =>
    isLargeTablet ? 40 : isTablet ? 32 : 20;

  double _drawerWidth(double width, {required bool isTablet, required bool isLargeTablet}) =>
    width * (isLargeTablet ? _drawerWidths[2] : isTablet ? _drawerWidths[1] : _drawerWidths[0]);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final size = media.size;
    final isTablet = size.width > 600, isLargeTablet = size.width > 900, isSmallScreen = size.height < 700;
    final hPad = _horizontalPadding(isLargeTablet, isTablet);

    Widget content = SafeArea(
      child: Column(
        children: [
          SlideTransition(
            position: _headerSlideAnim,
            child: FadeTransition(
              opacity: _headerFadeAnim,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad, vertical: isSmallScreen ? 8 : 12),
                child: DashboardHeader(
                  isTablet: isTablet, isSmallScreen: isSmallScreen,
                  isLargeTablet: isLargeTablet, showMsg: _showMsg,
                ),
              ),
            ),
          ),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: hPad),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    SlideTransition(
                      position: _thoughtCardSlideAnim,
                      child: FadeTransition(
                        opacity: _thoughtCardAnim,
                        child: ThoughtCard(isTablet: isTablet, isLargeTablet: isLargeTablet),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SlideTransition(
                      position: _statusSlideAnim,
                      child: FadeTransition(
                        opacity: _statusSectionAnim,
                        child: DashboardStatusSection(
                          isTablet: isTablet,
                          isSmallScreen: isSmallScreen,
                          isLargeTablet: isLargeTablet,
                          cardsAnim: _statusSectionAnim,
                          sidebarOpen: _sidebarOpen,
                          toggleSidebar: _toggleSidebar,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SlideTransition(
                      position: _mealSlideAnim,
                      child: FadeTransition(
                        opacity: _mealSectionAnim,
                        child: MealBookingSection(
                          isTablet: isTablet,
                          isSmallScreen: isSmallScreen,
                          isLargeTablet: isLargeTablet,
                          mealBooked: _mealBooked,
                          toggleMeal: _toggleMeal,
                          showMsg: _showMsg,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SlideTransition(
                      position: _menuSlideAnim,
                      child: FadeTransition(
                        opacity: _menuSectionAnim,
                        child: MenuSection(
                          isTablet: isTablet,
                          isSmallScreen: isSmallScreen,
                          isLargeTablet: isLargeTablet,
                          showMsg: _showMsg,
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ]
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Widget sidebarBackdrop = GestureDetector(
      onTap: _toggleSidebar,
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 4) _toggleSidebar();
      },
      child: AnimatedBuilder(
        animation: _sidebarCtrl,
        builder: (context, child) => BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: _backdropBlurAnim.value, sigmaY: _backdropBlurAnim.value),
          child: Container(
            color: Colors.black.withOpacity(_backdropOpacityAnim.value),
          ),
        ),
      ),
    );

    Widget sidebarDrawer = AnimatedBuilder(
      animation: _sidebarCtrl,
      builder: (context, child) {
        final progress = _sidebarFadeAnim.value;
        final scaleValue = 0.85 + (0.15 * progress);
        final rotationY = (1 - progress) * 0.15;
        final translationZ = progress * 50;
        return Transform(
          alignment: Alignment.centerRight,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0008)
            ..translate(0.0, 0.0, translationZ)
            ..scale(scaleValue)
            ..rotateY(-rotationY),
          child: Material(
            elevation: 0,
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: _sidebarRadius, bottomLeft: _sidebarRadius),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: _sidebarRadius, bottomLeft: _sidebarRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                child: SidebarDrawer(
                  selectedItem: '',
                  onItemTap: (title) {
                    _showMsg('$title selected');
                    _toggleSidebar();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    return Scaffold(
      backgroundColor: _bgColor,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _contentCtrl,
            builder: (context, child) => Transform.scale(
              scale: _contentScaleAnim.value,
              child: SlideTransition(position: _contentShiftAnim, child: content),
            ),
          ),
          if (_sidebarOpen) Positioned.fill(child: sidebarBackdrop),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            width: _drawerWidth(size.width, isTablet: isTablet, isLargeTablet: isLargeTablet),
            child: SlideTransition(
              position: _sidebarSlideAnim,
              child: FadeTransition(
                opacity: _sidebarFadeAnim,
                child: sidebarDrawer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
