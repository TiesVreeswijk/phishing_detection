import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PulsingActionCircle extends StatefulWidget {
  final double size;
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const PulsingActionCircle({
    super.key,
    required this.size,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  State<PulsingActionCircle> createState() => _PulsingActionCircleState();
}

class _PulsingActionCircleState extends State<PulsingActionCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulseOne;
  late final Animation<double> _pulseTwo;
  late final Animation<double> _fadeOne;
  late final Animation<double> _fadeTwo;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();

    _pulseOne = Tween<double>(begin: 1.0, end: 1.32).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.7, curve: Curves.easeOut)),
    );

    _pulseTwo = Tween<double>(begin: 1.0, end: 1.48).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 1.0, curve: Curves.easeOut)),
    );

    _fadeOne = Tween<double>(begin: 0.22, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.7, curve: Curves.easeOut)),
    );

    _fadeTwo = Tween<double>(begin: 0.14, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 1.0, curve: Curves.easeOut)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final innerCircleSize = widget.size * 0.42;
    final hasSubtitle = widget.subtitle != null && widget.subtitle!.isNotEmpty;

    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: widget.size * 1.55,
        height: widget.size * 1.55,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Transform.scale(
                  scale: _pulseTwo.value,
                  child: Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withOpacity(_fadeTwo.value),
                    ),
                  ),
                ),
                Transform.scale(
                  scale: _pulseOne.value,
                  child: Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withOpacity(_fadeOne.value),
                    ),
                  ),
                ),
                Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.18),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: innerCircleSize,
                        height: innerCircleSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryLight.withOpacity(0.35),
                        ),
                        child: Icon(
                          widget.icon,
                          color: Colors.white,
                          size: innerCircleSize * 0.42,
                        ),
                      ),
                      SizedBox(height: widget.size * 0.07),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: widget.size * 0.075,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (hasSubtitle) ...[
                        SizedBox(height: widget.size * 0.015),
                        Text(
                          widget.subtitle!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.70),
                            fontSize: widget.size * 0.045,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.7,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}