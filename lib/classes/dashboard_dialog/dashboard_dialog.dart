import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Utils/utils.dart';
import '../drawer/drawer.dart';

class DashboardDialogScreen extends StatefulWidget {
  const DashboardDialogScreen({super.key});

  @override
  State<DashboardDialogScreen> createState() => _DashboardDialogScreenState();
}

class _DashboardDialogScreenState extends State<DashboardDialogScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
        body: Stack(
          children: [
            //

            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('${strFirebaseMode}dialog')
                  .doc('India')
                  .collection('details')
                  .orderBy('time_stamp', descending: true)
                  .where('match', arrayContainsAny: [
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

                  // var saveSnapshotValue = snapshot.data!.docs;
                  // if (kDebugMode) {
                  //   print(saveSnapshotValue);
                  // }
                  return (snapshot.data!.docs.isEmpty)
                      ? /*Center(
                          child: textWithRegularStyle(
                            'No chat found',
                            Colors.black,
                            14.0,
                          ),
                        )*/
                      Container(
                          // height: 100,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.amberAccent,
                          child: Column(
                            children: [
                              textWithRegularStyle(
                                'str',
                                Colors.black,
                                14.0,
                              ),
                              //
                              textWithRegularStyle(
                                'str',
                                Colors.black,
                                14.0,
                              ),
                              //
                            ],
                          ),
                        )
                      : Padding(
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
                                    print(snapshot
                                        .data!.docs[index]['chat_type']
                                        .toString());
                                  }
                                  //
                                  if (snapshot.data!.docs[index]['chat_type']
                                          .toString() ==
                                      'group') {
                                    //
                                    // func_push_to_group_chat(
                                    // snapshot.data!.docs[index].data());
                                    //
                                  } else {
                                    // func_push_to_private_chat(
                                    // snapshot.data!.docs[index].data());
                                  }
                                },
                                child: (snapshot.data!.docs[index]['chat_type']
                                            .toString() ==
                                        'group')
                                    ? groupChatUI(snapshot, index)
                                    : privateChatUI(snapshot, index),
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
          ],
        ),
      ),
    );
  }

  //
  // GROUP CHAT UI
  ListTile groupChatUI(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    return ListTile(
      leading: (snapshot.data!.docs[index]['group_display_image'].toString() ==
              '')
          ? Container(
              height: 54,
              width: 54,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/icons/group.png',
                  ),
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
                  snapshot.data!.docs[index]['group_display_image'].toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
      trailing: const Icon(
        Icons.chevron_right,
      ),
      title: textWithBoldStyle(
        //
        snapshot.data!.docs[index]['group_name'].toString(),
        //
        Colors.black,
        18.0,
      ),
      subtitle: (snapshot.data!.docs[index]['last_message'].toString() == '')
          ? Row(
              children: [
                const Icon(
                  Icons.image,
                  // 0 //
                  size: 20.0,
                ),
                textWithRegularStyle(
                  ' Image',
                  Colors.black,
                  14.0,
                ),
              ],
            )
          : (snapshot.data!.docs[index]['last_message'].toString().length > 40)
              ? Text(
                  (snapshot.data!.docs[index]['last_message'].toString())
                      .replaceRange(
                          40,
                          (snapshot.data!.docs[index]['last_message']
                                  .toString())
                              .length,
                          '...'),
                  style: const TextStyle(
                    // fontFamily: font_family_name,
                    fontSize: 16.0,
                  ),
                )
              : textWithRegularStyle(
                  (snapshot.data!.docs[index]['last_message'].toString()),
                  Colors.black,
                  14.0,
                ),
    );
  }

  //
  ListTile privateChatUI(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    return ListTile(
      leading: (snapshot.data!.docs[index]['sender_firebase_id'].toString() ==
              FirebaseAuth.instance.currentUser!.uid)
          ? Container(
              height: 54,
              width: 54,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: (snapshot.data!.docs[index]['receiver_image'].toString() ==
                      '')
                  ? Container(
                      height: 54,
                      width: 54,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/icons/avatar.png',
                          ),
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(
                        27.0,
                      ),
                      child: Image.network(
                        snapshot.data!.docs[index]['receiver_image'].toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
            )
          : Container(
              height: 54,
              width: 54,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: (snapshot.data!.docs[index]['sender_image'].toString() ==
                      '')
                  ? Container(
                      height: 54,
                      width: 54,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/icons/avatar.png',
                          ),
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(
                        27.0,
                      ),
                      child: Image.network(
                        snapshot.data!.docs[index]['sender_image'].toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
      trailing: const Icon(
        Icons.chevron_right,
      ),
      title: (snapshot.data!.docs[index]['sender_firebase_id'].toString() ==
              FirebaseAuth.instance.currentUser!.uid)
          ? textWithBoldStyle(
              //
              snapshot.data!.docs[index]['receiver_name'].toString(),
              //
              Colors.black,
              18.0,
            )
          : textWithRegularStyle(
              //
              snapshot.data!.docs[index]['sender_name'].toString(),
              //
              Colors.black,
              14.0,
            ),
      subtitle: (snapshot.data!.docs[index]['message'].toString() == '')
          ? Row(
              children: [
                const Icon(
                  Icons.image,
                  size: 20.0,
                ),
                textWithRegularStyle(
                  ' Image',
                  Colors.black,
                  14.0,
                ),
              ],
            )
          : ((snapshot.data!.docs[index]['message'].toString()).length > 40)
              ? Text(
                  (snapshot.data!.docs[index]['message'].toString())
                      .replaceRange(
                          40,
                          (snapshot.data!.docs[index]['message'].toString())
                              .length,
                          '...'),
                  style: const TextStyle(
                    // fontFamily: font_family_name,
                    fontSize: 16.0,
                  ),
                )
              : textWithRegularStyle(
                  (snapshot.data!.docs[index]['message'].toString()),
                  Colors.black,
                  14.0,
                ),
    );
  }
  //
  /*
  // push
  func_push_to_private_chat(dict_dialog_data) {
    if (kDebugMode) {
      print(dict_dialog_data);
    }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ChatScreen(
    //       chatDialogData: dict_dialog_data,
    //       strFromDialog: 'yes',
    //     ),
    //   ),
    // );
  }

  //
  func_push_to_group_chat(dict_dialog_data) {
    if (kDebugMode) {
      print(dict_dialog_data);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupChatScreen(
          chatDialogData: dict_dialog_data,
        ),
      ),
    );
  }
   */
}
