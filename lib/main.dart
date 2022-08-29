import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200],
        primaryColor: Color(0xff36c9c5),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      // home:StreamBuilder(
      //     stream: FirebaseAuth.instance.authStateChanges(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         return HomePage();
      //       } else {
      //         return Login();
      //       }
      //     }
      // ),
    );
  }
}