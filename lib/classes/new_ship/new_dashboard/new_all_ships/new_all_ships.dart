// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:water_ship/classes/new_ship/new_dashboard/new_edit_ship/edit_ship.dart';

import '../../../Utils/utils.dart';
import '../new_add_ship/new_add_ship.dart';

class NewAllShipScreen extends StatefulWidget {
  const NewAllShipScreen({super.key, this.getSubCompanyDetails});

  final getSubCompanyDetails;

  @override
  State<NewAllShipScreen> createState() => _NewAllShipScreenState();
}

class _NewAllShipScreenState extends State<NewAllShipScreen> {
  //
  @override
  void initState() {
    if (kDebugMode) {
      print('==================================================');
      print('============> LOGIN USER DATA <===================');
      // print(widget.getMainCompanyFullDataFromLogin);
      print('============> SUB COMPANY DATA <===================');
      print(widget.getSubCompanyDetails);
      print('==================================================');
    }
    super.initState();
  }

  // GET SHIP LIST FROM XMPP SERVER
  Stream<QuerySnapshot> getShipList() {
    return FirebaseFirestore.instance
        .collection('${strFirebaseMode}company')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('ships')
        .where('sub_company_firebase_id',
            isEqualTo: widget.getSubCompanyDetails['sub_company_firebase_id']
                .toString())
        .orderBy(
          'ship_name',
          descending: false,
        )
        // .get();
        .snapshots();
  }

  //
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: textWithBoldStyle(
            //
            'Ships ${widget.getSubCompanyDetails['company_name'].toString()}',
            //
            Colors.white,
            18.0,
          ),
          backgroundColor: navigationColor,
          leading: IconButton(
            onPressed: () {
              //
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 32.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                //
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddShipScreen(
                      getFullData: widget.getSubCompanyDetails,
                      // getMainShipDataToAddShip: widget
                      // .getMainCompanyFullDataFromLogin,
                      // strSubCompanyName: 'Department',
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: getShipList(),
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
                // print(saveSnapshotValue2);
                print(saveSnapshotValue2.length);
                // print(saveSnapshotValue2[0]['company_name']);
                print('============================');
              }
              //
              // countDepartment = saveSnapshotValue2.length;
              // GET DATA WHEN IMAGE PERMISSION IS NOT EMPTY
              if (snapshot2.data!.docs.isNotEmpty) {
                //
                if (kDebugMode) {
                  print('=========================================');
                  // print('HURRAY, YOU HAVE DATA  in $strUserSelectWhicProfile');
                  print('==========================================');
                }
                //
              } else {
                if (kDebugMode) {
                  print('==================================================');
                  // print(
                  // 'OOPS!, YOUR DON"T HAVE DATA in $strUserSelectWhicProfile');
                  print('===================================================');
                }
              }
              //
              return (saveSnapshotValue2.isEmpty)
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: textWithRegularStyle(
                          'No ship added in \n\nCompany Name : ${widget.getSubCompanyDetails['company_name'].toString()}\nSub-Company name : ${widget.getSubCompanyDetails['sub_company_name'].toString()}.\n\n Please click plus button to add.',
                          Colors.black,
                          18.0,
                        ),
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          color: Colors.black,
                        ),
                        //shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: saveSnapshotValue2.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              // push to list of all ships
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditShipScreen(
                                    getShipDetails:
                                        saveSnapshotValue2[index].data(),
                                    getMainShipDataToEditShip:
                                        widget.getSubCompanyDetails,
                                  ),
                                ),
                              );
                            },
                            title: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 180,
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
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: textWithBoldStyle(
                                    //
                                    saveSnapshotValue2[index]['ship_name']
                                        .toString(),
                                    //
                                    Colors.black,
                                    18.0,
                                  ),
                                ),
                                //
                              ],
                            ),
                            subtitle: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: textWithRegularStyle(
                                    //
                                    'imo number : ${saveSnapshotValue2[index]['ship_name']}',
                                    //
                                    Colors.black,
                                    16.0,
                                  ),
                                ),
                                //
                                const SizedBox(
                                  height: 20,
                                ),
                                //
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(
                                        12,
                                      ),
                                      topLeft: Radius.circular(
                                        12,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: textWithBoldStyle(
                                            'Cheif Engineer',
                                            Colors.black,
                                            16.0,
                                          ),
                                        ),
                                      ),
                                      //
                                      Container(
                                        height: 20,
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      //
                                      Expanded(
                                        child: Center(
                                          child: textWithBoldStyle(
                                            'Captain',
                                            Colors.black,
                                            16.0,
                                          ),
                                        ),
                                      ),
                                      //
                                    ],
                                  ),
                                ),
                                //
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey[350],
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: textWithRegularStyle(
                                            //
                                            saveSnapshotValue2[index]
                                                ['ship_ce_name'],
                                            //
                                            Colors.black,
                                            14.0,
                                          ),
                                        ),
                                      ),
                                      //
                                      Expanded(
                                        child: Center(
                                          child: textWithRegularStyle(
                                            //
                                            saveSnapshotValue2[index]
                                                ['ship_captain_name'],
                                            //
                                            Colors.black,
                                            14.0,
                                          ),
                                        ),
                                      ),
                                      //
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // trailing: const Icon(
                            //   Icons.chevron_right,
                            // ),
                          );
                        },
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
      ),
    );
  }
}
