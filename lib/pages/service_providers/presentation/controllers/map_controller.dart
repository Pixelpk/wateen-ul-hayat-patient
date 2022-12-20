import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swift_care/export.dart';

class MapController extends GetxController {
  LocationPermission? permission;
  var distance;
  var time;
  var lat;
  var lng;
  Dio dio = new Dio();
  Completer<GoogleMapController> controllerr = Completer();

  GoogleMapController? controller;

  @override
  onInit() {
    Geolocator.checkPermission().then((value) async {
      if (value == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    });

    super.onInit();
  }

  hitLocationAPI(int i) async {
    APIRepository.getLocationApiCall(i).then((value) {
      if (value['detail']['latitude'] != '') {
        lat = value['detail']['latitude'];
        lng = value['detail']['longitude'];
      }

      moveCamera();
      update();
    }).onError((error, stackTrace) {});
  }

  calcDistance(startLatitude, startLongitude, endLatitude, endLongitude) {
    var distancee = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    var dist = distancee / 1000;
    distance = dist.toStringAsFixed(1);

    getTime(startLatitude, startLongitude, endLatitude, endLongitude);
    update();
  }

  Future<void> moveCamera() async {
    controller = await controllerr.future;
    controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 15.0, target: LatLng(double.parse(lat), double.parse(lng)))));
  }

  getTime(startLatitude, startLongitude, endLatitude, endLongitude) async {
    Response response = await dio.get(
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$startLatitude,$startLongitude&destinations=$endLatitude,$endLongitude&key=$google_map_key");
    time = response.data['rows'][0]['elements'][0]['duration']['text'];

    update();
  }
}
