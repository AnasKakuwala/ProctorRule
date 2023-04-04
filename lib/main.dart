import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProctorRule',
      home: HomeScreen(),
    );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'ProctorRule',
//       home: HomeScreen(),
//     );
//   }
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.done){
        print("Connection succesful");
        return LoginScreen();
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

