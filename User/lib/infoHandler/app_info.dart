import 'package:flutter/material.dart';
import 'package:users_app/models/directions.dart';

class AppInfo extends ChangeNotifier
{
  Directions? userPickupLocation, userDropOffLocation;

  void updatePickupLocationAddress(Directions userPickupAddress)
  {
    userPickupLocation = userPickupAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Directions DropOffAddress)
  {
    userDropOffLocation = DropOffAddress;
    notifyListeners();
  }

}