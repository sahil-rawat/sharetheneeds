import 'package:flutter/material.dart';
import 'package:hacknu/screens/loginscreen.dart';
import 'package:hacknu/screens/event.dart';
import 'package:hacknu/screens/log_in.dart';
import 'package:hacknu/screens/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:hacknu/task_data.dart';
import 'package:hacknu/screens/ourvision.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>TaskData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LogIn.id,
        routes: {
          LogIn.id:(context)=>LogIn(),
          MainScreen.id:(context)=>MainScreen(),
          LoginScreen.id:(context)=>LoginScreen(),
          AddEvent.id:(context)=>AddEvent(),
          OurVision.id:(context)=>OurVision(),
        },
      ),
    );
  }
}



