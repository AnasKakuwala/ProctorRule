import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //****************************************Creating controllers****************************************
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //****************************************Creating login function****************************************
  static Future<User?> loginUsingEmailPassword({required String email, required String password,required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      return user;
    } on FirebaseAuthException catch(e){
      if(e.code == "user-not-found"){
        print("User no found!!");
      }
    }
  }


  var _isVisible = false;
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25,),
              Container(height: deviceHeight * 0.30,
                child: FittedBox(
                  child: CircleAvatar(
                    backgroundColor: Colors.black12,
                    backgroundImage: AssetImage('assets/images/professor.png'),
                    radius: 120,
                  ),
                ),
              ),
              Container(
                height: deviceHeight * 0.65,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: LayoutBuilder(
                  builder: (ctx,constraints) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text('Login',style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),
                       SizedBox(height: constraints.maxHeight * 0.08,),
                       Container(
                         height: constraints.maxHeight * 0.12,
                         decoration: BoxDecoration(
                             color: Color(0xffB4B4B4).withOpacity(0.4),
                             borderRadius: BorderRadius.circular(60)),
                         child: Padding(
                           padding: const EdgeInsets.only(left: 15),
                           child: Center(
                             child: TextField(
                               controller: emailController,
                               decoration: InputDecoration(
                                 border: InputBorder.none,
                                 hintText: "abc@gmail.com",
                               ),
                             ),
                           ),
                         ),
                       ),
                       SizedBox(
                         height: constraints.maxHeight * 0.01,
                       ),
                       Container(
                         height: constraints.maxHeight * 0.12,
                         decoration:  BoxDecoration(
                            color: Color(0xffB4B4B4).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(60)
                          ),
                         child: Padding (
                           padding: const EdgeInsets.only(left: 15),
                           child:  Center(
                             child:  TextField(
                               controller: passwordController,
                               obscureText: _isVisible?false:true,
                               decoration:  InputDecoration(
                                 suffixIcon:  IconButton(
                                   onPressed: () {
                                     setState(() {
                                        _isVisible = !_isVisible;
                                     });
                                   },
                                   icon: Icon(_isVisible?Icons.visibility:  Icons.visibility_off,color: Colors.grey,),
                                 ),
                                 border: InputBorder.none,
                                 hintText: 'Password'
                               ),
                             ),
                           ),
                         ),
                       ),
                       Container(
                         width: double.infinity,
                         height: constraints.maxHeight * 0.12,
                         margin: EdgeInsets.only(top: constraints.maxHeight * 0.05),
                         child: ElevatedButton(
                           onPressed: () async {
                             User? user = await loginUsingEmailPassword(email: emailController.text, password: passwordController.text, context: context);
                             print(user);
                             if(user != null){
                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
                             }
                           },
                           child: Text('Login',
                             style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 22),
                           ),
                           style: ElevatedButton.styleFrom(
                             primary: Color(0xff4e6491),
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))
                           ),
                         ),
                       ),
                       SizedBox(height: constraints.maxHeight * 0.02)
                     ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
