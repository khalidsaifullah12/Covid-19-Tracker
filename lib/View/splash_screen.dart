import 'dart:async';

import 'package:covid/View/world_stats.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplahScreen extends StatefulWidget {
  const SplahScreen({Key? key}) : super(key: key);

  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WorldStats())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(
              animation: _controller,
              child:  Container(
                width: 200.0,
                height: 200.0,
                child: const Center(
                  child:  Image(
                    fit: BoxFit.cover,
                    image: AssetImage('images/virus.png'),
                  ),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .08,),
            const Align(
                alignment: Alignment.center,
                child :Text('Covid-19\nTracker App' , textAlign: TextAlign.center ,
                  style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25)
                  ,))
          ],
        ),
      ),
    );
  }
}
