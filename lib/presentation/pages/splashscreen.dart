import 'package:digifest/presentation/widget/stroke_text.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: Column(
                children: [
                  Container(
                    width: 250,
                    height: 50,
                    decoration: const BoxDecoration(
                      // color: Colors.amber,
                      image: DecorationImage(
                        image: AssetImage('assets/std-white.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const StrokeText(
                    text: 'In association with',
                    size: 14,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          // color: Colors.amber,
                          image: DecorationImage(
                            image: AssetImage('assets/twh.png'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 110,
                        height: 60,
                        decoration: const BoxDecoration(
                          // color: Colors.amber,
                          image: DecorationImage(
                            image: AssetImage('assets/pkm.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const StrokeText(
                  text: "Digifest Movement",
                  size: 30,
                ),
                const SizedBox(
                  height: 40,
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
                  height: 30,
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
            Column(
              children: [
                const Text(
                  'With coorperation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    // color: Colors.amber,
                    image: DecorationImage(
                      image: AssetImage('assets/perahukertas-trp.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
