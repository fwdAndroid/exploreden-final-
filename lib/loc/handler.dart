import 'package:permission_handler/permission_handler.dart';

class Handler {
  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      await Permission.location.request();
    }
  }

  String fetchPlacePhotoUrl(String photoReference) {
    final String apiKey = 'AIzaSyB9ovPkJ-s1cXezeqrQRUxewuWSYNyjdPo';
    return 'https://maps.googleapis.com/maps/api/place/photo?'
        'maxwidth=400'
        '&photoreference=$photoReference'
        '&key=$apiKey';
  }
}
