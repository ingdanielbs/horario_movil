import 'package:api_horario_inst/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(        
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 2, 26, 55)),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

