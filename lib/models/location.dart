import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Map?> getCurrentLocation() async {
    print('calling location picker function inside LocationService class');
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        print('location denied');
        await Geolocator.requestPermission();
        return null;
      } else {
        Position currentposition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        print(
            'Accuracy of position: ---> ${await Geolocator.getLocationAccuracy()}\nLocation: Long: ${currentposition.longitude} and Lat: ${currentposition.latitude}');
        return {
          'longitude': currentposition.longitude,
          'latitude': currentposition.latitude
        };
      }
    } catch (e, stacktrace) {
      print(
          'GOT ERROR IN LOCATION CLASS------------------------\n$e\n++++++++++++++++++\n$stacktrace');
      return null;
    }
  }
}
