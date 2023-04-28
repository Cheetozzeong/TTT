import 'package:flutter/material.dart';


class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('CreateScreen', style: TextStyle(fontSize: 30),)),
    );
  }
}