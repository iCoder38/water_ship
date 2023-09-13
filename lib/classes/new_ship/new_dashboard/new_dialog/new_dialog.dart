// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:water_ship/classes/new_ship/crop_image_sample/crop_image_sample.dart';
import 'package:water_ship/classes/new_ship/new_dashboard/new_chat/new_chat_panel/new_create_chat_panel.dart';
import 'package:water_ship/classes/new_ship/new_dashboard/new_dialog_chat/new_dialog_chat.dart';

import '../../../Utils/utils.dart';
import '../../../drawer/drawer.dart';

class NewDialogScreen extends StatefulWidget {
  const NewDialogScreen({super.key});

  @override
  State<NewDialogScreen> createState() => _NewDialogScreenState();
}

class _NewDialogScreenState extends State<NewDialogScreen> {
  //
  var strCompanyFirebaseId = '';
  var strDialogLoader = '0';
  var saveUserCompanyFullData;

  @override
  void initState() {
    funcGetLoginUserDetails();
    super.initState();
  }

  //
  //
  funcGetLoginUserDetails() {
    //
    //
    // startLoadingUI(context, 'message');

    FirebaseFirestore.instance
        .collection("${strFirebaseMode}registrations")
        .where("member_firebase_id",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND,');
        }
        //

        //
      } else {
        for (var element in value.docs) {
          if (kDebugMode) {
            print('======> YES,  USER FOUND');
          }
          if (kDebugMode) {
            print(element.id);
            print(element.data());
          }
          //
          strCompanyFirebaseId = element.data()['company_firebase_id'];
          //
          // saveUserCompanyFullData = element.data();
        }
        //
        setState(() {
          strDialogLoader = '1';
        });
      }
    });
    //
    //
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithBoldStyle(
          'Dialogs',
          Colors.black,
          18.0,
        ),
        backgroundColor: navigationColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  if (kDebugMode) {
                    print('=====> New chat <=====');
                  }
                  //
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewCreateChatPanelScreen(),
                    ),
                  );
                },
                child: textWithRegularStyle(
                  'New Chat',
                  Colors.black,
                  16.0,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width - 100,
        child: const navigationDrawer(),
      ),
      body: (strDialogLoader == '0')
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('${strFirebaseMode}company')
                  .doc(strCompanyFirebaseId.toString())
                  .collection('dialog')
                  .orderBy('time_stamp', descending: true)
                  .where('chat_members_firebase_id', arrayContainsAny: [
                //
                FirebaseAuth.instance.currentUser!.uid,
                //
              ]).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if (kDebugMode) {
                    print(snapshot.data!.docs.length);
                  }

                  var saveSnapshotValue = snapshot.data!.docs;
                  if (kDebugMode) {
                    print(saveSnapshotValue);
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        height: 0.2,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            if (kDebugMode) {
                              print('=====> dishant rajput <=====');
                              // print(snapshot.data!.docs[index]['chat_type']
                              // .toString());
                            }
                            //
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewDialogChatScreen(
                                    chatDialogData:
                                        snapshot.data!.docs[index].data(),
                                    strCompanyFirebaseId: strCompanyFirebaseId
                                    // dictGetMainCompanyData:
                                    // saveUserCompanyFullData,
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12.0,
                              ),
                            ),
                            child: ListTile(
                              leading: (snapshot
                                          .data!.docs[index]['attachment_path']
                                          .toString() ==
                                      '')
                                  ? SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          0.0,
                                        ),
                                        child: Image.asset(
                                          'assets/images/group_avatar.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 54,
                                      width: 54,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          27.0,
                                        ),
                                        child: Image.network(
                                          //
                                          snapshot.data!
                                              .docs[index]['attachment_path']
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                              /*
                              ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                35.0,
                                              ),
                                              child: Image.file(
                                                fit: BoxFit.cover,
                                                //
                                                imageFile!,
                                                //
                                                height: 100.0,
                                                width: 100.0,
                                              ),
                                            )
                                             */
                              /*trailing: const Icon(
                                Icons.chevron_right,
                              ),*/
                              title: textWithBoldStyle(
                                //
                                snapshot.data!.docs[index]['chat_title']
                                    .toString(),
                                //
                                Colors.black,
                                16.0,
                              ),
                              subtitle: Column(
                                children: [
                                  //
                                  const SizedBox(
                                    height: 8,
                                  ),

                                  //
                                  lastMessageUI(snapshot, index),
                                  //
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
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
    );
  }

  Row lastMessageUI(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    return Row(
      children: [
        if (snapshot.data!.docs[index]['last_message_status'].toString() ==
            '2') ...[
          textWithRegularStyle(
            'this message was deleted',
            Colors.redAccent,
            10.0,
          ),
        ] else ...[
          if (snapshot.data!.docs[index]['message'].toString() ==
              '^chat_attachment^') ...[
            Row(
              children: [
                const Icon(
                  Icons.image,
                  size: 18.0,
                ),
                //
                textWithRegularStyle(
                  ' image',
                  Colors.black,
                  12.0,
                ),
              ],
            ),
          ] else ...[
            (snapshot.data!.docs[index]['message'].toString() == '')
                ? textWithRegularStyle(
                    '',
                    Colors.black,
                    14.0,
                  )
                : ((snapshot.data!.docs[index]['message'].toString()).length >
                        80)
                    ? Expanded(
                        child: textWithRegularStyle(
                          (snapshot.data!.docs[index]['message'].toString())
                              .replaceRange(
                                  78,
                                  (snapshot.data!.docs[index]['message']
                                          .toString())
                                      .length,
                                  '...'),
                          Colors.black,
                          12.0,
                        ),
                      )
                    : textWithRegularStyle(
                        (snapshot.data!.docs[index]['message'].toString()),
                        Colors.black,
                        14.0,
                      ),
          ]
        ],

        //
      ],
    );
  }
}
