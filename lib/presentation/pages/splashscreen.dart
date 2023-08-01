import 'package:flutter/material.dart';

class SplashscreenPages extends StatelessWidget {
  const SplashscreenPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
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
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              width: 200,
              height: 130,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo-digifest.png'),
                  fit: BoxFit.cover,
                ),
              ),
              // color: Colors.blue,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              '"Plan, Save, Prosper"',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
