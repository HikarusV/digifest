import 'package:digifest/presentation/pages/home_pages.dart';
import 'package:digifest/presentation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 50,
                  color: Colors.red,
                ),
                const SizedBox(
                  height: 60,
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
                                builder: (context) => const HomePages(),
                              ));
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
