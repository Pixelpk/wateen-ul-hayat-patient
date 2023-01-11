import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:lottie/lottie.dart';
import 'package:swift_care/export.dart';

void showTimerDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Size med = MediaQuery.of(context).size;
      return SimpleDialog(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 150,
            width: 150,
            child: Lottie.asset('assets/lottie/timerClock.json'),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Call Will start after',
              style: context.textTheme.headline6,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 250,
            child: Column(
              children: <Widget>[
                TimerCountdown(
                  // spacerWidth: 2.0,
                  format: CountDownTimerFormat.daysHoursMinutesSeconds,
                  endTime: DateTime.now().add(
                    Duration(
                      days: 5,
                      hours: 14,
                      minutes: 27,
                      seconds: 34,
                    ),
                  ),
                  onEnd: () {
                    print("Timer finished");
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Cancel',
                  style: context.textTheme.headline5
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
