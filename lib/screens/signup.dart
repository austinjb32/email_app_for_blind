import 'package:email_project/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title:Text("Sign Up")
      ),
      body: Column(
        children:[
          emailField(),
          passwordField(),
          signUpButton(context)
        ]
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
          controller: passwordController,
          decoration: InputDecoration(
              labelText: "Password",
              hintText: "Password"
          ),
        ),
      )
  );
}

Widget signUpButton(BuildContext context) {
  return (
      ElevatedButton(onPressed: () async{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
        );
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => LoginPage()));
      },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text('SignUp'),
          )

      )
  );
}

}