import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proctor_rule/screens/main_screen.dart';
import 'screens/login.dart';

Future<void> main() async{
  // FirebaseApp firebaseApp = await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      theme: ThemeData(
        // primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      title: 'ProctorRule',
      home: FirebaseAuth.instance.currentUser == null ? const LoginScreen() : const MainScreen(),
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

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//
//   Future<FirebaseApp> _initializeFirebase() async {
//     FirebaseApp firebaseApp = await Firebase.initializeApp();
//     return firebaseApp;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: _initializeFirebase(),
//         builder: (context, snapshot) {
//       if(snapshot.connectionState == ConnectionState.done){
//         // print("Connection successful");
//         return const LoginScreen();
//       }
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     });
//   }
// }

