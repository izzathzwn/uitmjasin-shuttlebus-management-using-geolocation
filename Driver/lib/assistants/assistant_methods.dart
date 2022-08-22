import 'package:drivers_app/assistants/request_assistant.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../global/global.dart';
import '../global/map_key.dart';
import '../infoHandler/app_info.dart';
import '../models/direction_details_info.dart';
import '../models/directions.dart';
import '../models/user_model.dart';

class AssistantMethods
{
  static Future<String> searchAddressforGeographicCoordinates(Position position, context) async
  {
    String apiUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}"
        "&key=$mapKey";
    String humanReadableAddress = "";

    var requestResponse = await RequestAssistant.receiveRequest(apiUrl);
    if(requestResponse != "Error. Please Try Again")
    {
      humanReadableAddress = requestResponse["results"][0]["formatted_address"];
      Directions userPickupAddress = Directions();
      userPickupAddress.locationLatitude = position.latitude;
      userPickupAddress.locationLongitude = position.longitude;
      userPickupAddress.locationName = humanReadableAddress;

      Provider.of<AppInfo>(context, listen: false).updatePickupLocationAddress(userPickupAddress);
    }

    return humanReadableAddress;

  }
  static void readCurrentOnlineUserInfo() async
  {
    currentFirebaseUser = fAuth.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance.ref()
        .child("Users")
        .child(currentFirebaseUser!.uid);

    userRef.once().then((snap){
        if (snap.snapshot.value != null)
          {
            userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
          }
    });
  }

  static Future<DirectionDetailsInfo?> obtainOriginToDestinationDirectionDetails
      (LatLng originPosition, LatLng destinationPosition) async
  {
    String urlOriginToDestinationDirectionDetails =
    "https://maps.googleapis.com/maps/api/directions/json?origin=${originPosition.latitude},${originPosition.longitude}&destination=${destinationPosition.latitude},${destinationPosition.longitude}&key=$mapKey";

    var responseDirectionApi = await RequestAssistant
        .receiveRequest(urlOriginToDestinationDirectionDetails);
    if(responseDirectionApi == "Error. Please Try Again")
    {
      return null;
    }

    DirectionDetailsInfo directionDetailsInfo = DirectionDetailsInfo();
    directionDetailsInfo.e_points = responseDirectionApi["routes"][0]["overview polyline"]["points"];
    directionDetailsInfo.distance_text = responseDirectionApi ["routes"][0]["legs"][0]["distance"]["text"];
    directionDetailsInfo.distance_value = responseDirectionApi ["routes"][0]["legs"][0]["distance"]["value"];

    directionDetailsInfo.duration_text = responseDirectionApi ["routes"][0]["legs"][0]["distance"]["text"];
    directionDetailsInfo.duration_value = responseDirectionApi ["routes"][0]["legs"][0]["distance"]["value"];
    return directionDetailsInfo;
  }

  static pauseLiveLocationUpdates()
  {
    streamSubscription!.pause();
    Geofire.removeLocation(currentFirebaseUser!.uid);
  }

  static resumeLiveLocationUpdates()
  {
    streamSubscription!.pause();
    Geofire.setLocation(
        currentFirebaseUser!.uid,
        driverCurrentPosition!.latitude,
        driverCurrentPosition!.longitude);
  }
}