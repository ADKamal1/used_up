
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:admin_app/shared/helper/bloc_observer.dart';
import 'package:admin_app/shared/helper/local_notification.dart';
import 'package:admin_app/shared/services/local/cache_helper.dart';
import 'package:admin_app/shared/services/network/dio_helper.dart';
import 'package:admin_app/shared/styles/styles.dart';
import 'package:admin_app/ui/screens/splash_screen/splash_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'firebase_options.dart';

// Future<void> setUpInteractedMessage() async {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   ///Configure notification permissions
//   //IOS
//   await FirebaseMessaging.instance
//       .setForegroundNotificationPresentationOptions(
//     alert: true, // Required to display a heads up notification
//     badge: true,
//     sound: true,
//   );
//
//   //Android
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//
//   log('User granted permission: ${settings.authorizationStatus}');
//
//   //Get the message from tapping on the notification when app is not in foreground
//   RemoteMessage? initialMessage = await messaging.getInitialMessage();
//
//   //If the message contains a service, navigate to the admin
//
//
//   //This listens for messages when app is in background
//
//   //Listen to messages in Foreground
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//
//     //Initialize FlutterLocalNotifications
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'high_importance', // id
//       'high_importance', // title
//       description:
//       'This channel is used for Schedular app notifications.', // description
//       importance: Importance.max,
//     );
//
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//
//     //Construct local notification using our created channel
//     if (notification != null && android != null) {
//       flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               channelDescription: channel.description,
//               icon: "@mipmap/ic_launcher", //Your app icon goes here
//               // other properties...
//             ),
//           ));
//     }
//   });
// }


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}


void main() {
  BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      if (Firebase.apps.length == 0) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }
      WidgetsFlutterBinding.ensureInitialized();

      await NotificationService().initNotification();
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      await Firebase.initializeApp();

      FirebaseMessaging messaging = FirebaseMessaging.instance;
      await FirebaseMessaging.instance.getToken();

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      print('User granted permission: ${settings.authorizationStatus}');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification}');
        }
      });
      Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
        // If you're going to use other Firebase services in the background, such as Firestore,
        // make sure you call `initializeApp` before using other Firebase services.
        await Firebase.initializeApp();

        print("Handling a background message: ${message.messageId}");
      }


      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      print(await FirebaseMessaging.instance.getToken());
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {

        NotificationService().showNotification(
            1, message.notification!.title!, message.notification!.body!);
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      await CachedHelper.init();
      DioHelper.init();

      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Location',
      theme: ThemeManger.setLightTheme(),
      home: SplashScreen(),
    );
  }
}
