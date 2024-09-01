import 'package:flutter/material.dart';
import 'package:tractian_challenge/companies/companies.store.dart';
import 'package:tractian_challenge/home/home.screen.dart';

import '../helpers/size_config.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    animation.addListener(() => setState(() {}));
    _controller.forward();

    Future.delayed(const Duration(seconds: 3)).then((_) async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeTransition(
                opacity: animation,
                child: Image.asset(
                  'assets/images/tractian-logo.png',
                  width: SizeConfig.of(context).dynamicScaleSize(size: 250),
                  height: SizeConfig.of(context).dynamicScaleSize(size: 250),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
