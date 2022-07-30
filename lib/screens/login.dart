import 'package:email_project/screens/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


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
      appBar: AppBar(
        title: Text('Auth User (Logged'+(user ==null ? 'out':'in')+')'),
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xffaa076b), Color(0xff61045f)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.4, 0.7],
              tileMode: TileMode.repeated,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
          margin: EdgeInsets.all(20.0),
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            controller: emailController,
            decoration: InputDecoration(
                labelText: "Email",
                hintText: "example@email.com"
            ),
          ),
        )
    );
  }

  Widget passwordField() {
    return (
        Container(
          margin: EdgeInsets.all(20.0),
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
                labelText: "Password",
                hintText: "Password"
            ),
          ),
        )
    );
  }

  Widget submitButton(BuildContext context) {
    return (
        ElevatedButton(onPressed: () async {
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
        margin: EdgeInsets.symmetric(horizontal: 30.0),
        child: Text('Login'),
    ),)
    );
  }

  Widget signUpButton(BuildContext context) {
    return (
        ElevatedButton(onPressed: () async {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text,
          );
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => LoginPage()));
        },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text('Signup'),
            )

        )
    );
  }

}