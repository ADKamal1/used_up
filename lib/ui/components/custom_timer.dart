import 'package:flutter/material.dart';
import 'package:tbib_toast/tbib_toast.dart';

class CustomTimer extends StatelessWidget {
  const CustomTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Duration>(
        duration: Duration(seconds: 60),
        tween: Tween(begin: Duration(seconds: 60), end: Duration.zero),
        onEnd: () {
          Toast.show("Tracking End", context,
              backgroundColor: Colors.red, duration: 3);
        },
        builder: (BuildContext context, Duration value, Widget? child) {
          final minutes = value.inMinutes;
          final seconds = value.inSeconds % 60;
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text('$minutes:$seconds',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30)));
        });
  }
}
