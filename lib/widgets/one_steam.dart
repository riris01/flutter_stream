import 'dart:math';
import 'package:flutter/material.dart';

class OneSteam extends StatefulWidget {
  static const int maxSteamNumber = 50;
  const OneSteam(
      {Key? key,
      required this.index,
      required this.screen,
      required this.sidePadding})
      : super(key: key);
  final int index;
  final Size screen;
  final double sidePadding;

  @override
  _OneSteamState createState() => _OneSteamState();
}

class _OneSteamState extends State<OneSteam>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        Future.delayed(
            Duration(milliseconds: (800 * Random().nextDouble()).floor()),
            () => _controller.forward());
      }
    });
    Future.delayed(
        Duration(milliseconds: (2800 * Random().nextDouble()).floor()),
        () => _controller.forward());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get minimumSteamWidth =>
      (widget.screen.width - widget.sidePadding * 2) / OneSteam.maxSteamNumber;

  @override
  Widget build(BuildContext context) {
    var circleSize = (widget.screen.width - widget.sidePadding * 2) / 4;
    var circleWidth = (minimumSteamWidth + (circleSize - minimumSteamWidth)) *
        _animation.value;
    return Positioned(
      left: widget.sidePadding +
          (widget.index * minimumSteamWidth) -
          circleWidth / 2 +
          widget.sidePadding / 2,
      bottom: (widget.screen.height - circleSize) * _animation.value,
      child: SizedBox(
        width: circleWidth,
        height: circleSize,
        child: CustomPaint(
          painter: OneSteamPainter(1 - _animation.value),
        ),
      ),
    );
  }
}

class OneSteamPainter extends CustomPainter {
  OneSteamPainter(this.opacity);
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    var p = Paint();
    p.color = Colors.white.withOpacity(opacity);
    p.maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);

    canvas.drawOval(Rect.fromLTWH(0, 0, size.width, size.height), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter coldDelegate) {
    return true;
  }
}
