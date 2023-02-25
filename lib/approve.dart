import 'package:csr/firebase.dart';
import 'package:flutter/material.dart';

class Approve extends StatelessWidget {
  const Approve({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Approval status")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text("Account will be activated soon"),
            ),
            ElevatedButton(onPressed: (){AuthService().googleSignOut();}, child:Text("back to login"))
          ],
        ),

      ),
    );
  }
}
