// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:water_ship/classes/add_ship/add_ship.dart';

import '../Utils/utils.dart';
import '../add_members/add_members.dart';
import '../create_group/create_group.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithRegularStyle(
          'Your Ships',
          Colors.white,
          18.0,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: navigationColor,
        leading: SizedBox(
          height: 40,
          width: 120,
          // color: Colors.amber,
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
                // print(FirebaseAuth.instance.currentUser!.photoURL);
                logoutpopup(context, 'Are you sure you want to logout?');
                //
              },
              onTapDown: () => HapticFeedback.vibrate(),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.redAccent,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          //
          addMemberAndCreateGroupUI(context),
          //

          Container(
            margin: const EdgeInsets.only(
              top: 64.0,
            ),
            height: 0.5,
            width: MediaQuery.of(context).size.width,
            color: Colors.blueGrey,
          ),
          //
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('${strFirebaseMode}user')
                .doc('India')
                .collection('details')
                .where(
                  'company_firebase_id',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                )
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if (kDebugMode) {
                  print('YES YOU ARE REGISTERED.');
                  print(snapshot.data!.docs.length);
                }

                var save_snapshot_value = snapshot.data!.docs;
                if (kDebugMode) {
                  print(save_snapshot_value);
                  print(save_snapshot_value[0]['type']);
                }
                return (snapshot.data!.docs.isEmpty)
                    ? Center(
                        child: textWithRegularStyle(
                          'No chat found',
                          Colors.black,
                          14.0,
                        ),
                      )
                    : Column(
                        children: [
                          if (save_snapshot_value[0]['type'] == 'admin') ...[
                            Card(
                              margin: const EdgeInsets.only(
                                top: 10.0,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                child: Center(child: Text('Elevated Card')),
                              ),
                            ),
                            Card(
                              margin: const EdgeInsets.only(
                                top: 10.0,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                child: Center(child: Text('Elevated Card')),
                              ),
                            ),
                            Card(
                              margin: const EdgeInsets.only(
                                top: 10.0,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                child: Center(child: Text('Elevated Card')),
                              ),
                            ),
                            Card(
                              margin: const EdgeInsets.only(
                                top: 10.0,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                child: Center(child: Text('Elevated Card')),
                              ),
                            ),

                            // ListView.separated(
                            //   itemBuilder: (BuildContext context, int index) {
                            //     return textWithRegularStyle(
                            //       'str',
                            //       Colors.black,
                            //       14.0,
                            //     );
                            //   },
                            //   separatorBuilder: (context, index) =>
                            //       const Divider(
                            //     color: Colors.grey,
                            //   ),
                            //   itemCount: 10,
                            // )
                          ] else if (save_snapshot_value[0]['type'] ==
                              'department') ...[
                            textWithRegularStyle(
                              'Department UI',
                              Colors.black,
                              14.0,
                            ),
                          ]
                        ],
                      );
                /*Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.grey,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          //
                          if (kDebugMode) {
                            print(snapshot.data!.docs[index]['chat_type']
                                .toString());
                          }
                          //
                          if (snapshot.data!.docs[index]['chat_type']
                                  .toString() ==
                              'group') {
                            //
                            // func_push_to_group_chat(
                            //     snapshot.data!.docs[index].data());
                            //
                          } else {
                            // func_push_to_private_chat(
                            //     snapshot.data!.docs[index].data());
                          }
                        },
                        child: textWithRegularStyle(
                          'test',
                          Colors.black,
                          14.0,
                        ),
                        /*child: (snapshot.data!.docs[index]['chat_type']
                                            .toString() ==
                                        'group')
                                    ? groupChatUI(snapshot, index)
                                    : privateChatUI(snapshot, index),*/
                      );
                    },
                  ),
                );*/
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
          ),
        ],
      ),
    );
  }

  //
  Row addMemberAndCreateGroupUI(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        addShipButtonUI(context),
        //
        //AddMemberUI(context),
        //

        //
      ],
    );
  }

  //
  SizedBox addShipButtonUI(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 160,
      // color: Colors.amber,
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
            //
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddShipScreen(),
              ),
            );
            //
          },
          onTapDown: () => HapticFeedback.vibrate(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              const Icon(
                Icons.add,
                size: 20.0,
              ),
              Center(
                child: textWithRegularStyle(
                  ' Add Ship',
                  Colors.black,
                  14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox AddMemberUI(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 180,
      // color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NeoPopButton(
          color: Colors.blueAccent,
          // onTapUp: () => HapticFeedback.vibrate(),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          onTapUp: () {
            //
            //
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddMembersScreen(),
              ),
            );
            //
          },
          onTapDown: () => HapticFeedback.vibrate(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Row(
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18.0,
                    ),
                    textWithRegularStyle(
                      'Add members',
                      Colors.white,
                      14.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //
}
