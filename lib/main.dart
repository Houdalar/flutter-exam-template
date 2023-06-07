import 'package:exam/screens/buttom_home.dart';
import 'package:exam/screens/home_tab.dart';
import 'package:exam/screens/login_screen.dart';
import 'package:exam/screens/product_details.dart';
import 'package:flutter/material.dart';

import 'models/currencies.dart';
import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) {
          // Extract the user object from the arguments
          final User user = ModalRoute.of(context)!.settings.arguments as User;

          // Pass the user object to the HomePage widget
          // return HomePage(user: user);
          return HomeTab(user: user);
        },
      },
    );
  }
}
