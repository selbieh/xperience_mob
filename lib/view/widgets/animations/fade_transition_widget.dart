import 'package:flutter/material.dart';

class FadeTransitionWidget extends StatefulWidget {
  const FadeTransitionWidget({
    required this.child,
    this.begin = 0.0,
    this.end = 1.0,
    this.milliseconds = 2000,
    this.curve = Curves.fastOutSlowIn,
    Key? key,
  }) : super(key: key);
  final double end;
  final double begin;
  final Widget child;
  final int milliseconds;
  final Curve curve;
  @override
  FadeTransitionWidgetState createState() => FadeTransitionWidgetState();
}

class FadeTransitionWidgetState extends State<FadeTransitionWidget> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      duration: Duration(milliseconds: widget.milliseconds),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: widget.begin, end: widget.end)
        .animate(CurvedAnimation(parent: animationController, curve: widget.curve));
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: widget.child,
    );
  }
}