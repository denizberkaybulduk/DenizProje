import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../Controller/auth_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AuthController _authController = Get.find<AuthController>();
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();


    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _opacity = 1.0);
    });


    _startInitialization();
  }

  Future<void> _startInitialization() async {
    
    await _authController.handleStartup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VisibilityDetector(
        key: const Key('splash'),
        onVisibilityChanged: (_) {},
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            opacity: _opacity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FlutterLogo(size: 100),
                SizedBox(height: 20),
                Text("Hoşgeldiniz", style: TextStyle(fontSize: 24)),
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
