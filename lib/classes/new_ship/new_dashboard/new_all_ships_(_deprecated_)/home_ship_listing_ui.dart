// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../Utils/utils.dart';

class HomeShiftListingUI extends StatefulWidget {
  const HomeShiftListingUI({super.key, this.shipListingGetData});

  final shipListingGetData;

  @override
  State<HomeShiftListingUI> createState() => _HomeShiftListingUIState();
}

class _HomeShiftListingUIState extends State<HomeShiftListingUI> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('${strFirebaseMode}ships')
          .doc('India')
          .collection('details')
          .orderBy('time_stamp', descending: true)
          .where('match', arrayContainsAny: [
        //
        widget.shipListingGetData[0]['company_firebase_id'].toString(),
        //
      ]).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (kDebugMode) {
            print('YES some ship is registered under your licence.');
            print(snapshot.data!.docs.length);
          }

          var saveSnapshotValue = snapshot.data!.docs;
          if (kDebugMode) {
            print(saveSnapshotValue);
            // print(save_snapshot_value[0]['type']);
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: textWithRegularStyle(
                'No ship found',
                Colors.black,
                14.0,
              ),
            );
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    for (int i = 0; i < saveSnapshotValue.length; i++) ...[
                      InkWell(
                        onTap: () {
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DepartmentList(
                                getShipFullDetails: saveSnapshotValue[i],
                              ),
                            ),
                          );*/
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 10,
                          ),
                          // height: 280,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                            border: Border.all(
                              width: 0.5,
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                // height: 260,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    12.0,
                                  ),
                                  child: Opacity(
                                    opacity: 0.8,
                                    child: (saveSnapshotValue[i]
                                                ["ship_profile_image"] ==
                                            '')
                                        ? Image.asset(
                                            //
                                            'assets/images/ship_avatar.png',
                                            //
                                            fit: BoxFit.contain,
                                          )
                                        : Image.network(
                                            //
                                            saveSnapshotValue[i]
                                                ["ship_profile_image"],
                                            //
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                              //
                              ListTile(
                                title: textWithBoldStyle(
                                  //
                                  saveSnapshotValue[i]["ship_name"].toString(),
                                  //
                                  Colors.black,
                                  16.0,
                                ),
                                subtitle: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: textWithRegularStyle(
                                        //
                                        '${saveSnapshotValue[i]["ship_type"]}',
                                        //
                                        Colors.grey[600],
                                        12.0,
                                      ),
                                    ),
                                    //
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: textWithRegularStyle(
                                        //
                                        '\nShip id : ${saveSnapshotValue[i]["ship_id"]}\n',
                                        //
                                        Colors.grey,
                                        12.0,
                                      ),
                                    ),
                                    //
                                    // Container(
                                    //   height: 200,
                                    //   width: MediaQuery.of(context).size.width,
                                    //   color: Colors.pinkAccent,
                                    // ),
                                  ],
                                ),
                                //
                                // leading: const Icon(
                                //   Icons.abc,
                                // ),
                              ),
                              //
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.pinkAccent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            );
          }
        } else if (snapshot.hasError) {
          if (kDebugMode) {
            print(snapshot.error);
          }
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
