import 'package:digifest/data/global.dart';
import 'package:digifest/presentation/pages/home_pages.dart';
import 'package:digifest/presentation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_pages.dart';
import '../widget/stroke_text.dart';

class InitiateNamePages extends StatefulWidget {
  const InitiateNamePages({super.key});

  @override
  State<InitiateNamePages> createState() => _InitiateNamePagesState();
}

class _InitiateNamePagesState extends State<InitiateNamePages> {
  TextEditingController nameController = TextEditingController();
  bool emptyName = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.yellow,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Positioned(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: 250,
                    height: 50,
                    decoration: const BoxDecoration(
                      // color: Colors.amber,
                      image: DecorationImage(
                        image: AssetImage('assets/std-black.png'),
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
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 250,
                  height: 250,
                  decoration: const BoxDecoration(
                    // color: Colors.redAccent,
                    image: DecorationImage(
                      image: AssetImage('assets/ilustration.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  // color: Colors.yellow,
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Your Name : '),
                      TextField(
                        controller: nameController,
                        onChanged: (value) {
                          setState(() {
                            emptyName = value.isEmpty;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 120,
              bottom: 20,
              left: MediaQuery.of(context).size.width - 120,
              right: 0,
              child: Container(
                // color: Colors.green,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: emptyName
                    ? Container()
                    : InkWell(
                        borderRadius: BorderRadius.circular(90),
                        radius: 90,
                        child: const Icon(
                          Icons.arrow_circle_right,
                          size: 50,
                        ),
                        onTap: () {
                          context
                              .read<UserProvider>()
                              .changeName(nameController.text);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainPages(),
                            ),
                          );
                        },
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
