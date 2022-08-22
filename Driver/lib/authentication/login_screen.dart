import 'package:drivers_app/authentication/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm()
  {
    if (!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email Address Not Valid");
    }

    else if (passwordTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Password is Mandatory");
    }

    else
    {
      loginDriverNow();
    }
  }

  loginDriverNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Welcome",);
        }
    );

    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg)
        {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {

      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("Drivers");
      driversRef.child(firebaseUser.uid).once().then((driverKey)
      {
        final snap = driverKey.snapshot;
        if (snap.value != null)
          {
            currentFirebaseUser = firebaseUser;
            Fluttertoast.showToast(msg: "Login Successful.");
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
          }

        else
          {
            Fluttertoast.showToast(msg: "Login Failed. Please use registered email "
                "and password");
            fAuth.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const
            MySplashScreen()));
          }

      });
    }
    else
    {
      Fluttertoast.showToast(msg: "Please Enter Registered Email & Password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('images/img.png'),
              ),

              const SizedBox(height: 20,),

              const Text(
                "LOGIN AS DRIVER",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Email Address",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),

                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),

                  hintStyle: TextStyle(
                    color: Colors.black26,
                    fontSize: 18,
                  ),

                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),

              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),

                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),

                  hintStyle: TextStyle(
                    color: Colors.black26,
                    fontSize: 18,
                  ),

                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),

              const SizedBox(height: 30,),

              ElevatedButton(
                onPressed: ()
                {
                  validateForm();
                },

                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                ),
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),

              const SizedBox(height: 20,),
              
              TextButton(
                child: const Text(
                  "Not Register Yet? Click Here",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> SignUpScreen()));
                  }

              ),
            ],
          ),
        ),
      ),
    );
  }
}
