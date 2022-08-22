import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/global/map_key.dart';
import 'package:users_app/infoHandler/app_info.dart';
import 'package:users_app/models/predicted_places.dart';
import 'package:users_app/widgets/progress_dialog.dart';
import '../assistants/request_assistant.dart';
import '../models/directions.dart';


class PlacePredictionTileDesign extends StatelessWidget
{
  final PredictedPlaces? predictedPlaces;

  PlacePredictionTileDesign({this.predictedPlaces});

  getPlaceDirectionDetails(String? placeId, context) async
  {
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
      message: "Setting up Location.."
        ),
    );

    String placeDirectionDetailsUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";

    var responseAPI = await RequestAssistant.recieveRequest(placeDirectionDetailsUrl);
    Navigator.pop(context);

    if(responseAPI == "Error. Please Try Again")
      {
        return;
      }

    if(responseAPI["status"] == "OK" )
      {
        Directions directions = Directions();
        responseAPI ["results"]["name"];
        directions.locationId = placeId;
        directions.locationName = responseAPI ["results"]["name"];
        directions.locationLatitude = responseAPI ["results"]["geometry"]["location"]["lat"];
        directions.locationLongitude = responseAPI ["results"]["geometry"]["location"]["lng"];
        
        Provider.of<AppInfo>(context, listen:false).updateDropOffLocationAddress(directions);
        Navigator.pop(context, "obtain DropOff");

      }
  }

  @override
  Widget build(BuildContext context)
  {
    return ElevatedButton(
      onPressed: ()
      {
          getPlaceDirectionDetails(predictedPlaces!.place_id, context);
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.white24,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            const Icon(
              Icons.add_location,
              color: Colors.grey,
            ),
            const SizedBox(width: 14.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0,),
                  Text(
                    predictedPlaces!.main_text!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 2.0,),
                  Text(
                    predictedPlaces!.secondary_text!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 8.0,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
