import 'package:digifest/common/state.dart';
import 'package:digifest/data/global.dart';
import 'package:digifest/presentation/pages/home_pages.dart';
import 'package:digifest/presentation/pages/initiatename_pages.dart';
import 'package:digifest/presentation/pages/splashscreen.dart';
import 'package:digifest/presentation/provider/splash_provider.dart';
import 'package:digifest/presentation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/db/database_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  databaseHelper = DatabaseHelper();
  databaseHelper.database;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(
        create: (context) => UserProvider(),
      ),
      ChangeNotifierProvider<StateProvider>(
        create: (context) => StateProvider()..splashscreenController(5),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Consumer<StateProvider>(
        builder: (context, value, child) {
          if (value.state == ResultState.hasData) {
            return const InitiateNamePages();
          } else {
            return const SplashscreenPages();
          }
        },
      ),
    );
  }
}
