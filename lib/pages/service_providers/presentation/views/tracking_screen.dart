import 'package:flutter/cupertino.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:swift_care/pages/service_providers/presentation/controllers/map_controller.dart';

import '../../../../export.dart';

import 'package:google_maps_widget/google_maps_widget.dart';

import '../../../../model/data_model/booking_detail_model.dart';

class TrackingScreen extends StatelessWidget {
  Services? myLatLng;

  TrackingScreen({this.myLatLng});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
        init: MapController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
                appBar: backAppBar2(
                  context: context,
                  elevation: 3.0,
                  title: text(STRING_tracking.tr,
                      fontWeight: FontWeight.w600, fontSize: FONT_18),
                ),
                body: Stack(
                  children: [
                    GoogleMapsWidget(
                      apiKey: google_map_key,
                      sourceLatLng: LatLng(
                          double.parse('${myLatLng?.providerLatitude}'),
                          double.parse('${myLatLng?.providerLongitude}')),
                      destinationLatLng: LatLng(
                          double.parse('${myLatLng?.patientLatitude}'),
                          double.parse('${myLatLng?.patientLongitude}')),
                      routeWidth: 3,
                      zoomControlsEnabled: false,
                      onMapCreated: (GoogleMapController ctrl) {
                        controller.controllerr.complete(ctrl);
                      },
                      sourceMarkerIconInfo: MarkerIconInfo(
                        assetPath: iconsic_source,
                      ),
                      destinationMarkerIconInfo: MarkerIconInfo(
                        assetPath: iconsic_destination,
                      ),
                      compassEnabled: true,
                      driverMarkerIconInfo: MarkerIconInfo(
                        assetPath: iconsic_placeholder,
                      ),
                      driverCoordinatesStream: Stream.periodic(
                        Duration(milliseconds: 3000),
                        (i) {
                          controller.hitLocationAPI(myLatLng?.staffId ?? 0);

                          controller.calcDistance(
                              double.parse('${myLatLng?.patientLatitude}'),
                              double.parse('${myLatLng?.patientLongitude}'),
                              double.parse(controller.lat),
                              double.parse(controller.lng));

                          return LatLng(double.parse(controller.lat),
                              double.parse(controller.lng));
                        },
                      ),
                      // destinationName: 'Provider',
                      // sourceName: "Home",
                      // onTapDriverMarker: (currentLocation) {
                      //   print("Driver is currently at $currentLocation");
                      // },
                      totalTimeCallback: (time) {
                        controller.time = time;
                        controller.update();
                      },
                    ),
                    Positioned(
                      right: 20.0,
                      left: 20.0,
                      bottom: 28.0,
                      child: Container(
                          height: 55.0,
                          decoration: BoxDecoration(
                              color: appColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  text(STRING_Distance.tr,
                                      fontSize: 16, color: Colors.white),
                                  text(STRING_Arrivingin.tr,
                                      fontSize: 16, color: Colors.white),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  text('${controller.distance ?? '0'}KM ',
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  text('${controller.time ?? '0'}',
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)
                                ],
                              ),
                            ],
                          )),
                    )
                  ],
                )),
          );
        });
  }
}
