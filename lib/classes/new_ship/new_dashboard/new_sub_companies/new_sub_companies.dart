// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:water_ship/classes/new_ship/new_dashboard/new_add_sub_company/new_add_sub_company.dart';
import 'package:water_ship/classes/new_ship/new_dashboard/new_department_list/new_department_list.dart';

import '../../../Utils/utils.dart';
import '../../../drawer/drawer.dart';
import '../new_all_ships/new_all_ships.dart';

enum Sky { midnight, viridian, cerulean }

class NewSubCompaniesScreen extends StatefulWidget {
  const NewSubCompaniesScreen(
      {super.key, this.getMainCompanyFullDataFromLogin});
  final getMainCompanyFullDataFromLogin;
  @override
  State<NewSubCompaniesScreen> createState() => _NewSubCompaniesScreenState();
}

class _NewSubCompaniesScreenState extends State<NewSubCompaniesScreen> {
  //
  int segmentControlIndex = 0;
  int countDepartment = 0;
  var strUserSelectWhicProfile = 'Department';

  @override
  void initState() {
    if (kDebugMode) {
      print('==================================================');
      print('============> LOGIN USER DATA <===================');
      print(widget.getMainCompanyFullDataFromLogin);
      print('============> LOGIN USER FIREBASE ID <===================');
      print(widget.getMainCompanyFullDataFromLogin['company_firebase_id']);
      print('==================================================');
    }
    super.initState();
  }

  // stream function
  Stream<QuerySnapshot> getSubCompanyList(categoryName) {
    return FirebaseFirestore.instance
        .collection('${strFirebaseMode}company')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('sub_company')
        .where('sub_company_category', isEqualTo: categoryName.toString())
        .orderBy(
          'sub_company_name',
          descending: false,
        )
        // .get();
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithBoldStyle(
          //
          'Dashboard',
          //
          Colors.white,
          18.0,
        ),
        backgroundColor: navigationColor,
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width - 100,
        child: const navigationDrawer(),
      ),
      floatingActionButton: (segmentControlIndex == 0)
          ? FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
                // print(countDepartment);

                (countDepartment == 0)
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewAddSubCompanyScree(
                            getMainCompantData:
                                widget.getMainCompanyFullDataFromLogin,
                            strSubCompanyName: 'Department',
                          ),
                        ),
                      )
                    : successLoaderUI(context,
                        'You already have a Department. You can not add more than 1 department.');
              },
              backgroundColor: Colors.orange[300],
              child: const Icon(
                Icons.domain,
                color: Colors.black,
              ),
            )
          : FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!

                //
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewAddSubCompanyScree(
                      getMainCompantData:
                          widget.getMainCompanyFullDataFromLogin,
                      strSubCompanyName: 'Ship',
                    ),
                  ),
                );
              },
              backgroundColor: Colors.redAccent,
              child: const Icon(
                Icons.directions_boat,
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //
              textWithRegularStyle(
                'Company',
                Colors.black,
                20.0,
              ),
              const SizedBox(
                height: 8,
              ),
              customSegmentControlUI(),
              //
              //
              const SizedBox(
                height: 16,
              ),
              //
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
              ),
              //
              const SizedBox(
                height: 16,
              ),
              //
              StreamBuilder(
                stream: getSubCompanyList(strUserSelectWhicProfile.toString()),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot2) {
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
                    countDepartment = saveSnapshotValue2.length;
                    // GET DATA WHEN IMAGE PERMISSION IS NOT EMPTY
                    if (snapshot2.data!.docs.isNotEmpty) {
                      //
                      if (kDebugMode) {
                        print('=========================================');
                        print(
                            'HURRAY, YOU HAVE DATA  in $strUserSelectWhicProfile');
                        print('==========================================');
                      }
                      //
                    } else {
                      if (kDebugMode) {
                        print(
                            '==================================================');
                        print(
                            'OOPS!, YOUR DON"T HAVE DATA in $strUserSelectWhicProfile');
                        print(
                            '===================================================');
                      }
                    }
                    //
                    return Expanded(
                      child: (saveSnapshotValue2.isEmpty)
                          ? Center(
                              child: textWithRegularStyle(
                                'No Data Found',
                                Colors.black,
                                14.0,
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.transparent,
                              child: ListView.separated(
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                                //shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: saveSnapshotValue2.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    onTap: () {
                                      if (saveSnapshotValue2[index]
                                                  ['sub_company_category']
                                              .toString() ==
                                          'Department') {
                                        //
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NewDepartmentScreen(
                                              getMainCompanyData: widget
                                                  .getMainCompanyFullDataFromLogin,
                                              // strSubCompanyName: 'Department',
                                            ),
                                          ),
                                        );
                                      } else {
                                        // push to list of all ships
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NewAllShipScreen(
                                              getSubCompanyDetails:
                                                  saveSnapshotValue2[index]
                                                      .data(),
                                              // getMainShipDataToAddShip: widget
                                              // .getMainCompanyFullDataFromLogin,
                                              // strSubCompanyName: 'Department',
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    title: textWithBoldStyle(
                                      //
                                      saveSnapshotValue2[index]
                                              ['sub_company_name']
                                          .toString(),
                                      //
                                      Colors.black,
                                      18.0,
                                    ),
                                    subtitle: textWithRegularStyle(
                                      //
                                      saveSnapshotValue2[index]
                                              ['sub_company_email']
                                          .toString(),
                                      //
                                      Colors.black,
                                      16.0,
                                    ),
                                    trailing: const Icon(
                                      Icons.chevron_right,
                                    ),
                                  );
                                },
                              ),
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
              )
              /**/
              //
            ],
          ),
        ),
      ),
    );
  }

  // custom segment control UI
  Container customSegmentControlUI() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          14.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(
              0,
              3,
            ),
          ),
        ],
      ),
      child: Row(
        children: [
          if (segmentControlIndex == 0) ...[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    segmentControlIndex = 0;
                    strUserSelectWhicProfile = 'Department';
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: textWithBoldStyle(
                      'Department',
                      navigationColor,
                      20.0,
                    ),
                  ),
                ),
              ),
            ),
            //
            Container(
              height: 40,
              width: 1,
              color: Colors.grey,
            ),
            //
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    segmentControlIndex = 1;
                    strUserSelectWhicProfile = 'Ship';
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: textWithBoldStyle(
                        'Ships',
                        Colors.black,
                        16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //
          ] else ...[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    segmentControlIndex = 0;
                    strUserSelectWhicProfile = 'Department';
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: textWithBoldStyle(
                      'Department',
                      Colors.black,
                      16.0,
                    ),
                  ),
                ),
              ),
            ),
            //
            Container(
              height: 40,
              width: 1,
              color: Colors.grey,
            ),
            //
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    segmentControlIndex = 1;
                    strUserSelectWhicProfile = 'Ship';
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: textWithBoldStyle(
                      'Ships',
                      navigationColor,
                      20.0,
                    ),
                  ),
                ),
              ),
            ),
            //
          ],
        ],
      ),
    );
  }
}
