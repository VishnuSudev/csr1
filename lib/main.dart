import 'package:csr/firebase.dart';
import 'package:csr/forget_password.dart';
import 'package:csr/home.dart';
import 'package:csr/login_page.dart';
import 'package:csr/register.dart';
import 'package:csr/verify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: AuthService().firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return VerifyEmailPage();
          }
          else{
            return LoginPage();
          }
        }
      ),
      routes: {
        'register': (context) => const RegisterPage(),
        'login': (context) => const LoginPage(),
        'home': (context) => const HomePage(),
        'forgot': (context) => const forgetPassword(),
        'verify': (context) =>  VerifyEmailPage(),

        
        
      },
    );
  }
}
