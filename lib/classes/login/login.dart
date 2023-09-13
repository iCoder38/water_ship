// ignore_for_file: use_build_context_synchronously, avoid_print

// import 'dart:async';

import 'dart:convert';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:water_ship/classes/dashboard_dialog/dashboard_dialog.dart';
import 'package:water_ship/classes/home/home.dart';
import 'package:water_ship/classes/new_ship/new_dashboard/new_dialog/new_dialog.dart';
import 'package:water_ship/classes/sign_up/create_main_company/sign_up_main_company.dart/sign_up_main_company.dart';
import 'package:water_ship/classes/sign_up/sign_up.dart';
import 'package:water_ship/classes/main_company/sub_company/multiple_sub_companies/sub_company_listing.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;
// import 'package:crypto/crypto.dart';

import '../Utils/utils.dart';
import '../main_company/company_category_dashboard/company_category_dashboard.dart';
import '../new_ship/new_dashboard/new_sub_companies/new_sub_companies.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //
  final formKey = GlobalKey<FormState>();
  late final TextEditingController contEmail;
  late final TextEditingController contPassword;
  //
  // static Encrypted? encrypted;
  // static var decrypted;
  //
  @override
  void initState() {
    //
    contEmail = TextEditingController();
    contPassword = TextEditingController();
    //
    // funcTestEncrypt();
    super.initState();
  }

  @override
  void dispose() {
    //
    contEmail.dispose();
    contPassword.dispose();
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: textWithBoldStyle(
            'Login',
            Colors.black,
            18.0,
          ),
          automaticallyImplyLeading: false,
          backgroundColor: navigationColor,
        ),
        backgroundColor: const Color.fromRGBO(
          254,
          248,
          224,
          1,
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              //
              const SizedBox(
                height: 20,
              ),
              //
              Row(
                children: [
                  //
                  const SizedBox(
                    width: 10,
                  ),
                  //
                  Align(
                    alignment: Alignment.topLeft,
                    child: textWithRegularStyle(
                      'Email address',
                      Colors.black,
                      14.0,
                    ),
                  ),
                ],
              ),
              //
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5,
                ),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                  color: Colors.white,
                  border: Border.all(width: 0.4),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 188, 182, 182),
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                      offset: Offset(0.0, 0.0),
                    )
                  ],
                ),
                child: TextFormField(
                  controller: contEmail,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email address';
                    }
                    return null;
                  },
                ),
              ),
              //
              const SizedBox(
                height: 20,
              ),
              //
              Row(
                children: [
                  //
                  const SizedBox(
                    width: 10,
                  ),
                  //
                  Align(
                    alignment: Alignment.topLeft,
                    child: textWithRegularStyle(
                      'Password',
                      Colors.black,
                      14.0,
                    ),
                  ),
                ],
              ),
              //
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5,
                ),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                  color: Colors.white,
                  border: Border.all(width: 0.4),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 188, 182, 182),
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                      offset: Offset(0.0, 0.0),
                    )
                  ],
                ),
                child: TextFormField(
                  controller: contPassword,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
              ),
              //
              const SizedBox(
                height: 10,
              ),
              //

              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: NeoPopButton(
                    color: navigationColor,
                    // onTapUp: () => HapticFeedback.vibrate(),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    onTapUp: () {
                      //
                      if (formKey.currentState!.validate()) {
                        //
                        startLoadingUI(context, 'please wait...');
                        signInViaFirebase();

                        //
                      }
                    },
                    onTapDown: () => HapticFeedback.vibrate(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textWithBoldStyle(
                          'Sign In',
                          Colors.black,
                          14.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: NeoPopButton(
                    color: Colors.lightBlueAccent,
                    // onTapUp: () => HapticFeedback.vibrate(),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    onTapUp: () {
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpMainCompanyScreen(),
                        ),
                      );
                      //
                    },
                    onTapDown: () => HapticFeedback.vibrate(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textWithBoldStyle(
                          'Sign Up',
                          Colors.black,
                          14.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //
            ],
          ),
        ),
      ),
    );
  }

  //

  //
  signInViaFirebase() async {
    try {
      UserCredential customUserCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: contEmail.text, password: contPassword.text);
      // return customUserCredential.user!.uid;
      if (kDebugMode) {
        print(customUserCredential);
      }
      //
      funcGetDetailsOfThatCompany(customUserCredential.user!.uid);
      //

      /* if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
        //
        popUpWithOutsideClick(context,
            'Your account is not avtive. Please check your mail and verify your account.');
        // send email verification link
        FirebaseAuth.instance.currentUser
            ?.sendEmailVerification()
            .then((value) => {
                  //
                  print('success sent email ')
                });
      } else {*/
      /* (FirebaseAuth.instance.currentUser!.email == 'ce@mailinator.com')
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DialogScreen(),
              ),
            )
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );*/
      // }
      /*
      */
      //
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
        print(e.message);
      }

      customException(e.message);
    } catch (e) {
      if (kDebugMode) {
        print(e);
        // print(e);
      }
    }
  }

  //
  // get details of that company
  funcGetDetailsOfThatCompany(getFirebaseIdAfterLogin) {
    //
    //
    print(getFirebaseIdAfterLogin);
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}registrations")
        // .doc("India")
        // .collection("details")
        .where("company_firebase_id",
            isEqualTo: getFirebaseIdAfterLogin.toString())
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND, It"s not a Main Company');
        }
        //
        //
        Navigator.pop(context);
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
            print('======> YES,  USER FOUND');
          }
          if (kDebugMode) {
            print(element.id);
            print(element.data()['']);
            print(element.id.runtimeType);
          }

          // EDIT USER IF IT ALREADY EXIST
          // funcCreatePublicName(element.id);
          if (element.data()['type'].toString() == 'company') {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => CompanyCategoryDashboardScreen(
            //       getMainCompanyFullDataFromLogin: element.data(),
            //     ),
            //   ),
            // );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewSubCompaniesScreen(
                  getMainCompanyFullDataFromLogin: element.data(),
                ),
              ),
            );
          }
        }
      }
    });
    //
    //
  }

  //
  //
  customException(errorMessageIs) {
    //
    Navigator.pop(context);
    //
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: navigationColor,
        content: textWithBoldStyle(
          //
          errorMessageIs.toString(),
          //
          Colors.white,
          14.0,
        ),
      ),
    );
  }
}
