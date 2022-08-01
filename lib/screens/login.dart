import 'package:email_project/screens/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: Text('Login',
                  style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87
                  ),
                ),
              ),
              emailField(),
              passwordField(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  submitButton(context),
                  signUpButton(context)
                ],
              )
            ],
          )
      ),
    );
  }


  Widget emailField() {
    return (
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
          child: TextField(
            enableIMEPersonalizedLearning: true,
            decoration: InputDecoration(
                labelText: "Username",
                hintText: "username@example.com",
                border: OutlineInputBorder()
            ),
            cursorColor: Color(0xff232F34),
            controller: emailController,
          ),
        )
    );
  }

  Widget passwordField() {
    return (
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
          child: TextField(
          decoration: InputDecoration(
              labelText: "Password",
              hintText: "Password",
              border: OutlineInputBorder()
    ),
            style: TextStyle(color: Colors.black87),
            cursorColor: Color(0xff232F34),
            obscureText: true,
            controller: passwordController,
          ),
        )
    );
  }

  Widget submitButton(BuildContext context) {
    return (
        ElevatedButton(onPressed: () async {
          HapticFeedback.heavyImpact();
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text,
          );
          setState(() {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MainScreen()));
          }
          );

        }, child:Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 12.0),
        child: Text('Login',
          style: GoogleFonts.ubuntu(
              fontSize: 20,
              color: Colors.black87
          ),
        ),
    ),style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),

            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black12)
                )
            )
        )
        )
    );
  }

  Widget signUpButton(BuildContext context) {
    return (
        ElevatedButton(onPressed: () async {
         HapticFeedback.heavyImpact();
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text,
          );
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => LoginPage()));
        },
            child:Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Text('Sign Up',
                style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    color: Colors.white
                ),
              ),
            ),style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black87),

                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white12)
                    )
                )
            )

        )
    );
  }

}