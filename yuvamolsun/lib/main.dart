import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yuvamolsun/loginregister.dart';
import 'package:yuvamolsun/anasayfa.dart';
import 'package:yuvamolsun/mainhome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yuvam Olsun',
      theme: ThemeData(
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          scaffoldBackgroundColor: Color(0xFFF5F6F8),
          primaryColor: Colors.deepOrangeAccent,
          primarySwatch: Colors.deepOrange),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => PageGetStared(),
        '/PageHome': (context) => PageHome(),
      },
    );
  }
}
