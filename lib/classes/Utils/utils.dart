// text with regular
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:water_ship/classes/login/login.dart';

/* ================================================================ */

var applicationBaseURL =
    'https://demo4.evirtualservices.net/pludin/services/index';

/* ================================================================ */

/* ==================== LOCAL DATABASE ============================= */
var notificationServerKey =
    'AAAAAdo_SA8:APA91bHyWGpMlN1x9WXIAD31RmcWArl1a8rABTQI4lCMeQXtQGFuFw2eMMpOnXNfvCUWzSvQpkvJcb3JkWfublJZRVr181BhA2ZiJ4O7OWDpoGyAZtkoLhMJseGCvII9JMnOHOSgjXJw';
/* ================================================================ */

/* ==================== LOCAL DATABASE ============================= */

var databaseTableName = 'test3';

/* ========================FIREBASE MODE ======================== */ //
// test mode
var strFirebaseMode = 'mode/test/';
/* ================================================================ */

var appId = 'bbe938fe04a746fd9019971106fa51ff';

/* ========================FIREBASE MODE ======================== */ //

var navigationColor = const Color.fromRGBO(255, 180, 170, 1);
var appBlueColor = const Color.fromRGBO(57, 49, 157, 1);

var navigationTitleGetStarted = 'Get Started Now';
var navigationTitleLogin = 'Login';
var navigationTitleSignUp = 'Create an account';
var navigationTitleGeneralSettings = 'General Settings';
var navigationTitleBlockedFriends = 'Blocked Friends';
var navigationTitlePrivacyScreen = 'Privacy Settings';
var navigationTitleNotificationScreen = 'Notification Settings';
var navigationTitleEmailScreen = 'Email Settings';

/* ================================================================ */

Text textWithRegularStyle(str, color, size) {
  return Text(
    str.toString(),
    style: GoogleFonts.montserrat(
      color: color,
      fontSize: size,
    ),
  );
}

// text with bold
Text textWithBoldStyle(str, color, size) {
  return Text(
    str.toString(),
    style: GoogleFonts.montserrat(
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: color,
    ),
  );
}

// // text with bold
// Text textWithBoldStyleBlack(str) {
//   return Text(
//     str.toString(),
//     style: GoogleFonts.montserrat(
//       fontSize: 18.0,
//       fontWeight: FontWeight.w700,
//       color: Colors.black,
//     ),
//   );
// }

/* ================================================================ */
/* ========== CONVERT TIMESTAMP TO DATE AND TIME =============== */

funcConvertTimeStampToDateAndTime(getTimeStamp) {
  var dt = DateTime.fromMillisecondsSinceEpoch(getTimeStamp);
  // var d12HourFormat = DateFormat('dd/MM/yyyy, hh:mm').format(dt);
  var d12HourFormatTime = DateFormat('hh:mm a').format(dt);
  return d12HourFormatTime;
}

/* ================================================================ */
/* ========== CREATE 6 DIGITS RANDOM NUMBER =============== */

String get6DigitNumber() {
  Random random = Random();
  String number = '';
  for (int i = 0; i < 6; i++) {
    number = number + random.nextInt(9).toString();
  }
  return number;
}

/* ================================================================ */
/* ========== CREATE 20 DIGITS RANDOM NUMBER =============== */

String get20DigitNumber() {
  Random random = Random();
  String number = '';
  for (int i = 0; i < 20; i++) {
    number = number + random.nextInt(9).toString();
  }
  return number;
}

/* ================================================================ */
/* ================================================================ */

/* ================================================================ */
/* ========== CREATE 18 DIGITS RANDOM NUMBER =============== */

String get18DigitNumber() {
  Random random = Random();
  String number = '';
  for (int i = 0; i < 18; i++) {
    number = number + random.nextInt(9).toString();
  }
  return number;
}

/* ================================================================ */
/* ================================================================ */

/* ================================================================ */
/* ========== CREATE 16 DIGITS RANDOM NUMBER =============== */

String get16DigitNumber() {
  Random random = Random();
  String number = '';
  for (int i = 0; i < 16; i++) {
    number = number + random.nextInt(9).toString();
  }
  return number;
}

/* ================================================================ */
/* ================================================================ */

void startLoadingUI(BuildContext context, String message) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Flexible(
                  child: SingleChildScrollView(
                    child: textWithRegularStyle(
                      'Please wait...',
                      Colors.black,
                      14.0,
                    ),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //   },
                //   child: Text("OK"),
                // )
              ]),
        ),
      );
    },
  );
}

//
void logoutpopup(BuildContext context, String message) async {
  await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Flexible(
                child: SingleChildScrollView(
                  child: textWithRegularStyle(
                    //
                    message,
                    //
                    Colors.black,
                    14.0,
                  ),
                ),
              ),
              //
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        //
                        Navigator.pop(context);
                        //
                      },
                      child: textWithBoldStyle(
                        'dismiss',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  ),

                  //
                  const SizedBox(
                    width: 20,
                  ),
                  //
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut().then((value) => {
                              //
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()))
                              //
                            });
                      },
                      child: textWithBoldStyle(
                        'yes, logout',
                        Colors.redAccent,
                        14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

//
//
void popUpWithOutsideClick(BuildContext context, String message) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Flexible(
                child: SingleChildScrollView(
                  child: textWithRegularStyle(
                    //
                    message,
                    //
                    Colors.black,
                    14.0,
                  ),
                ),
              ),
              //
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        //
                        Navigator.pop(context);
                        //
                      },
                      child: textWithBoldStyle(
                        'dismiss',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  ),

                  //
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

//
//
//
//
void successLoaderUI(BuildContext context, String message) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Flexible(
                child: SingleChildScrollView(
                  child: textWithRegularStyle(
                    //
                    message,
                    //
                    Colors.black,
                    14.0,
                  ),
                ),
              ),
              //
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        //
                        Navigator.pop(context);
                        //
                      },
                      child: textWithBoldStyle(
                        'Ok',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  ),

                  //
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
