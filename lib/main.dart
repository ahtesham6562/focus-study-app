import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification/firebase_options.dart';
import 'package:notification/screens/HomeScreen.dart';
import 'package:notification/screens/login.dart';
import 'package:notification/screens/main_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Myapp());
}
class Myapp extends StatelessWidget {
  final FirebaseAuth _auth=FirebaseAuth.instance;
   Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"remainder app",
      debugShowCheckedModeBanner: false,
      home: _auth.currentUser!=null?MainScreen():LoginScreen(),
    );
  }
}
