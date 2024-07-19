import 'package:geolocator/geolocator.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;

String selectedTimezone = 'default';

String getTimezone(){
  final timezoneName = DateTime.now().timeZoneName;
  switch(timezoneName){
    case 'WIB':
      return 'Asia/Jakarta';
    case 'WITA':
      return 'Asia/Makassar';
    case 'WIT':
      return 'Asia/Jayapura';
  }
  return 'Asia/Jakarta';
}

String convertGmtToTimezoneName(String gmt){
  switch(gmt){
    case "+07:00":
      return "WIB";
    case "+08:00":
      return "WITA";
    case "+09:00":
      return "WIT";
    default:
      return "WIB";
  }
}



String getTimezoneByLocation(double lat, double lng){
  if(selectedTimezone == 'default'){
    return tzmap.latLngToTimezoneString(lat, lng);
  } else {
    return convertGmtToTimezoneName(selectedTimezone);
  }
}

Future<String> getTimezoneFromLastKnownLocation() async {
  final permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
    return getTimezone();
  }
  final position = await Geolocator.getLastKnownPosition();
  if(position == null){
    return getTimezone();
  } else if(selectedTimezone == 'default'){
    return tzmap.latLngToTimezoneString(position.latitude, position.longitude);
  } else {
    return selectedTimezone;
  }
}

String convertToGmt(String nativeTimezone){
  return nativeTimezone;

}