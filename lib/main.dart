import 'package:csr/Admin/admin.dart';
import 'package:csr/Admin/customer_display.dart';
import 'package:csr/Admin/merchant_approve.dart';
import 'package:csr/Admin/merchant_display.dart';
import 'package:csr/approve.dart';
import 'package:csr/customer.dart';
import 'package:csr/firebase.dart';
import 'package:csr/forget_password.dart';
import 'package:csr/home.dart';
import 'package:csr/login_page.dart';
import 'package:csr/merchant.dart';
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
  void initState() {
    super.initState();
    //  getdetails();
  }

  String role = "customer";
  String sts = "nil";
  Future getdetails() async {
    Map<String, dynamic>? a = await AuthService()
        .getUserData(AuthService().firebaseAuth.currentUser!.uid);
    final String name = a!['name'];
    setState(() {
      role = a['role'];
      sts = a['status'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: AuthService().firebaseAuth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
                getdetails();
              if (role == 'cus') {
                return const customerDashboard();
              }
              else if (role == 'mer') {
                if (sts == 'true') {
                  return const merchantDashboard();
                } else {
                  return Approve();
                }
              } 
              return Scaffold(
                body: Column(
                  children: [
                    Container(
                      child: const Text("Loading."),
                    ),
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                ),
              );
            
            } else {
              return const LoginPage();
            }
          }),
      routes: {
        'register': (context) => const RegisterPage(),
        'login': (context) => const LoginPage(),
        'home': (context) => const HomePage(),
        'forgot': (context) => const forgetPassword(),
        'verify': (context) => VerifyEmailPage(),
        'customer': (context) => const customerDashboard(),
        'merchant': (context) => const merchantDashboard(),
        'admin': (context) => const Admin(),
        'dismer': (context) => const merchantDisplay(),
        'discus': (context) => const customerDisplay(),
        'appmer': (context) => const merchantApprove(),
      },
    );
  }
}
