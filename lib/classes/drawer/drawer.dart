// ignore_for_file: camel_case_types, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:water_ship/classes/Utils/utils.dart';
import 'package:water_ship/classes/login/login.dart';
import 'package:water_ship/classes/main_company/departments/list_of_all_department/list_of_all_department.dart';
import 'package:water_ship/classes/main_company/sub_company/multiple_sub_companies/sub_company_listing.dart';

class navigationDrawer extends StatefulWidget {
  const navigationDrawer({Key? key}) : super(key: key);

  @override
  State<navigationDrawer> createState() => _navigationDrawerState();
}

class _navigationDrawerState extends State<navigationDrawer> {
  //
  var strLoginProfileName = '';
  var strLoginUserName = '';
  var strLoginUserId = '';
  var strLoginUserTagName = '';
  var strLoginUserimage = '';
  //
  @override
  void initState() {
    super.initState();
    //
    if (kDebugMode) {
      print('=====> MENU BAR CALLED <=====');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          //
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(255, 254, 227, 225),
          ),
          //
          //
          Container(
            height: 0.2,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          ),
          //
          //
          /*GestureDetector(
            onTap: () {
              //
              funcGetDetailsOfThatCompany();
              //
            },
            child: Container(
              // height: 20,
              width: MediaQuery.of(context).size.width,
              color: Colors.lightBlue[50],
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    //
                    textWithBoldStyle(
                      'List of all Companies',
                      Colors.black,
                      16.0,
                    ),
                    //
                    const Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.chevron_right,
                          size: 16,
                        ),
                      ),
                    ),
                    //
                  ],
                ),
              ),
            ),
          ),*/
          //
          /*Container(
            height: 0.2,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          ),
          //
          GestureDetector(
            onTap: () {
              //
              funcGetLoginUserDetailsForDepartment();
              //
            },
            child: Container(
              // height: 20,
              width: MediaQuery.of(context).size.width,
              color: Colors.lightBlue[50],
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    //
                    textWithBoldStyle(
                      'Departments',
                      Colors.black,
                      16.0,
                    ),
                    //
                    const Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.chevron_right,
                          size: 16,
                        ),
                      ),
                    ),
                    //
                  ],
                ),
              ),
            ),
          ),*/
          //
          //
          Container(
            height: 0.2,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          ),
          //
          //
          GestureDetector(
            onTap: () {
              //
              FirebaseAuth.instance.signOut().then((value) => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                  });
              //
            },
            child: Container(
              // height: 20,
              width: MediaQuery.of(context).size.width,
              color: Colors.lightBlue[50],
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    //
                    textWithBoldStyle(
                      'Logout',
                      Colors.redAccent,
                      16.0,
                    ),
                    //
                    /*const Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.chevron_right,
                          size: 16,
                        ),
                      ),
                    ),*/
                    //
                  ],
                ),
              ),
            ),
          ),
          //
          Container(
            height: 0.2,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          ),
          //
          //
        ],
      ),
    );
  }

// if user click departments
  funcGetLoginUserDetailsForDepartment() {
    //
    startLoadingUI(context, 'please wait...');
    if (kDebugMode) {
      print(
          'LOGIN USER FIREBASE ID =====> ${FirebaseAuth.instance.currentUser!.uid}');
    }
    //
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}main_company")
        .doc("India")
        .collection("details")
        .where("company_firebase_id",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
        //
        Navigator.pop(context);
        //
      } else {
        for (var element in value.docs) {
          if (kDebugMode) {
            print('======> YES,  USER FOUND');
          }
          if (kDebugMode) {
            print(element.id);
            // print(element.data()['']);
            // print(element.id.runtimeType);
          }
          //
          Navigator.pop(context);
          //

          // EDIT USER IF IT ALREADY EXIST
          // funcCreatePublicName(element.id);
          if (element.data()['type'].toString() == 'main_company') {
            //
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ListOfAllDepartmentScreen(
            //       getMainCompanyData: element.data(),
            //     ),
            //   ),
            // );
            //
          }
        }
      }
    });

    //
  }

//
//
  funcGetDetailsOfThatCompany() {
    //
    startLoadingUI(context, 'please wait...');
    //
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}main_company")
        .doc("India")
        .collection("details")
        .where("company_firebase_id",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
        //
        Navigator.pop(context);
        //
      } else {
        for (var element in value.docs) {
          if (kDebugMode) {
            print('======> YES,  USER FOUND');
          }
          if (kDebugMode) {
            print(element.id);
            // print(element.data()['']);
            // print(element.id.runtimeType);
          }
          //
          Navigator.pop(context);
          //

          // EDIT USER IF IT ALREADY EXIST
          // funcCreatePublicName(element.id);
          if (element.data()['type'].toString() == 'main_company') {
            //
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => MainSubCompanyListingScreen(
            //       getFullDataFromLogin: element.data(),
            //     ),
            //   ),
            // );
            //
          }
        }
      }
    });

    //
  }

  //
  logoutWB() async {
    if (kDebugMode) {
      // print('=====> POST : COMMENTS LIST');
    }

    //
    QuickAlert.show(
      context: context,
      barrierDismissible: false,
      type: QuickAlertType.loading,
      title: 'Please wait...',
      text: 'logging out...',
      onConfirmBtnTap: () {
        if (kDebugMode) {
          print('some click');
        }
        //
      },
    );
    //

    final resposne = await http.post(
      Uri.parse(
        applicationBaseURL,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'logout',
          'userId': strLoginUserId.toString(),
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(getData);
    }

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        //
//
        Navigator.pop(context);
        Navigator.pop(context);

        //
        //
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
      if (kDebugMode) {
        print('something went wrong');
      }
    }
  }

  //
  Container menuNavigationBarUI(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0.0),
      color: Colors.amber,
      width: MediaQuery.of(context).size.width,
      height: 88,
      // child: widget
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: textWithBoldStyle(
                  'Menu',
                  Colors.white,
                  20.0,
                ),
              ),
            ),
          ),
          //
          Align(
            alignment: Alignment.bottomCenter,
            child: IconButton(
              onPressed: () {
                if (kDebugMode) {
                  print('menu click');
                }

                //

                //
              },
              icon: const Icon(
                Icons.notifications_sharp,
                color: Colors.white,
              ),
            ),
          ),
          //
        ],
      ),
    );
  }
  //
}
