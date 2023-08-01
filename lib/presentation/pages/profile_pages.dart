import 'package:digifest/data/global.dart';
import 'package:digifest/presentation/pages/initiatename_pages.dart';
import 'package:digifest/presentation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePages extends StatefulWidget {
  const ProfilePages({Key? key}) : super(key: key);

  @override
  State<ProfilePages> createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  bool editMode = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 80,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(90),
              ),
              child: const Icon(
                Icons.person,
                size: 102,
                color: Colors.deepPurple,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 32,
                ),
                editMode
                    ? Expanded(
                        child: TextField(
                          controller: controller,
                          autofocus: true,
                        ),
                      )
                    : Text(
                        context.read<UserProvider>().getName(),
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                editMode
                    ? IconButton(
                        onPressed: () => setState(() {
                          editMode = false;
                          context
                              .read<UserProvider>()
                              .changeName(controller.text);
                        }),
                        icon: const Icon(Icons.done),
                      )
                    : IconButton(
                        onPressed: () => setState(() {
                          editMode = true;
                          controller.text =
                              context.read<UserProvider>().getName();
                        }),
                        icon: const Icon(Icons.edit),
                      )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Konfirmasi'),
                  content: const Text(
                      'Semua data yang ada tidak akan disimpan, apakah anda yakin untuk menghapus semua data?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        databaseHelper.deleteDatabase();
                        databaseHelper.database;
                        dataCache.clear();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InitiateNamePages(),
                          ),
                        );
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
