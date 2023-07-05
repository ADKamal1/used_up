import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:admin_app/layout/main_layout.dart';
import 'package:admin_app/ui/screens/login_screen/login_screen.dart';

import '../../../shared/helper/mangers/colors.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../../shared/helper/methods.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  void checkUserState() {
    _timer = Timer(Duration(seconds: 3), () async {
      bool result = await InternetConnectionChecker().hasConnection;

      if (result == true) {
        FirebaseAuth.instance.authStateChanges().listen((user) {
          if (user != null) {
            if (mounted) {
              navigateToAndFinish(context, MainLayout());
            }
          } else {
            if (mounted) {
              navigateToAndFinish(context, LoginScreen());
            }
          }
        });
      } else {
        if (mounted) {
          showSnackBar(context, "من فضلك تحقق من إتصال الانترنت");
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  void initState() {
    super.initState();
    checkUserState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigManger().init(context);
    return Scaffold(
      backgroundColor: ColorsManger.darkPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: SizeConfigManger.bodyHeight * .3,
                height: SizeConfigManger.bodyHeight * .3,
                child: Image.asset("assets/images/logo.png")),
            SizedBox(height: SizeConfigManger.bodyHeight * .008),
          ],
        ),
      ),
    );
  }
}
