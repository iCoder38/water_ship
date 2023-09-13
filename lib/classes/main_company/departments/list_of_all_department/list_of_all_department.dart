// ignore_for_file: prefer_typing_uninitialized_variables, invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:water_ship/classes/Utils/utils.dart';
import 'package:water_ship/classes/new_ship/new_dashboard/new_department_list/add_department_members/add_department_members.dart';
import 'package:water_ship/classes/new_ship/new_dashboard/new_department_list/list_of_all_members/list_of_all_members.dart';
import 'package:water_ship/classes/drawer/drawer.dart';

class ListOfAllDepartmentScreen extends StatefulWidget {
  const ListOfAllDepartmentScreen({super.key, this.getMainCompanyData});

  final getMainCompanyData;

  @override
  State<ListOfAllDepartmentScreen> createState() =>
      _ListOfAllDepartmentScreenState();
}

class _ListOfAllDepartmentScreenState extends State<ListOfAllDepartmentScreen> {
  //
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //
  var arrShipDepartment = [
    'Operation',
    'Technical',
    'HESQ',
    'Crew Manning',
    'IT',
    'Purchase',
    'Account',
    'Owner Technical Group',
  ];
  @override
  void initState() {
    //
    if (kDebugMode) {
      print(widget.getMainCompanyData);
    }
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: textWithBoldStyle(
          //
          'All Departments',
          //
          Colors.black,
          16.0,
        ),
        backgroundColor: navigationColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
          ),
        ),
      ),

      // drawer: SizedBox(
      //   width: MediaQuery.of(context).size.width - 100,
      //   child: const navigationDrawer(),
      // ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('${strFirebaseMode}company_departments')
            .doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .collection('details')
            .orderBy('department_name', descending: false)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
          if (snapshot2.hasData) {
            // if (kDebugMode) {

            var saveSnapshotValue2 = snapshot2.data!.docs;
            //

            // GET DATA WHEN IMAGE PERMISSION IS NOT EMPTY
            if (snapshot2.data!.docs.isNotEmpty) {
              //
              if (kDebugMode) {
                print('==============================================');
                print('HURRAY, YOU HAVE DEPARTMENTS');
                print('===============================================');
              }
              //
            } else {
              if (kDebugMode) {
                print('==================================================');
                print('OOPS!, YOU DO NOT HAVE ANY DEPARTMENTS');
                print('===================================================');
              }
              //
              funcGetListOfAllCompanies();
              //
            }
            //
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  //
                  const SizedBox(
                    height: 10,
                  ),
                  //
                  Center(
                    child: textWithRegularStyle(
                      //
                      'Email : ${widget.getMainCompanyData['company_email'].toString()}',
                      //
                      Colors.blue[500],
                      16.0,
                    ),
                  ),
                  //
                  for (int i = 0; i < saveSnapshotValue2.length; i++) ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          //
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddDepartmentMembersScreen(
                                getMainCompanyDetailsInAddMembers:
                                    widget.getMainCompanyData,
                                getDepartmentDetailsInAddMembers:
                                    saveSnapshotValue2[i].data(),
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
                              //
                              const SizedBox(
                                height: 10,
                              ),
                              //
                              Align(
                                alignment: Alignment.centerLeft,
                                child: textWithBoldStyle(
                                  //
                                  saveSnapshotValue2[i]['department_name']
                                      .toString(),
                                  //
                                  Colors.black,
                                  18.0,
                                ),
                              ),
                              //
                              Align(
                                alignment: Alignment.centerLeft,
                                child: textWithRegularStyle(
                                  //
                                  'Members : ${saveSnapshotValue2[i]['members']}',
                                  //
                                  Colors.black,
                                  14.0,
                                ),
                              ),
                              //
                              //
                              const SizedBox(
                                height: 10,
                              ),
                              //
                              if (saveSnapshotValue2[i]['members'].toString() !=
                                  '0') ...[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: () {
                                      //

                                      //
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ListOfAllMembersScreen(
                                            getDepartmentDataInListOfMembers:
                                                saveSnapshotValue2[i].data(),
                                            getMainCompanyDetailsInListOfMembers:
                                                widget.getMainCompanyData,
                                          ),
                                        ),
                                      );
                                      //
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: navigationColor,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: textWithBoldStyle(
                                          'Members',
                                          Colors.black,
                                          14.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                              //
                              //
                              const SizedBox(
                                height: 10,
                              ),
                              //
                              //
                            ],
                          ),
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
      ),
    );
  }

  //
  //
  //
//
  funcGetListOfAllCompanies() async {
    //
    funcAlsoCreateAllDepartmentAfterCreateShip();
    //

    //
  }

  funcAlsoCreateAllDepartmentAfterCreateShip() {
    for (int i = 0; i < arrShipDepartment.length; i++) {
      CollectionReference users = FirebaseFirestore.instance.collection(
        '${strFirebaseMode}company_departments/${FirebaseAuth.instance.currentUser!.uid.toString()}/details',
      );

      users
          .add(
            {
              // company data
              'main_company_id':
                  widget.getMainCompanyData['company_id'].toString(),
              'main_company_firebase_id':
                  FirebaseAuth.instance.currentUser!.uid.toString(),
              'main_company_name':
                  widget.getMainCompanyData['company_name'].toString(),
              //
              'members': '0',
              'department_name': arrShipDepartment[i].toString(),
              //

              'time_stamp': DateTime.now().millisecondsSinceEpoch,
              'active': 'yes',
              'type': 'department',
            },
          )
          .then((value) => {
                FirebaseFirestore.instance
                    .collection(
                        '${strFirebaseMode}company_departments/${FirebaseAuth.instance.currentUser!.uid.toString()}/details')
                    .doc(value.id)
                    .set(
                  {
                    'firestore_id': value.id,
                  },
                  SetOptions(merge: true),
                ),
              })
          .catchError((error) => {});
    }
    //

    //
  }
}
