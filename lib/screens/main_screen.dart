import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../Widgets/app_drawer.dart';
import '../Widgets/main_body.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("ProctorRule"),
      ),
      body: MainBody(),
    );
  }
}
