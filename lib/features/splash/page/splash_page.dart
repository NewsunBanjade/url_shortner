import 'package:flutter/material.dart';
import 'package:vrit_project/features/home/page/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Homepage(),
          ));
    });
    return const Scaffold(
      body: Center(
        child: Text("URL SHORTNET"),
      ),
    );
  }
}
