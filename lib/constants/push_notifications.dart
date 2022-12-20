import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:swift_care/pages/bookings/presentation/booking_info_screen.dart';
import 'package:swift_care/pages/bookings/presentation/controller/booking_info_controller.dart';

import '../export.dart';
import '../pages/home/presentation/controllers/bottom_navigation_controller.dart';
import '../pages/home/presentation/views/bottom_navigation_screen.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;
  static final PushNotificationsManager _instance =
      PushNotificationsManager._();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestPermission();
      _firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);

      // For testing purposes print the Firebase Messaging token
      _firebaseMessaging
          .getToken()
          .then((value) => debugPrint("Firebase Messaging token $value"));
      _initialized = true;
      getIntialMessage();
      onMesage();

      onAppOpened();
    }
  }

  getIntialMessage() {
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        // controller.hitApiToGetNotificationsList();
        notificationRedirection(message.data['action']);
      }
    });
  }

  onMesage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint("message2  listen ${message.data}");
      // controller.hitApiToGetNotificationsList();
      // app forground
      var notification = message.data;
      AndroidNotification? android = message.notification?.android;

      var androids = AndroidInitializationSettings('drawable/ic_stat_name');
      var ios = new IOSInitializationSettings();
      var platform = new InitializationSettings(android: androids, iOS: ios);
      flutterLocalNotificationsPlugin.initialize(platform,
          onSelectNotification: (String? data) async {
        debugPrint("message2  local $data");
        notificationRedirection(message.data['action']);
      });

      if (Platform.isAndroid) {
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          '1',
          'swift Care',
          importance: Importance.max,
          groupKey: "swift Care",
          setAsGroupSummary: true,
          groupAlertBehavior: GroupAlertBehavior.all,
          playSound: true,
          enableVibration: true,
        );
        var iOSPlatformChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            android: androidPlatformChannelSpecifics,
            iOS: iOSPlatformChannelSpecifics);

        await flutterLocalNotificationsPlugin.show(0, 'Afaak Patient'.tr,
            message.data["message"], platformChannelSpecifics,
            payload: jsonEncode(notification));
      }
    });
  }

  onAppOpened() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("message1  openapp ${message.data['action']}");
      notificationRedirection(message.data['action']);
    });
  }

  notificationRedirection(String data) {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      switch (data) {
        case "booking":
          {
            var ctrl = Get.put(BottomNavigationController());
            ctrl.tabController.index = 1;
            ctrl.updateBottomIndex(1);
            ctrl.updateAppBarTitle();
            Get.offAll(BottomNavigationScreen());
            break;
          }
          case "accept-reject":
          {
            var ctrl = Get.put(BottomNavigationController());
            ctrl.tabController.index = 1;
            ctrl.updateAppBarTitle();
            ctrl.updateBottomIndex(1);
            Get.offAll(BottomNavigationScreen());
            break;
          }
          case "update-booking-status":
          {
            var ctrl = Get.put(BottomNavigationController());
            ctrl.tabController.index = 1;
            ctrl.updateAppBarTitle();
            ctrl.updateBottomIndex(1);
            Get.offAll(BottomNavigationScreen());
            break;
          }
        default:
          {
            Get.offAll(BottomNavigationScreen());
            break;
          }
      }
    });
  }
}
