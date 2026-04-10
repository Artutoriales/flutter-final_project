import 'package:flutter/material.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget{
  const Login ({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Text("data", style: TextStyle(fontSize: 20),),
      )
    );
  }
}
