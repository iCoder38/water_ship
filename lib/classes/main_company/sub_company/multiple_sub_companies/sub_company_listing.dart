// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:water_ship/classes/Utils/utils.dart';
import 'package:water_ship/classes/drawer/drawer.dart';
import 'package:water_ship/classes/main_company/sub_company/add_sub_company/add_sub_company.dart';
import 'package:water_ship/classes/main_company/sub_company/sub_company_details/sub_company_details.dart';

import '../../departments/list_of_all_department/list_of_all_department.dart';

class MainSubCompanyListingScreen extends StatefulWidget {
  const MainSubCompanyListingScreen(
      {super.key, this.getFullDataFromLogin, required this.getCategoryName});

  final getFullDataFromLogin;
  final String getCategoryName;

  @override
  State<MainSubCompanyListingScreen> createState() =>
      _MainSubCompanyListingScreenState();
}

class _MainSubCompanyListingScreenState
    extends State<MainSubCompanyListingScreen> {
  //
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //
  var strHideAddCompanyButton = '0';
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('<========= LOGIN DATA==========>');
      print(widget.getFullDataFromLogin);
      print('<==============================>');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: textWithRegularStyle(
            'List of all Companies',
            Colors.black,
            18.0,
          ),
          backgroundColor: navigationColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 28.0,
            ),
          ),
          actions: [
            SizedBox(
              // width: 100,
              // height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: NeoPopButton(
                  color: navigationColor,
                  // onTapUp: () => HapticFeedback.vibrate(),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  onTapUp: () {
                    //
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddSubCompanyScreen(
                          getMainCompantData: widget.getFullDataFromLogin,
                          strSubCompanyName: widget.getCategoryName.toString(),
                        ),
                      ),
                    );
                    //
                  },
                  onTapDown: () => HapticFeedback.vibrate(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //
                      (strHideAddCompanyButton == '1')
                          ? const SizedBox(
                              height: 0,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: textWithRegularStyle(
                                'add company',
                                Colors.black,
                                14.0,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        // drawer: SizedBox(
        //   width: MediaQuery.of(context).size.width - 100,
        //   child: const navigationDrawer(),
        // ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('${strFirebaseMode}sub_company')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('sub_companies')
                .where('sub_company_category',
                    isEqualTo: widget.getCategoryName.toString())
                .orderBy(
                  'sub_company_name',
                  descending: false,
                )
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
              if (snapshot2.hasData) {
                // if (kDebugMode) {

                var saveSnapshotValue2 = snapshot2.data!.docs;
                //
                if (kDebugMode) {
                  //
                  //
                  print('============================');
                  print(saveSnapshotValue2);
                  print(saveSnapshotValue2.length);
                  // print(saveSnapshotValue2[0]['company_name']);
                  print('============================');
                }
                // GET DATA WHEN IMAGE PERMISSION IS NOT EMPTY
                if (snapshot2.data!.docs.isNotEmpty) {
                  //
                  if (kDebugMode) {
                    print('============================');
                    print('HURRAY, YOU HAVE ${widget.getCategoryName}');
                    print('============================');
                  }
                  //
                } else {
                  if (kDebugMode) {
                    print('===============================');
                    print(
                        'OOPS!, YOUR DON"T HAVE ANY ${widget.getCategoryName}');
                    print('==============================');
                  }
                }
                //
                // if (widget.getCategoryName.toString() == 'Department') {
                //   if (saveSnapshotValue2.isEmpty) {
                //     print('refresh 1');
                //     // setState(() {});
                //   } else {
                //     print('refresh');
                //     // setState(() {
                //     print('refresh');
                //     strHideAddCompanyButton = '1';
                //     // });
                //   }
                // }
                //
                return Column(
                  children: [
                    for (int i = 0; i < saveSnapshotValue2.length; i++) ...[
                      GestureDetector(
                        onTap: () {
                          //
                          (widget.getCategoryName.toString() == 'Department')
                              ? funcGetLoginUserDetailsForDepartment()
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SubCompanyDetailsScreen(
                                      getMainCompanyFullDetails:
                                          widget.getFullDataFromLogin,
                                      getSubCompanyFullDetails:
                                          saveSnapshotValue2[i].data(),
                                    ),
                                  ),
                                );
                          //
                        },
                        child: ListTile(
                          title: Row(
                            children: [
                              (saveSnapshotValue2[i]['sub_company_category']
                                          .toString() ==
                                      'Ship')
                                  ? const Icon(
                                      Icons.sailing,
                                      size: 22.0,
                                      color: Colors.pinkAccent,
                                    )
                                  : const Icon(
                                      Icons.corporate_fare_outlined,
                                      size: 24.0,
                                      color: Colors.purpleAccent,
                                    ),
                              //
                              const SizedBox(
                                width: 6,
                              ),
                              //
                              textWithBoldStyle(
                                //
                                saveSnapshotValue2[i]['sub_company_name']
                                    .toString(),
                                //
                                Colors.black,
                                16.0,
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.email_outlined,
                                  size: 16.0,
                                ),
                                //
                                const SizedBox(
                                  width: 6,
                                ),
                                //
                                textWithRegularStyle(
                                  //
                                  saveSnapshotValue2[i]['sub_company_email']
                                      .toString(),
                                  //
                                  Colors.black,
                                  12.0,
                                ),
                              ],
                            ),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right,
                            size: 18.0,
                          ),
                        ),
                      ),
                      //
                      Container(
                        margin: const EdgeInsets.only(
                          left: 20.0,
                        ),
                        height: 0.4,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey,
                      ),
                      //
                    ]
                  ],
                );
                //
              } else if (snapshot2.hasError) {
                if (kDebugMode) {
                  print(snapshot2.error);
                }
                return Center(
                  child: Text('Error: ${snapshot2.error}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ListOfAllDepartmentScreen(
                  getMainCompanyData: element.data(),
                ),
              ),
            );
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
}
