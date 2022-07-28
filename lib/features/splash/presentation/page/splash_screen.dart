import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/homescreen/presentation/page/home_screen.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('images/pg1.png'),
      logoSize: 100,
      title: const Text(
        'Welcome',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor:  Colors.green,
      showLoader: true,
      loadingText: const Text(
          '                          Loading...\n Copyright © 2022 Ahmed Megahed.\n                   All rights reserved. '),
     navigator: const HomePage1(),
      durationInSeconds: 4,
    );
  }
}
