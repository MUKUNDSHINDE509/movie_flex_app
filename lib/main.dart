import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flex_app/utils/color_theme.dart';

import 'views/dashboard/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        scaffoldBackgroundColor: ColorTheme.primaryColor
      ),
      debugShowCheckedModeBanner: false,
      home: const DashBoardScreen(),
    );
  }
}

