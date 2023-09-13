import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_ship/classes/new_ship/new_dashboard/new_sub_companies/new_sub_companies.dart';

import '../../main.dart';
import '../Utils/utils.dart';
import '../login/login.dart';
import '../new_ship/new_dashboard/new_dialog/new_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //
  Timer? timer;
  //
  @override
  void initState() {
    //
    funcPlayTimer();
    //
    super.initState();
    // FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithRegularStyle(
          'Splash',
          Colors.white,
          16.0,
        ),
        backgroundColor: navigationColor,
      ),
    );
  }

  funcGetAllNotificationFunctions() {
    funcGetDeviceToken();
    //
    funcGetFullDataOfNotification();
    //
  }

  //
  funcGetDeviceToken() async {
    //
    final token = await firebaseMessaging.getToken();

    //
    if (kDebugMode) {
      print('=============> HERE IS MY DEVICE TOKEN <=============');
      print('======================================================');
      print(token);
      print('======================================================');
      print('======================================================');
    }
    // save token locally
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('deviceToken', token.toString());
    //
  }

  //
  // get notification in foreground
  funcGetFullDataOfNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('=====> GOT NOTIFICATION IN FOREGROUND <=====');
      }

      if (message.notification != null) {
        if (kDebugMode) {
          print('Message data: ${message.data}');
          print(
              'Message also contained a notification: ${message.notification}');
        }
        // setState(() {
        //   notifTitle = message.notification!.title;
        //   notifBody = message.notification!.body;
        // });
      }
      //
      if (message.data['type'].toString() == 'audio_call') {
        //
        if (kDebugMode) {
          print(message.data['channel_name'].toString());
        }
        //
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ChatAudioCallScreen(
        //       getAllData: message.data,
        //       strGetCallStatus: 'get_call',
        //     ),
        //   ),
        // );
        //
      } else if (message.data['type'].toString() == 'videoCall') {
        //
      }
    });
  }

  //
  funcPlayTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) {
        //
        if (t.tick == 2) {
          t.cancel();
          // func_push_to_next_screen();
          if (kDebugMode) {
            print('object');
          }
          //
          if (FirebaseAuth.instance.currentUser != null) {
            // signed in
            if (kDebugMode) {
              print('sign in');
            }
            //
            funcGetDetailsOfThatCompany(FirebaseAuth.instance.currentUser!.uid);

            //
          } else {
            // signed out
            //
            if (kDebugMode) {
              print('sign out');
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
            //
          }

          //
        }
      },
    );
  }

  //
  //
  // get details of that company
  funcGetDetailsOfThatCompany(getFirebaseIdAfterLogin) {
    //
    //

    if (kDebugMode) {
      print(getFirebaseIdAfterLogin);
    }
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}registrations")
        .where("company_firebase_id",
            isEqualTo: getFirebaseIdAfterLogin.toString())
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND');
        }
        //
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NewDialogScreen(),
          ),
        );
        //
      } else {
        for (var element in value.docs) {
          if (kDebugMode) {
            print('==========================================');
            print('==========================================');
            print('======> LOGIN USER DATA <=================');
            print(element.id);
            print(element.data());
            print('==========================================');
            print('==========================================');
          }

          // EDIT USER IF IT ALREADY EXIST
          // funcCreatePublicName(element.id);
          if (element.data()['type'].toString() == 'company') {
            if (element.data()['total_sub_companies'].toString() == '1') {
              if (kDebugMode) {
                print('==================================================');
                print('======> PUSH TO ONLY ONE COMPANY <=================');
                print('==================================================');
              }
            } else {
              if (kDebugMode) {
                print('==================================================');
                print('======> PUSH TO MULTIPLE COMPANY <=================');
                print('==================================================');
              }
              //
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewSubCompaniesScreen(
                    getMainCompanyFullDataFromLogin: element.data(),
                  ),
                ),
              );
              //
            }
          }
        }
      }
    });
    //
    //
    /*Navigator.pop(context);
    //

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );*/
  }
}
