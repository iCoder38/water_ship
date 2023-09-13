// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:water_ship/classes/Utils/utils.dart';

import '../../../new_ship/new_dashboard/new_add_ship/new_add_ship.dart';
import '../../../new_ship/new_dashboard/new_edit_ship/edit_ship.dart';

class SubCompanyDetailsScreen extends StatefulWidget {
  const SubCompanyDetailsScreen(
      {super.key,
      this.getMainCompanyFullDetails,
      this.getSubCompanyFullDetails});

  final getMainCompanyFullDetails;
  final getSubCompanyFullDetails;

  @override
  State<SubCompanyDetailsScreen> createState() =>
      _SubCompanyDetailsScreenState();
}

class _SubCompanyDetailsScreenState extends State<SubCompanyDetailsScreen> {
  //
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('======================================');
      print('========== MAIN COMPANY DATE ==============');
      print(widget.getMainCompanyFullDetails);
      print('========== SUB COMPANY DATE ==============');
      print(widget.getSubCompanyFullDetails);
      print('======================================');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithRegularStyle(
          //
          widget.getSubCompanyFullDetails['sub_company_name'].toString(),
          //
          Colors.black,
          16.0,
        ),
        backgroundColor: navigationColor,
        actions: [
          SizedBox(
            // width: 100,
            // height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (widget.getSubCompanyFullDetails['sub_company_category']
                          .toString() ==
                      'Ship')
                  ? NeoPopButton(
                      color: navigationColor,
                      // onTapUp: () => HapticFeedback.vibrate(),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      onTapUp: () {
                        //
                        //
                        if (kDebugMode) {
                          print('1');
                        }
                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddShipScreen(
                              getFullData: widget.getMainCompanyFullDetails,
                              // getSubShipDataToAddShip:
                              // widget.getSubCompanyFullDetails,
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: textWithRegularStyle(
                              'add ships',
                              Colors.black,
                              14.0,
                            ),
                          )
                        ],
                      ),
                    )
                  : NeoPopButton(
                      color: navigationColor,
                      // onTapUp: () => HapticFeedback.vibrate(),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      onTapUp: () {
                        //
                        //
                        if (kDebugMode) {
                          print('1');
                        }
                        //
                        if (kDebugMode) {
                          print('add department');
                        }
                        //
                      },
                      onTapDown: () => HapticFeedback.vibrate(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: textWithRegularStyle(
                              'add department',
                              Colors.black,
                              14.0,
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('${strFirebaseMode}company_ships')
              .doc('India')
              .collection(widget
                  .getMainCompanyFullDetails['company_firebase_id']
                  .toString())
              .doc(widget.getSubCompanyFullDetails['sub_company_firebase_id']
                  .toString())
              .collection('details')
              .orderBy(
                'ship_name',
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
                  print('==============================================');
                  print('HURRAY, YOU HAVE DATA IN SUB COMPANIES DETAILS');
                  print('===============================================');
                }
                //
              } else {
                if (kDebugMode) {
                  print('==================================================');
                  print('OOPS!, YOUR DATA IS EMPTY IN SUB COMPANIES DETAILS');
                  print('===================================================');
                }
              }
              //
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    /*Center(
                      child: textWithBoldStyle(
                        //
                        'Company Name : ${widget.getMainCompanyFullDetails['company_name']}',
                        //
                        Colors.black,
                        18.0,
                      ),
                    ),*/
                    //
                    const SizedBox(
                      height: 10,
                    ),
                    //
                    Center(
                      child: textWithRegularStyle(
                        //
                        'Email : ${widget.getMainCompanyFullDetails['company_email']}',
                        //
                        Colors.blue[500],
                        16.0,
                      ),
                    ),
                    for (int i = 0; i < saveSnapshotValue2.length; i++) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            //
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditShipScreen(
                                  getMainShipDataToEditShip:
                                      widget.getMainCompanyFullDetails,
                                  getShipDetails: saveSnapshotValue2[i].data(),
                                  // getSubShipDataToEditShip:
                                  // widget.getSubCompanyFullDetails,
                                ),
                              ),
                            );
                            //
                          },
                          child: Container(
                            // height: 60,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 140,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[200],
                                    borderRadius: BorderRadius.circular(
                                      12.0,
                                    ),
                                  ),
                                  child: Image.asset(
                                    'assets/images/ship_avatar.png',
                                  ),
                                ),
                                //
                                const SizedBox(
                                  height: 10,
                                ),
                                //
                                // ship name
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: textWithBoldStyle(
                                    //
                                    saveSnapshotValue2[i]['ship_name']
                                        .toString(),
                                    //
                                    Colors.black,
                                    18.0,
                                  ),
                                ),
                                //
                                // ship imo number
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: textWithRegularStyle(
                                    //
                                    'imo no. : ${saveSnapshotValue2[i]['ship_imo_number']}',
                                    //
                                    Colors.black,
                                    14.0,
                                  ),
                                ),
                                //
                                //
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 40.0,
                                    right: 40.0,
                                  ),
                                  height: 0.4,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey,
                                ),
                                //
                                const SizedBox(
                                  height: 20,
                                ),
                                //
                                Row(
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: textWithBoldStyle(
                                          'Assign SE',
                                          Colors.black,
                                          14.0,
                                        ),
                                      ),
                                    ),
                                    //
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: textWithBoldStyle(
                                          'Assign Captain',
                                          Colors.black,
                                          14.0,
                                        ),
                                      ),
                                    ),
                                    //
                                  ],
                                ),
                                //
                                const SizedBox(
                                  height: 20,
                                ),
                                /*Row(
                                  children: [
                                    /*Align(
                                      alignment: Alignment.centerLeft,
                                      child: NeoPopButton(
                                        color: const Color.fromARGB(
                                            255, 245, 149, 181),
                                        // onTapUp: () => HapticFeedback.vibrate(),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        onTapUp: () {
                                          //
                        
                                          //
                                          if (kDebugMode) {
                                            print('edit details');
                                          }
                                          //
                                          //
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditShipScreen(
                                                getMainShipDataToEditShip: widget
                                                    .getMainCompanyFullDetails,
                                                getShipDetails:
                                                    saveSnapshotValue2[i].data(),
                                                getSubShipDataToEditShip: widget
                                                    .getSubCompanyFullDetails,
                                              ),
                                            ),
                                          );
                                          //
                                        },
                                        onTapDown: () => HapticFeedback.vibrate(),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            //
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: textWithBoldStyle(
                                                'Edit Details',
                                                Colors.white,
                                                14.0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),*/
                                    //
                                    //
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    /*Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: NeoPopButton(
                                          color: const Color.fromARGB(
                                              255, 245, 149, 181),
                                          // onTapUp: () => HapticFeedback.vibrate(),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                          onTapUp: () {
                                            //
                                            //
                                            if (kDebugMode) {
                                              print('1');
                                            }
                                            //
                                            if (kDebugMode) {
                                              print('add department');
                                            }
                                            //
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ShipDepartmentListingScreen(
                                                  getMainCompanyDetailsInShipDepartment:
                                                      widget
                                                          .getMainCompanyFullDetails,
                                                  getSubCompanyDetailsInShipDepartment:
                                                      widget
                                                          .getSubCompanyFullDetails,
                                                  getShipDetailsInShipDepartment:
                                                      saveSnapshotValue2[i]
                                                          .data(),
                                                ),
                                              ),
                                            );
                                            //
                                          },
                                          onTapDown: () =>
                                              HapticFeedback.vibrate(),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              //
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: textWithBoldStyle(
                                                  'Departments',
                                                  Colors.white,
                                                  16.0,
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.chevron_right,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),*/
                                  ],
                                ),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                      /*GestureDetector(
                        onTap: () {
                          //
                          // print(saveSnapshotValue2[i].data());
                          // print(saveSnapshotValue2[i]['firestore_id']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditShipScreen(
                                getMainShipDataToEditShip:
                                    widget.getMainCompanyFullDetails,
                                getShipDetails: saveSnapshotValue2[i].data(),
                                getSubShipDataToEditShip:
                                    widget.getSubCompanyFullDetails,
                              ),
                            ),
                          );
                          //
                        },
                        child: ListTile(
                          title: textWithBoldStyle(
                            //
                            saveSnapshotValue2[i]['ship_name'].toString(),
                            //
                            Colors.black,
                            14.0,
                          ),
                          subtitle: textWithRegularStyle(
                            //
                            'imo no. : ${saveSnapshotValue2[i]['ship_imo_number']}',
                            //
                            Colors.black,
                            14.0,
                          ),
                          trailing: const Icon(
                            Icons.edit,
                            size: 18.0,
                          ),
                        ),
                      ),*/
                      //
                      Container(
                        margin: const EdgeInsets.only(
                          left: 0.0,
                        ),
                        height: 0.8,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                      ),
                      //
                    ]
                  ],
                ),
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
        ), /*Column(
          children: [
            
            //
          ],
        ),*/
      ),
    );
  }
}
