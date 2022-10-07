import 'package:fabdashboard/views/screens/dashbord.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

// ...

void main() async {
  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        //initialRoute: '/Dashborde',
        title: 'FabLab Dashboard',
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        debugShowCheckedModeBanner: false,
        home: const DashbordPage());
  }
}
