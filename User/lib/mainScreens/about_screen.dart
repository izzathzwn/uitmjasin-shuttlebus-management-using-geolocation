import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget
{

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: ListView(
        children: [
          Container(

            height: 200,
            child: Center(
              child: Image.asset(
              "images/bus_icon.png",
              width: 260,
              ),
            ),
          ),

          const SizedBox(height: 40.0,),

          //Apps Name
          Column(
            children: const [
               Text(
                "UiTM JASIN SHUTTLE BUS MANAGEMENT"
                    "SYSTEM USING GEOLOCATION - USER",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),


            ],
          ),
        ],
      ),
    );
  }
}
