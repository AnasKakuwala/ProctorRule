import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:proctor_rule/Widgets/main_body.dart';
import 'package:proctor_rule/Widgets/mse_screen.dart';
import 'package:proctor_rule/main.dart';
import 'package:proctor_rule/screens/mse.dart';
import '../Widgets/app_drawer.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int myIndex = 0;
  List<Widget> screens = [
    const MainScreen(),
    const MSE(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Text("ProctorRule",style: TextStyle(color: Colors.white),),
      ),
      body: const MainBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.grey
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Schedule Exam',
              backgroundColor: Colors.grey
          ),
        ],
      ),
    );
  }
}
