import 'package:flutter/material.dart';
import 'package:machine_test/utils/Provider.dart';
import 'package:provider/provider.dart';

import 'Ui/StartUpScreen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<DataProvider>(
        create: (context) => DataProvider()),

  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Inter',
        useMaterial3: false,
      ),
      home: StartUpScreen(),
    );
  }
}