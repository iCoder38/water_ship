// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:water_ship/classes/Utils/utils.dart';

class NewChatPanelScreen extends StatefulWidget {
  const NewChatPanelScreen({super.key, this.chatDialogData});

  final chatDialogData;

  @override
  State<NewChatPanelScreen> createState() => _NewChatPanelScreenState();
}

class _NewChatPanelScreenState extends State<NewChatPanelScreen> {
  //
  var strChatScreeLoader = '0';
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print(widget.chatDialogData);
    }
    //
    funcGetLoginUserDetails();
  }

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

          // EDIT USER IF IT ALREADY EXIST
          // funcCreatePublicName(element.id);
        }
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
          'Chat',
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
          ),
        ),
      ),
      body: (strChatScreeLoader == '0')
          ? AlertDialog(
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 8),
                      Flexible(
                        child: SingleChildScrollView(
                          child: textWithRegularStyle(
                            'creating secured panel...',
                            Colors.black,
                            14.0,
                          ),
                        ),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.of(context).pop();
                      //   },
                      //   child: Text("OK"),
                      // )
                    ]),
              ),
            )
          : SizedBox(),
      /*body: Stack(
        children: [
          Container(
            color: Colors.transparent,
            margin: const EdgeInsets.only(top: 0, bottom: 60),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('${strFirebaseMode}company')
                  .doc('India')
                  .collection('details')
                  .orderBy('time_stamp', descending: true)
                  .where('group_id',
                      isEqualTo: widget.chatDialogData['group_id'].toString())
                  .where('match', arrayContainsAny: [
                //
                FirebaseAuth.instance.currentUser!.uid,
                //
              ]).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if (kDebugMode) {
                    print('=============== DIALOG DATA IN CHAT ==============');
                    print(snapshot);
                    print(snapshot.data!);
                    print(snapshot.data!.docs);
                    print(snapshot.data!.docs.length);
                    print('======================================');
                  }

                  var saveSnapshotValue = snapshot.data!.docs;
                  if (kDebugMode) {
                    print('=============== DIALOG ==============');
                    print(saveSnapshotValue);
                    print('======================================');
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    // setState(() {
                    // strDisableTextField = '0';
                    // });
                  }
                  return (snapshot.data!.docs.isEmpty)
                      ? AlertDialog(
                          backgroundColor: Colors.redAccent,
                          title: textWithBoldStyle(
                            'Alert',
                            Colors.white,
                            18.0,
                          ),
                          content: textWithRegularStyle(
                            'You are no longer the member of this group. Please contact admin for more info.',
                            Colors.white,
                            14.0,
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: textWithBoldStyle(
                                'Ok',
                                Colors.white,
                                18.0,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 14.0),
                          child: ListView.separated(
                            separatorBuilder: (context, index) => const Divider(
                              color: Colors.grey,
                            ),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection(
                                        "${strFirebaseMode}message/${widget.chatDialogData['group_id'].toString()}/details",
                                      )
                                      .orderBy('time_stamp', descending: true)
                                      .limit(40)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      if (kDebugMode) {
                                        print('=====> YES, DATA');
                                      }
                                      //
                                      if (strScrollOnlyOneTime == '1') {
                                        _needsScroll = true;
                                        WidgetsBinding.instance
                                            .addPostFrameCallback(
                                                (_) => _scrollToEnd());
                                      }
                                      //

                                      var getSnapShopValue =
                                          snapshot.data!.docs.reversed.toList();
                                      if (kDebugMode) {
                                        // print(getSnapShopValue);
                                      }
                                      return Stack(
                                        children: [
                                          if (strScrollOnlyOneTime == '1') ...[
                                            const SizedBox(
                                              height: 0,
                                            )
                                          ] else ...[
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: InkWell(
                                                onTap: () {
                                                  _needsScroll = true;
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback(
                                                          (_) =>
                                                              _scrollToEnd());
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.all(
                                                      10.0),
                                                  width: 120,
                                                  height: 40,
                                                  child: Center(
                                                    child: textWithRegularStyle(
                                                      'str',
                                                      Colors.black,
                                                      14.0,
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                      255,
                                                      250,
                                                      247,
                                                      247,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      14.0,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 5,
                                                        blurRadius: 7,
                                                        offset: const Offset(
                                                          0,
                                                          3,
                                                        ), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                          ListView.builder(
                                            // controller: controller,
                                            controller: _scrollController,
                                            itemCount: getSnapShopValue.length,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                padding: const EdgeInsets.only(
                                                  left: 14,
                                                  right: 14,
                                                  //
                                                  top: 10,
                                                  bottom: 10,
                                                ),
                                                child: Align(
                                                    alignment: (getSnapShopValue[index][
                                                                    'sender_firebase_id']
                                                                .toString() ==
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid
                                                        ? Alignment.topRight
                                                        : Alignment.topLeft),
                                                    child: (getSnapShopValue[index]
                                                                    [
                                                                    'sender_firebase_id']
                                                                .toString() ==
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid)
                                                        ? senderUI(
                                                            getSnapShopValue, index)
                                                        : receiverUI(
                                                            getSnapShopValue,
                                                            index) //receiverUI(getSnapShopValue, index),
                                                    ),
                                              );
                                            },
                                          )
                                        ],
                                      );
                                    } else if (snapshot.hasError) {
                                      // return Center(
                                      //   child: Text(
                                      //     'Error: ${snapshot.error}',
                                      //   ),

                                      // );
                                      if (kDebugMode) {
                                        print(snapshot.error);
                                      }
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  });
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

            /**/
          ),
          //
          // ======> SEND MESSAGE UI <======
          // ===============================
          (strDisableTextField == '0')
              ? const SizedBox(
                  height: 40,
                )
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: sendMessageUI(),
                ),
          // ================================
          // ================================
          //
        ],
      ),*/
    );
  }
}
