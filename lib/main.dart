import 'controllers/food_detail_controller.dart';
import "controllers/home_controller.dart";
import 'views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack); hide Android statusbar
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeController()..init()),
        ChangeNotifierProvider(create: (context) => FoodDetailController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Scaffold(
          backgroundColor: Colors.white,
          body: HomeScreen(),
        ),
      ),
    );
  }
}
