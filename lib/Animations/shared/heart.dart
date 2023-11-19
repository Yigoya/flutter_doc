import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  bool isFav = false;
  late AnimationController _controller;
  late Animation _colorAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(_controller);
    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween<double>(begin: 30, end: 50), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 50, end: 30), weight: 50)
    ]).animate(_controller);
    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(
          () {
            isFav = true;
          },
        );
      }
      if (status == AnimationStatus.dismissed) {
        setState(
          () {
            isFav = false;
          },
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return IconButton(
            onPressed: () {
              isFav ? _controller.reverse() : _controller.forward();
            },
            icon: Icon(
              Icons.favorite,
              color: _colorAnimation.value,
              size: _sizeAnimation.value,
            ));
      },
    );
  }
}
