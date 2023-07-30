import 'package:flutter/material.dart';

class SplashscreenPages extends StatelessWidget {
  const SplashscreenPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Digifest Movement",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              width: 100,
              height: 50,
              color: Colors.blue,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              '"Plan, Save, Prosper"',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
