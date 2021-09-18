import 'package:flutter/material.dart';

class JumpImage extends StatefulWidget {
  @override
  _JumpImageState createState() => _JumpImageState();
}

class _JumpImageState extends State<JumpImage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    animation = Tween<double>(begin: 0, end: -200).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, animation.value),
                    child: child,
                  );
                },
                child: Container(
                  height: 300,
                  child: Image.asset('lib/assets/boy_jumping.jpg'),
                ),
              ),
              Container(
                height: 100,
                width: 80,
                child: CircleAvatar(
                  child: TextButton(
                    child: const Text(
                      'Jump',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await controller.forward();
                      await controller.reverse();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}
