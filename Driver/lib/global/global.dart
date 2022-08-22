import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import '../models/driver_data.dart';
import '../models/user_model.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
StreamSubscription<Position>? streamSubscription;
StreamSubscription<Position>? streamSubscriptionDriverLiveSubscription;
Position? driverCurrentPosition;
DriverData onlineDriverData = DriverData();