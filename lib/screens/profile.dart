import 'package:email_project/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


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
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Container(
          child:Column(
            children: [
              Container(
                  child: Image.asset('assets/images/User.png'),
                  width: 250,
                  height: 250,
                ),
         Container(child: Text('Welcome, User',
              style: GoogleFonts.ubuntu(
                  fontSize: 20,
                  color: Colors.black87
              ))),
              SizedBox(height: 50.0),
          FloatingActionButton(
                    onPressed:() async {
                      await FirebaseAuth.instance.signOut();
                      setState(() {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => LoginPage()));
                     },
                      );},
                    child: Icon(Icons.logout,color: Color(0xffF9AA33)),


          ),
            ],
          )
        ),
      ),
    );
  }
}
