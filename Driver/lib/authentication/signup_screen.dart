import 'package:drivers_app/authentication/bus_info_screen.dart';
import 'package:drivers_app/authentication/login_screen.dart';
import 'package:drivers_app/global/global.dart';
import 'package:drivers_app/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget
{

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
{
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm()
  {
    if (nameTextEditingController.text.length < 3)
      {
        Fluttertoast.showToast(msg: "Name Must be At Least 3 Character");
      }

    else if (!emailTextEditingController.text.contains("@"))
      {
        Fluttertoast.showToast(msg: "Email Address Not Valid");
      }

    else if (phoneTextEditingController.text.isEmpty)
      {
        Fluttertoast.showToast(msg: "Phone number is required");
      }

    else if (passwordTextEditingController.text.length < 6)
      {
        Fluttertoast.showToast(msg: "Password must be at least 6 character");
      }

    else
      {
        saveDriverInfoNow();
      }
  }

  saveDriverInfoNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing, Please wait..",);
        }
    );

    final User? firebaseUser = (
        await fAuth.createUserWithEmailAndPassword(
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
        Map driverMap = 
        {
          "id": firebaseUser.uid,
          "name": nameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.trim(),
          "phone": phoneTextEditingController.text.trim(),

        };


        DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("Drivers");
        driversRef.child(firebaseUser.uid).set(driverMap);


        currentFirebaseUser = firebaseUser;
        Fluttertoast.showToast(msg: "Account has been Created.");
        Navigator.push(context, MaterialPageRoute(builder: (c)=> BusInfoScreen()));
      }
    else 
      {
        Fluttertoast.showToast(msg: "Account Not Created Yet");
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('images/img.png'),
              ),

              const SizedBox(height: 20,),

              const Text(
                "REGISTRATION AS BUS DRIVER",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              TextField(
                controller: nameTextEditingController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Name",
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
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  labelText: "Mobile Number",
                  hintText: "Phone Number",
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
                    borderSide: BorderSide(color: Colors.white),
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

              const SizedBox(height: 25),
              
              ElevatedButton(
                  onPressed: ()
                  {
                    validateForm();
                  },

                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                ),
                child: const Text(
                  "Create New Account",
                      style: TextStyle(
                    color: Colors.black,
                  fontSize: 18,
                ),
                ),
              ),

              TextButton(
                  child: const Text(
                    "Already Have an Account? Click Here",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
