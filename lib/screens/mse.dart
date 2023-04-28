import 'package:flutter/material.dart';
// import 'package:proctor_rule/screens/main_screen.dart';

import '../Widgets/mse_screen.dart';

class MSE extends StatefulWidget {
  const MSE({Key? key}) : super(key: key);

  @override
  State<MSE> createState() => _MSEState();
}

class _MSEState extends State<MSE> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: BackButton(
        //   onPressed: () => {
        //     Navigator.pop(context),
        //   },
        // ),
        backgroundColor: Colors.grey[700],
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("MSE",
          style: TextStyle(
              color: Colors.white,
              ),
        ),
      ),
      body: const MseWid(),
    );
  }
}
