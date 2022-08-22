import 'package:drivers_app/global/global.dart';
import 'package:drivers_app/splashScreen/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BusInfoScreen extends StatefulWidget
{

  @override
  State<BusInfoScreen> createState() => _BusInfoScreenState();
}

class _BusInfoScreenState extends State<BusInfoScreen> {

  TextEditingController plateNumberTextEditingController = TextEditingController();
  TextEditingController busColorTextEditingController = TextEditingController();

  saveBusInfo()
  {
    Map driverBusInfoMap =
    {
      "plate_number": plateNumberTextEditingController.text.trim(),
      "bus_color": busColorTextEditingController.text.trim(),
    };

    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("Drivers");
    driversRef.child(currentFirebaseUser!.uid).child("Bus_details").set(driverBusInfoMap);
    
    Fluttertoast.showToast(msg: "Bus details saved successfully");
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('images/img.png'),
              ),

          const Text(
              "Insert Plate Number",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
              TextField(
                controller: plateNumberTextEditingController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  labelText: "Plate Number",
                  hintText: "Bus Plate Number",
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
                controller: busColorTextEditingController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  labelText: "Bus Color",
                  hintText: "Color",
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

              const SizedBox(height: 20,),

              const SizedBox(height: 100),

              ElevatedButton(
                onPressed: ()
                {
                  if(busColorTextEditingController.text.isNotEmpty &&
                      plateNumberTextEditingController.text.isNotEmpty)
                    {
                      saveBusInfo();
                    }
                },

                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                ),
                child: const Text(
                  "SAVE",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
          ],
      ),
        ),
      ),
    );
  }
}
