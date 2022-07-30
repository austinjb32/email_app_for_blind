import 'package:email_project/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
        child:Column(
          children: [
            FloatingActionButton(
                onPressed:() async {
                  await FirebaseAuth.instance.signOut();
                  setState(() {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                 },
                  );},
                child: Icon(Icons.logout)),
            Text("Logout")
          ],
        )
      ),
    );
  }
}
