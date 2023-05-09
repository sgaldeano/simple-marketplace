import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {

  final Widget child;

  const AuthBackground({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            const _BubblesBox(),

            const _HeaderIcon(),

            child
          ]
        )
      )
    );
  }

}

class _BubblesBox extends StatelessWidget {

  const _BubblesBox({Key? key}) : super(key: key);

  final BoxDecoration _bubblesBackground = const BoxDecoration(
    gradient: LinearGradient(
        colors: [
          Color.fromRGBO(63, 63, 156, 1),
          Color.fromRGBO(90, 70, 178,1)
        ]
    )
  );

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _bubblesBackground,
      child: Stack(
        children: const [
          _Bubble(top: 90, left: 30),
          _Bubble(top: -40, left: -30),
          _Bubble(top: -50, right: -20),
          _Bubble(bottom: -50, left: 10),
          _Bubble(bottom: 120, right: 20)
        ],
      )
    );
  }

}

class _Bubble extends StatelessWidget {

  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  const _Bubble({
    Key? key,
    this.top,
    this.bottom,
    this.left,
    this.right
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(225, 225, 225, 0.05)
        )
      ),
    );
  }

}

class _HeaderIcon extends StatelessWidget {

  const _HeaderIcon();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 40),
          child: const Icon(Icons.person_pin, color: Colors.white, size: 100)
      ),
    );
  }

}