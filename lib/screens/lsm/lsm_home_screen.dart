import 'package:flutter/material.dart';

class LsmHomeScreen extends StatelessWidget {
  const LsmHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('Read LSM'),),
    );
  }
}