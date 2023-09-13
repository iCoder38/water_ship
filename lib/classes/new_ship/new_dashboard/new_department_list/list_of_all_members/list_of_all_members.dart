// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:water_ship/classes/Utils/utils.dart';

class ListOfAllMembersScreen extends StatefulWidget {
  const ListOfAllMembersScreen(
      {super.key,
      this.getMainCompanyDetailsInListOfMembers,
      this.getDepartmentDataInListOfMembers});

  final getMainCompanyDetailsInListOfMembers;
  final getDepartmentDataInListOfMembers;

  @override
  State<ListOfAllMembersScreen> createState() => _ListOfAllMembersScreenState();
}

class _ListOfAllMembersScreenState extends State<ListOfAllMembersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithRegularStyle(
          //
          'Members  in ${widget.getDepartmentDataInListOfMembers['department_name'].toString()}',
          //
          Colors.black,
          16.0,
        ),
        backgroundColor: navigationColor,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('${strFirebaseMode}company')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            // .collection('department_members')
            .collection('departments')
            .where('department_name',
                isEqualTo: widget
                    .getDepartmentDataInListOfMembers['department_name']
                    .toString())
            .get(),
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
                print('HURRAY, YOU HAVE MEMBERS');
                print('===============================================');
              }
              //
            } else {
              if (kDebugMode) {
                print('==================================================');
                print('OOPS!, YOU DO NOT HAVE ANY MEMBERS');
                print('===================================================');
              }
            }
            //
            return ListView.builder(
              itemCount: saveSnapshotValue2.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    for (int i = 0;
                        i < saveSnapshotValue2[index]['members_list'].length;
                        i++) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/avatar.png',
                          ),
                          title: textWithBoldStyle(
                            //
                            saveSnapshotValue2[index]['members_list'][i]
                                    ['department_user_name']
                                .toString(),
                            Colors.black,
                            18.0,
                          ),
                          subtitle: textWithRegularStyle(
                            //
                            saveSnapshotValue2[index]['members_list'][i]
                                    ['department_user_email']
                                .toString(),
                            //
                            Colors.black,
                            12.0,
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
              },
            ); /*Column(
              children: [
                //s
                const SizedBox(
                  height: 10,
                ),
                //

                //for (int i = 0; i < saveSnapshotValue2.length; i++) ...[
                GestureDetector(
                  onTap: () {
                    //

                    //
                  },
                  /*child: Column(
                      children: [
                        for (int j = 0;
                            i < saveSnapshotValue2[i]['members_list'].length;
                            j++) ...[
                          ListTile(
                            title: textWithRegularStyle(
                              //
                              'str',
                              // saveSnapshotValue2[i]['members_list'][],
                              Colors.black,
                              14.0,
                            ),
                          ),
                        ]
                      ],
                    ),*/
                  /*ListTile(
                      title: textWithBoldStyle(
                        //
                        saveSnapshotValue2[i]['department_user_name']
                            .toString(),
                        //
                        Colors.black,
                        16.0,
                      ),
                      subtitle: textWithRegularStyle(
                        //
                        saveSnapshotValue2[i]['department_user_email']
                            .toString(),
                        //
                        Colors.black,
                        12.0,
                      ),
                      leading: Image.asset(
                        'assets/images/avatar.png',
                      ),
                    ),*/
                ),

                
                // ]
              ],
            );*/
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
