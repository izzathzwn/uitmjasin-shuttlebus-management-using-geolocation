import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:users_app/global/global.dart';

class SelectNearestActiveDriverScreen extends StatefulWidget {
  const SelectNearestActiveDriverScreen({Key? key}) : super(key: key);

  @override
  State<SelectNearestActiveDriverScreen> createState() => _SelectNearestActiveDriverScreenState();
}

class _SelectNearestActiveDriverScreenState extends State<SelectNearestActiveDriverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Nearest Online Driver",
          style: TextStyle(
            fontSize: 18,
          ),
        ),

        leading: IconButton(
          icon: Icon(
            Icons.close, color: Colors.white,
          ),
            onPressed: ()
            {
              SystemNavigator.pop();
            }
        ),
      ),

      body: ListView.builder(
        itemCount: dList.length,
        itemBuilder: (BuildContext context, int index)
          {
            return Card(
              color: Colors.grey,
              elevation: 3,
              shadowColor: Colors.green,
              margin: EdgeInsets.all(8),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Image.asset(
                    "images/" + dList[index]["Bus_details"]["plate_number"]
                        .toString() + ".png",
                    width: 70,
                  ),
                ),
                title: Column(
                  children: [
                    Text(
                      dList[index]["name"],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      dList[index]["Bus_details"]["plate_number"],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "3",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 2,),
                    Text(
                      "3 km",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
