// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:water_ship/classes/Utils/utils.dart';
import 'package:water_ship/classes/new_ship/new_dashboard/new_department_list/add_department_members/add_department_members.dart';

class ShipDepartmentListingScreen extends StatefulWidget {
  const ShipDepartmentListingScreen(
      {super.key,
      this.getMainCompanyDetailsInShipDepartment,
      this.getSubCompanyDetailsInShipDepartment,
      this.getShipDetailsInShipDepartment});

  final getMainCompanyDetailsInShipDepartment;
  final getSubCompanyDetailsInShipDepartment;
  final getShipDetailsInShipDepartment;

  @override
  State<ShipDepartmentListingScreen> createState() =>
      _ShipDepartmentListingScreenState();
}

class _ShipDepartmentListingScreenState
    extends State<ShipDepartmentListingScreen> {
  //
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('======================================');
      print(
          '========== MAIN COMPANY DATA IN DEPARTMENT LISTGIN ==============');
      print(widget.getMainCompanyDetailsInShipDepartment);
      print(
          '========== SUB COMPANY DATE  IN DEPARTMENT LISTGIN  ==============');
      print(widget.getSubCompanyDetailsInShipDepartment);
      print('========== SHIP DETAILS  ==============');
      print(widget.getShipDetailsInShipDepartment);
      print('======================================');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithRegularStyle(
          //
          'Departments',
          //
          Colors.black,
          16.0,
        ),
        backgroundColor: navigationColor,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('${strFirebaseMode}ship_department')
            .doc(widget
                .getMainCompanyDetailsInShipDepartment['company_firebase_id']
                .toString())
            .collection(widget
                .getSubCompanyDetailsInShipDepartment['sub_company_firebase_id']
                .toString())
            .doc(widget.getShipDetailsInShipDepartment['firestore_id']
                .toString())
            .collection('details')
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
                print('=======================================');
                print('HURRAY!,YOU HAVE SOME DATA IN DEPARTMENT');
                print('=======================================');
              }
              //
            } else {
              if (kDebugMode) {
                print('=======================================');
                print('OOPS!, YOUR DATA IS EMPTY IN DEPARTMENT');
                print('=======================================');
              }
            }
            //
            return Column(
              children: [
                for (int i = 0; i < saveSnapshotValue2.length; i++) ...[
                  GestureDetector(
                    onTap: () {
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AddDepartmentMembersScreen(
                                  // getMainCompanyFullDetails:
                                  // widget.getFullDataFromLogin,
                                  // getSubCompanyFullDetails:
                                  // saveSnapshotValue2[i].data(),
                                  ),
                        ),
                      );
                      //
                    },
                    child: ListTile(
                      title: Row(
                        children: [
                          /*(saveSnapshotValue2[i]['sub_company_category']
                                      .toString() ==
                                  'Ships')
                              ? const Icon(
                                  Icons.sailing,
                                  size: 22.0,
                                  color: Colors.pinkAccent,
                                )
                              : const Icon(
                                  Icons.corporate_fare_outlined,
                                  size: 24.0,
                                  color: Colors.purpleAccent,
                                ),*/
                          //
                          const SizedBox(
                            width: 6,
                          ),
                          //
                          textWithBoldStyle(
                            //
                            saveSnapshotValue2[i]['department_name'].toString(),
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
                              Icons.group,
                              size: 16.0,
                            ),
                            //
                            const SizedBox(
                              width: 6,
                            ),
                            //
                            textWithRegularStyle(
                              //
                              'Members : ${saveSnapshotValue2[i]['members']}',
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
    );
  }
}
