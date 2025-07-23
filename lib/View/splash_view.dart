import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/auth_controller.dart';
import 'package:get/get.dart';


class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startApp();
  }

  void _startApp() async {
    setState(() => _opacity = 1.0); 

    await Get.find<AuthController>().handleStartup();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: AnimatedOpacity(
          duration: const Duration(seconds: 3),
          opacity: _opacity,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlutterLogo(size: 100),
              SizedBox(height: 20),
              Text(
                "Hoşgeldin",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
    ));
  }
}
