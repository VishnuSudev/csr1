import 'package:csr/firebase.dart';
import 'package:flutter/material.dart';

class customerDashboard extends StatefulWidget {
  const customerDashboard({super.key});

  @override
  State<customerDashboard> createState() => _customerDashboardState();
}

class _customerDashboardState extends State<customerDashboard> {
  String nam="loading";
  @override
  void initState() {
    super.initState();
    getdetails();
  }
Future logout()async {
  await AuthService().googleSignOut();
}
 Future getdetails()async {
    Map<String, dynamic>? a=await AuthService().getUserData(AuthService().firebaseAuth.currentUser!.uid);
    final String name=a!['name'];
    setState(() {
      nam=a['name'];
    });
  }

 
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Customer Dashboard"),
          actions: [IconButton(onPressed: (){logout();}, icon: Icon(Icons.logout))],
        ),
        body: Center(child: Column(children: [
          Container(child: Text("Welcome to customer dashboard"),),
          SizedBox(height: 10,),
          Text(nam),
  
        ],)),
      ),
    );
  }
}
