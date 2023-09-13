// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, use_build_context_synchronously, deprecated_member_use, duplicate_ignore

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:water_ship/classes/Utils/utils.dart';
// import 'package:water_ship/classes/new_ship/new_dashboard/new_dialog_chat/image_cropping.dart';
import 'package:water_ship/classes/new_ship/new_dashboard/new_dialog_chat/new_dialog_chat_receiver_ui/new_dialog_chat_receiver_ui.dart';
import 'package:water_ship/classes/new_ship/new_dashboard/new_dialog_chat/new_dialog_chat_sender_ui/new_dialog_chat_sender_ui.dart';
import 'package:water_ship/classes/new_ship/new_dashboard/new_dialog_settings/new_dialog_settings.dart';

import 'package:file_picker/file_picker.dart';
import 'package:water_ship/classes/new_ship/new_document/new_open_documents.dart';
import 'package:water_ship/classes/new_ship/new_play_video/new_play_video.dart';

// import '../../../CROP_IMAGE/constants/colors.dart';
// import '../../../CROP_IMAGE/image_cropping.dart';
// import 'constants/colors.dart';

// import 'package:image_cropper/image_cropper.dart';

class NewDialogChatScreen extends StatefulWidget {
  const NewDialogChatScreen({
    super.key,
    this.chatDialogData,
    required this.strCompanyFirebaseId,
  });

  final chatDialogData;
  final String strCompanyFirebaseId;
  // final dictGetMainCompanyData;

  @override
  State<NewDialogChatScreen> createState() => _NewDialogChatScreenState();
}

class _NewDialogChatScreenState extends State<NewDialogChatScreen> {
  //
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //
  // CROP IMAGE
  Uint8List? imageBytes;
  //
  var strBottomScroll = '1';
  bool needsScroll = false;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _controller = ScrollController();
  var strScrollOnlyOneTime = '1';
  //
  var lastMessage = '';
  File? imageFile;
  var str_image_processing = '0';
  //
  var strEditMessageStatus = '0';
  var strSaveChatFirestoreIdForEdit = '';
  //
  TextEditingController contTextSendMessage = TextEditingController();
  //
  var strEditedLastMessageTextIs = '';
  //
  var fetchChatMembers;
  var fetchChatMembersNames;
  // var fetchChatMembers;

  var strShowImageForCrop = '0';
  @override
  void initState() {
    if (kDebugMode) {
      print('============================');
      print('======== chatDialogData ==========');
      print(widget.chatDialogData);
      print('======== COMPANY FIREBASE ID ==========');
      print(widget.strCompanyFirebaseId);
      print('============================');
      print('============================');
    }
    //

    //
    /*if (kDebugMode) {
      print('======== MEMBERS ==========');
      print(fetchChatMembers);
      print('============================');
    }*/
    //
    // _scrollDown();
    /*_controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print('At the top');
        } else {
          print('At the bottom');
        }
      }
    });*/
    super.initState();
  }

  _scrollToEnd() async {
    if (needsScroll) {
      needsScroll = false;
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 2), curve: Curves.linear);
    }
  }

  // This is what you're looking for!
  // void _scrollDown() {
  //   _controller.jumpTo(_controller.position.maxScrollExtent);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, //use this
      appBar: AppBar(
        title: textWithBoldStyle(
          //
          widget.chatDialogData['chat_title'].toString(),
          Colors.black,
          16.0,
        ),
        backgroundColor: navigationColor,
        actions: [
          IconButton(
            onPressed: () {
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewDialogSettingsScreen(
                      getDataForSettings: widget.chatDialogData),
                ),
              );
            },
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: (strShowImageForCrop == '1')
          ? Column(
              children: [
                Expanded(
                    flex: 3,
                    child: imageFile != null
                        ? Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Image.file(imageFile!))
                        : const Center(
                            child: Text("Add a picture"),
                          )),
              ],
            )
          /*Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: imageFile != null
                ? Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Image.file(
                      imageFile!,
                    ),
                  )
                : const Center(
                    child: Text("Add a picture"),
                  ),
          )*/
          : Stack(
              children: [
                Container(
                  color: Colors.transparent,
                  margin: const EdgeInsets.only(top: 0, bottom: 60),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('${strFirebaseMode}company')
                          .doc(widget.strCompanyFirebaseId)
                          .collection('dialog')
                          .where('firestore_id',
                              isEqualTo: widget.chatDialogData['firestore_id']
                                  .toString())
                          .where('chat_members_firebase_id', arrayContainsAny: [
                        //
                        FirebaseAuth.instance.currentUser!.uid,
                        //
                      ]).snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          var getSnapShopValue =
                              snapshot.data!.docs.reversed.toList();
                          if (kDebugMode) {
                            print('====> DIALOG DATA HERE <====');
                            print(getSnapShopValue.length);
                            print(getSnapShopValue[0]['chat_members_name']);
                          }
                          //
                          fetchChatMembers =
                              getSnapShopValue[0]['chat_members_firebase_id'];
                          fetchChatMembersNames =
                              getSnapShopValue[0]['chat_members_name'];
                          //
                          return (snapshot.data!.docs.isEmpty)
                              ? noLongerAmemberInGroupPupUpUI(context)
                              : liveChatFetchedUI();
                        } else if (snapshot.hasError) {
                          if (kDebugMode) {
                            print(snapshot.error);
                          }
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
                //
                // ======> SEND MESSAGE UI <======
                // ===============================
                Align(
                  alignment: Alignment.bottomCenter,
                  child: sendMessageUI(),
                ),
                // ================================
                // ================================
                //
                (str_image_processing == '1')
                    ? Container(
                        // margin: const EdgeInsets.all(10.0),
                        color: const Color.fromRGBO(
                          246,
                          248,
                          253,
                          1,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 48.0,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: navigationColor,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              textWithRegularStyle(
                                'processing...',
                                Colors.black,
                                14.0,
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 0,
                      ),
              ],
            ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> liveChatFetchedUI() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
              "${strFirebaseMode}company",
            )
            .doc(widget.strCompanyFirebaseId)
            .collection('chats')
            .doc(widget.chatDialogData['firestore_id'].toString())
            .collection('details')
            .orderBy('time_stamp', descending: true)
            .limit(40)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (kDebugMode) {
              print('=====> YES, DATA');
            }
            //
            if (strScrollOnlyOneTime == '1') {
              needsScroll = true;
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => _scrollToEnd());
            }
            //

            var getSnapShopValue = snapshot.data!.docs.reversed.toList();
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
                  /*Align(
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      onTap: () {
                        // needsScroll = true;
                        // WidgetsBinding.instance
                        //     .addPostFrameCallback((_) => _scrollToEnd());
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
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
                              ), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),*/
                ],

                //

                NotificationListener<ScrollNotification>(
                  /*onNotification: (ScrollNotification scrollEnd) {
                    final metrics = scrollEnd.metrics;
                    if (metrics.atEdge) {
                      bool isTop = metrics.pixels == 0;
                      if (isTop) {
                        if (kDebugMode) {
                          print('At the top');
                          print(metrics.pixels);
                        }
                      } else {
                        if (kDebugMode) {
                          print('At the bottom');
                          print(metrics.pixels);
                        }
                        // needsScroll = true;
                        // WidgetsBinding.instance
                        //     .addPostFrameCallback((_) => _scrollToEnd());
                      }
                    }
                    return true;
                  },*/
                  onNotification: (ScrollNotification notification) {
                    if (notification is UserScrollNotification) {
                      final metrics = notification.metrics;
                      if (metrics.atEdge) {
                        bool isTop = metrics.pixels == 0;
                        if (isTop) {
                          if (kDebugMode) {
                            print('At the top new');
                            // print(metrics.pixels);
                          }
                          //
                          strScrollOnlyOneTime = '0';
                        } else if (notification.direction ==
                            ScrollDirection.forward) {
                          //
                          if (kDebugMode) {
                            print('scroll down');
                          }
                          //
                          strBottomScroll = '0';
                          strScrollOnlyOneTime = '0';
                        } else if (notification.direction ==
                            ScrollDirection.reverse) {
                          // Handle scroll up.
                          if (kDebugMode) {
                            print('scroll up');
                          }
                        } else {
                          //
                          // if (strScrollOnlyOneTime == 'start_scrolling')
                          if (kDebugMode) {
                            print('Bottom');
                            // print(metrics.pixels);
                          }
                          //
                          strScrollOnlyOneTime = '1';
                        }
                      } /* else {
                        //
                        if (notification.direction == ScrollDirection.forward) {
                          // Handle scroll down.
                          if (kDebugMode) {
                            print('scroll down');
                          }
                          //
                          strBottomScroll = '0';
                          strScrollOnlyOneTime = '0';
                          //
                        } else if (notification.direction ==
                            ScrollDirection.reverse) {
                          // Handle scroll up.
                          if (kDebugMode) {
                            print('scroll up');
                          }
                        }
                        //
                      }*/
                    }

                    // Returning null (or false) to
                    // "allow the notification to continue to be dispatched to further ancestors".
                    return true;
                  },
                  child: Form(
                    key: formKey,
                    child: ListView.builder(
                      // controller: controller,
                      controller: _scrollController,
                      // reverse: true,
                      itemCount: getSnapShopValue.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (strScrollOnlyOneTime == '1') {
                          if (kDebugMode) {
                            print('position ====> $strScrollOnlyOneTime');
                          }
                          //
                          needsScroll = true;
                          WidgetsBinding.instance
                              .addPostFrameCallback((_) => _scrollToEnd());
                          // strBottomScroll = '0';
                        }
                        return Container(
                          padding: const EdgeInsets.only(
                            left: 14,
                            right: 14,
                            //
                            top: 10,
                            bottom: 10,
                          ),
                          child: Align(
                              alignment: (getSnapShopValue[index]
                                              ['sender_firebase_id']
                                          .toString() ==
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? Alignment.topRight
                                  : Alignment.topLeft),
                              child: (getSnapShopValue[index]
                                              ['sender_firebase_id']
                                          .toString() ==
                                      FirebaseAuth.instance.currentUser!.uid)
                                  ? /*NewDialogChatSenderUIScreen(
                                      getSnapshot: getSnapShopValue,
                                      getIndex: index,
                                    )*/
                                  senderUI(getSnapShopValue, index)
                                  : NewDialogChatReceiverUIScreen(
                                      getSnapshot: getSnapShopValue,
                                      getIndex: index,
                                    )

                              // receiverUI(getSnapShopValue,
                              // index)

                              //receiverUI(getSnapShopValue, index),
                              ),
                        );
                      },
                    ),
                  ),
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
  }

  /// **************************************************************************
  /// **************************************************************************
  // UI AND PARSE - RECEIVER
  /// **************************************************************************
  /// **************************************************************************
  Column receiverUI(getSnapshot, int index) {
    return Column(
      children: [
        //
        Align(
          alignment: Alignment.bottomLeft,
          child: textWithRegularStyle(
            //
            getSnapshot[index]['sender_name'],
            //
            Colors.black,
            10.0,
          ),
        ),
        //
        Align(
          alignment: Alignment.bottomLeft,
          child: (getSnapshot[index]['message'].toString() == '')
              ? Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.transparent,
                  width: 240,
                  height: 240,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      24,
                    ),
                    child: Image.network(
                      getSnapshot[index]['attachment_path'].toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(
                    right: 40,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        16,
                      ),
                      bottomRight: Radius.circular(
                        16,
                      ),
                      topRight: Radius.circular(
                        16,
                      ),
                    ),
                    color: Colors.blue[200],
                  ),
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: textWithRegularStyle(
                    //
                    getSnapshot[index]['message'].toString(),
                    //
                    Colors.black,
                    14.0,
                  ),
                ),
        ),
        //
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (getSnapshot[index]['status'].toString() == '0') ...[
              textWithRegularStyle(
                funcConvertTimeStampToDateAndTime(
                  getSnapshot[index]['time_stamp'],
                ),
                Colors.black54,
                10.0,
              ),
            ] else if (getSnapshot[index]['status'].toString() == '1') ...[
              textWithRegularStyle(
                '(Edited) ',
                Colors.black,
                10.0,
              ),
              textWithRegularStyle(
                funcConvertTimeStampToDateAndTime(
                  getSnapshot[index]['time_stamp'],
                ),
                Colors.black54,
                10.0,
              ),
            ] else if (getSnapshot[index]['status'].toString() == '2') ...[
              textWithRegularStyle(
                funcConvertTimeStampToDateAndTime(
                  getSnapshot[index]['time_stamp'],
                ),
                Colors.black54,
                10.0,
              ),
            ]
          ],
        ),
        //
        //
      ],
    );
  }

  /// **************************************************************************
  /// **************************************************************************
  // POPUP - NO LONGER MEMBER
  /// **************************************************************************
  AlertDialog noLongerAmemberInGroupPupUpUI(BuildContext context) {
    return AlertDialog(
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
    );
  }

  /// **************************************************************************
  /// **************************************************************************
  // UI - send message
  /// **************************************************************************
  /// **************************************************************************
  Padding sendMessageUI() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 0),
        color: const Color.fromARGB(255, 234, 233, 233),
        // height: 60,
        // width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    onPressed: () {
                      //
                      FocusManager.instance.primaryFocus?.unfocus();
                      openGalleryOrCamera(context);
                    },
                    icon: const Icon(
                      Icons.attachment,
                    ),
                  )
                  /*NeoPopButton(
                  color: navigationColor,
                  // onTapUp: () => HapticFeedback.vibrate(),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  onTapUp: () {
                    //
                    openGalleryOrCamera(context);
                    //
                  },
                  onTapDown: () => HapticFeedback.vibrate(),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.attachment,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),*/
                  ),
            ),
            //
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autofocus: true,
                  controller: contTextSendMessage,
                  minLines: 1,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    // labelText: '',
                    hintText: 'write something',
                  ),
                ),
              ),
            ),
            //

            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    onPressed: () {
                      //
                      if (strEditMessageStatus == '1') {
                        // update text
                        funcUpdateSimpleText();
                      } else {
                        // print('me print');
                        sendMessageViaFirebase(contTextSendMessage.text);
                        lastMessage = contTextSendMessage.text.toString();
                        contTextSendMessage.text = '';
                        //
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                    ),
                  )
                  /*NeoPopButton(
                  color: navigationColor,
                  // onTapUp: () => HapticFeedback.vibrate(),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  onTapUp: () {
                    //
                    if (strEditMessageStatus == '1') {
                      // update text
                      funcUpdateSimpleText();
                    } else {
                      // print('me print');
                      sendMessageViaFirebase(contTextSendMessage.text);
                      lastMessage = contTextSendMessage.text.toString();
                      contTextSendMessage.text = '';
                      //
                    }
                  },
                  onTapDown: () => HapticFeedback.vibrate(),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),*/
                  ),
            ),
            /*IconButton(
              onPressed: () {
                if (kDebugMode) {
                  print('send');
                }
                //
    
                
                lastMessage = contTextSendMessage.text.toString();
                contTextSendMessage.text = '';
    
                // }
              },
              icon: const Icon(
                Icons.send,
              ),
            ),*/
            //
          ],
        ),
      ),
    );
  }

  /// **************************************************************************
  /// ************************ SENDER ******************************************
  /// **************************************************************************
  // UI AND PARSE - SENDER
  /// **************************************************************************
  /// **************************************************************************
  Column senderUI(getSnapshot, int index) {
    return Column(
      children: [
        //
        Align(
          alignment: Alignment.bottomRight,
          child: textWithRegularStyle(
            //
            getSnapshot[index]['sender_name'],
            //
            Colors.black87,
            12.0,
          ),
        ),
        //
        const SizedBox(
          height: 4,
        ),
        //
        Column(
          children: [
            if (getSnapshot[index]['type'] == 'Video') ...[
              //
              showSenderVideoUI(context, getSnapshot, index)
            ] else if (getSnapshot[index]['type'] == 'Image') ...[
              //
              showSenderImageUI(context, getSnapshot, index),
            ] else if (getSnapshot[index]['type'] == 'Text') ...[
              //
              showSenderTextUI(context, getSnapshot, index),
            ] else if (getSnapshot[index]['type'] == 'Document') ...[
              //
              showSenderDocumentUI(context, getSnapshot, index),
            ]
          ],
        ),
        //
        const SizedBox(
          height: 10,
        ),
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (getSnapshot[index]['status'].toString() == '0') ...[
              textWithRegularStyle(
                funcConvertTimeStampToDateAndTime(
                  getSnapshot[index]['time_stamp'],
                ),
                Colors.black54,
                10.0,
              ),
            ] else if (getSnapshot[index]['status'].toString() == '1') ...[
              textWithRegularStyle(
                funcConvertTimeStampToDateAndTime(
                  getSnapshot[index]['time_stamp'],
                ),
                Colors.black54,
                10.0,
              ),
              textWithRegularStyle(
                ' (Edited)',
                Colors.black,
                10.0,
              ),
            ] else if (getSnapshot[index]['status'].toString() == '2') ...[
              textWithRegularStyle(
                funcConvertTimeStampToDateAndTime(
                  getSnapshot[index]['time_stamp'],
                ),
                Colors.black54,
                10.0,
              ),
            ]
          ],
        ),
        //
      ],
    );
  }

  /// **************************************************************************
  /// **************************************************************************
  // sender : document ui
  /// **************************************************************************
  Align showSenderDocumentUI(BuildContext context, snapshotIs, indexIs) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {
          //
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewOpenDocumentScreen(
                getURL: snapshotIs[indexIs]['attachment_path'].toString(),
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(left: 80.0),
          height: 120,
          width: 140, //MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textWithRegularStyle(
                  'Document',
                  Colors.black,
                  16.0,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 0.0),
                // height: 140,
                // width: MediaQuery.of(context).size.width,
                width: 80,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/folder.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **************************************************************************
  // sender : text ui
  /// **************************************************************************
  Column showSenderTextUI(BuildContext context, snapshotIs, indexIs) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (snapshotIs[indexIs]['status'].toString() == '2') ...[
          // delete text
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(
                left: 40,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    16,
                  ),
                  bottomLeft: Radius.circular(
                    16,
                  ),
                  topRight: Radius.circular(
                    16,
                  ),
                ),
                color: Color.fromARGB(255, 223, 113, 113),
              ),
              padding: const EdgeInsets.all(
                8,
              ),
              child: textWithRegularStyle(
                snapshotIs[indexIs]['message'].toString(),
                Colors.white,
                14.0,
              ),
            ),
          ),
        ] else ...[
          // normal text
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                //
                if (kDebugMode) {
                  print('user clicked on chat message line number => 1017');
                  print('Status ==> ${snapshotIs[indexIs]['status']}');
                }
                //
                // when message delete
                if (snapshotIs[indexIs]['status'].toString() != '2') {
                  //
                  strEditMessageStatus = '1';
                  //
                  strSaveChatFirestoreIdForEdit =
                      snapshotIs[indexIs]['firestore_id'].toString();
                  //
                  openSheetToEditOrDeleteMessage(
                    context,
                    snapshotIs[indexIs]['message'].toString(),
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 40,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    2.0,
                  ),
                  /*borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  16,
                                ),
                                bottomLeft: Radius.circular(
                                  16,
                                ),
                                topRight: Radius.circular(
                                  16,
                                ),
                              ),*/
                  color: const Color.fromARGB(255, 228, 232, 235),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(
                  16,
                ),
                child: textWithRegularStyle(
                  snapshotIs[indexIs]['message'].toString(),
                  Colors.black,
                  14.0,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// **************************************************************************
  // sender : image ui
  /// **************************************************************************
  Align showSenderImageUI(BuildContext context, snapshotIs, indexIs) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 240,
            width: 60,
            color: Colors.transparent,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    //
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            width: 240,
            height: 240,
            decoration: const BoxDecoration(
              color: Colors.amber,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                2,
              ),
              child: Image.network(
                snapshotIs[indexIs]['attachment_path'].toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// **************************************************************************
  // sender : video ui
  /// **************************************************************************
  Align showSenderVideoUI(BuildContext context, snapshotIs, indexIs) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        width: 240,
        height: 240,
        decoration: const BoxDecoration(
          color: Colors.amber,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: IconButton(
          onPressed: () {
            // play video
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayVideoScreen(
                  getURL: snapshotIs[indexIs]['attachment_path'].toString(),
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  /// **************************************************************************
  /// **************************************************************************
  /// **************************************************************************
  ///
  ///
  /// **************************************************************************
  /// **************************************************************************
  // open action sheet of edit , delete message
  /// **************************************************************************
  /// **************************************************************************
  void openSheetToEditOrDeleteMessage(
    BuildContext context,
    chatMessage,
  ) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: textWithRegularStyle(
          'settings',
          Colors.black,
          10.0,
        ),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              //
              contTextSendMessage.text = chatMessage;
              //
              Navigator.pop(context);
            },
            child: textWithRegularStyle(
              'edit',
              Colors.black,
              14.0,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              //
              funcDeleteSimpleText();
              //
              Navigator.pop(context);
            },
            child: textWithRegularStyle(
              'delete',
              Colors.black,
              14.0,
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: textWithRegularStyle(
              'dismiss',
              Colors.redAccent,
              14.0,
            ),
          ),
        ],
      ),
    );
  }

  /// **************************************************************************
  /// **************************************************************************
  // open action sheet of camera and gallery
  /// **************************************************************************
  /// **************************************************************************
  void openGalleryOrCamera(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Camera option'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // ignore: deprecated_member_use
              PickedFile? pickedFile = await ImagePicker().getImage(
                source: ImageSource.camera,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              if (pickedFile != null) {
                setState(() {
                  if (kDebugMode) {
                    print('camera');
                  }
                  imageFile = File(pickedFile.path);
                });
                //
                str_image_processing = '1';
                uploadImageToFirebase(context);
              }
            },
            child: textWithRegularStyle(
              'camera',
              Colors.black,
              14.0,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // ignore: deprecated_member_use
              PickedFile? pickedFile = await ImagePicker().getImage(
                source: ImageSource.gallery,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              if (pickedFile != null) {
                setState(() {
                  if (kDebugMode) {
                    print('gallery');
                  }
                  imageFile = File(pickedFile.path);
                });
                str_image_processing = '1';
                uploadImageToFirebase(context);
              }
            },
            child: textWithRegularStyle(
              'gallery',
              Colors.black,
              14.0,
            ),
          ),
          //
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // ignore: deprecated_member_use
              selectVideo();
              //
            },
            child: textWithRegularStyle(
              'Video from Gallery',
              Colors.black,
              14.0,
            ),
          ),
          //
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // ignore: deprecated_member_use
              openDocuments();
              //
            },
            child: textWithRegularStyle(
              'Documents',
              Colors.black,
              14.0,
            ),
          ),
          //
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: textWithRegularStyle(
              'dismiss',
              Colors.black,
              14.0,
            ),
          ),
        ],
      ),
    );
  }

// Add the below function inside your working class
  /*Future cropImage() async {
    if (imageFile != null) {
      CroppedFile? cropped = await ImageCropper()
          .cropImage(sourcePath: imageFile!.path, aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ], uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop',
            cropGridColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(title: 'Crop')
      ]);

      if (cropped != null) {
        setState(() {
          imageFile = File(cropped.path);
        });
      }
    }
  }

  void clearImage() {
    setState(() {
      imageFile = null;
    });
  }*/

// upload files
  void openDocuments() async {
    //
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;

      if (kDebugMode) {
        print(fileBytes);
        print(fileName);
        print(result.files.first.path);
      }

      imageFile = File(result.files.first.path!);

      // print(imageFile);
      uploadDocToFirebase(context, fileName.toString());
    }
  }

// select multiple images
  void selectVideo() async {
    //
    // imageFileList!.clear();
    //
    PickedFile? pickedFile = await ImagePicker().getVideo(
      source: ImageSource.gallery,
      // maxWidth: 1800,
      // maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        if (kDebugMode) {
          print('object 1');
        }

        imageFile = File(pickedFile.path);
        //
        if (kDebugMode) {
          print(imageFile);
        }
        //
        uploadVideoToFirebase(context);
        //
      });
    }
  }

  /// **************************************************************************
  /// **************************************************************************
  // upload doc via firebase
  /// **************************************************************************
  /// **************************************************************************
  Future uploadDocToFirebase(BuildContext context, name) async {
    // String fileName = basename(imageFile_for_profile!.path);
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child(
          'chatDoc/${FirebaseAuth.instance.currentUser!.uid}',
        )
        .child(
          generateRandomString(10),
        );
    await storageRef.putFile(imageFile!);
    return await storageRef.getDownloadURL().then((value) => {
          // print(
          // '======>$value',
          // )

          sendMessageWithDocuemntViaFirebase(value, name),
        });
  }

  /// **************************************************************************
  /// **************************************************************************
  // upload video via firebase
  /// **************************************************************************
  /// **************************************************************************
  Future uploadVideoToFirebase(BuildContext context) async {
    // String fileName = basename(imageFile_for_profile!.path);
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child(
          'chatVideo/${FirebaseAuth.instance.currentUser!.uid}',
        )
        .child(
          generateRandomString(10),
        );
    await storageRef.putFile(imageFile!);
    return await storageRef.getDownloadURL().then((value) => {
          // print(
          // '======>$value',
          // )

          sendMessageWithVideoViaFirebase(value)
        });
  }

  /// **************************************************************************
  /// **************************************************************************
  // upload image via firebase
  /// **************************************************************************
  /// **************************************************************************
  Future uploadImageToFirebase(BuildContext context) async {
    // String fileName = basename(imageFile_for_profile!.path);
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child(
          'chat/${FirebaseAuth.instance.currentUser!.uid}',
        )
        .child(
          generateRandomString(10),
        );
    // .child("/video.mov");
    await storageRef.putFile(imageFile!);
    return await storageRef.getDownloadURL().then((value) => {
          // print(
          //   '======>$value',
          // )

          sendMessageWithImageViaFirebase(value)
        });
  }

  /// **************************************************************************
  /// **************************************************************************
  // send message with attachment for video
  /// **************************************************************************
  /// **************************************************************************
  sendMessageWithDocuemntViaFirebase(imagePath, fileName) {
    // print(cont_txt_send_message.text);
    setState(() {
      str_image_processing = '0';
    });
    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}company/${widget.strCompanyFirebaseId}/chats/${widget.chatDialogData['firestore_id'].toString()}/details',
    );

    users
        .add(
          {
            'attachment_path': imagePath.toString(),
            'sender_image': ''.toString(),
            'sender_name':
                FirebaseAuth.instance.currentUser!.displayName.toString(),
            'sender_firebase_id': FirebaseAuth.instance.currentUser!.uid,
            'message': '',
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'room': 'group',
            'type': 'Document',
            'document_name': fileName,
            'chat_members': fetchChatMembers,
            'status': '0',
          },
        )
        .then(
          (value) =>
              //
              funcEditMessageAndInsertFirestoreId(value.id),
          //
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  /// **************************************************************************
  /// **************************************************************************
  // send message with attachment for video
  /// **************************************************************************
  /// **************************************************************************
  sendMessageWithVideoViaFirebase(imagePath) {
    // print(cont_txt_send_message.text);
    setState(() {
      str_image_processing = '0';
    });
    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}company/${widget.strCompanyFirebaseId}/chats/${widget.chatDialogData['firestore_id'].toString()}/details',
    );

    users
        .add(
          {
            'attachment_path': imagePath.toString(),
            'sender_image': ''.toString(),
            'sender_name':
                FirebaseAuth.instance.currentUser!.displayName.toString(),
            'sender_firebase_id': FirebaseAuth.instance.currentUser!.uid,
            'message': '',
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'room': 'group',
            'type': 'Video',
            'chat_members': fetchChatMembers,
            'status': '0',
          },
        )
        .then(
          (value) =>
              //
              funcEditMessageAndInsertFirestoreId(value.id),
          //
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  /// **************************************************************************
  /// **************************************************************************
  // send message with attachment
  /// **************************************************************************
  /// **************************************************************************
  sendMessageWithImageViaFirebase(imagePath) {
    // print(cont_txt_send_message.text);
    setState(() {
      str_image_processing = '0';
      lastMessage = '^chat_attachment^';
    });
    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}company/${widget.strCompanyFirebaseId}/chats/${widget.chatDialogData['firestore_id'].toString()}/details',
    );

    users
        .add(
          {
            'attachment_path': imagePath.toString(),
            'sender_image': ''.toString(),
            'sender_name':
                FirebaseAuth.instance.currentUser!.displayName.toString(),
            'sender_firebase_id': FirebaseAuth.instance.currentUser!.uid,
            'message': '',
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'room': 'group',
            'type': 'Image',
            'chat_members': fetchChatMembers,
            'status': '0',
          },
        )
        .then(
          (value) =>
              //
              funcEditMessageAndInsertFirestoreId(value.id),
          //
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  /// **************************************************************************
  /// **************************************************************************
  // send message without attachment
  /// **************************************************************************
  /// **************************************************************************
  sendMessageViaFirebase(strLastMessageEntered) {
    // print(cont_txt_send_message.text);

    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}company/${widget.strCompanyFirebaseId}/chats/${widget.chatDialogData['firestore_id'].toString()}/details',
    );

    users
        .add(
          {
            'attachment_path': '',
            'sender_image': ''.toString(),
            'sender_name':
                FirebaseAuth.instance.currentUser!.displayName.toString(),
            'sender_firebase_id': FirebaseAuth.instance.currentUser!.uid,
            'message': strLastMessageEntered.toString(),
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'room': 'group',
            'type': 'Text',
            'chat_members': fetchChatMembers,
            //
            'status': '0',
          },
        )
        .then(
          (value) =>
              //
              funcEditMessageAndInsertFirestoreId(value.id),
          //
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  /// **************************************************************************
  /// **************************************************************************
  // UPDATE FIRESTORE IF AFTER SEND A MESSAGE
  /// **************************************************************************
  /// **************************************************************************
  funcEditMessageAndInsertFirestoreId(value2) {
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}company")
        .doc(widget.strCompanyFirebaseId)
        .collection('chats')
        .doc(widget.chatDialogData['firestore_id'].toString())
        .collection('details')
        .doc(value2)
        .set(
      {
        'firestore_id': value2.toString(),
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        // print('update chat firestore');
        strScrollOnlyOneTime = '1';
        funcUpdateDialogData(value2.toString());
      },
    );
  }

  /// **************************************************************************
  /// **************************************************************************
  // UPLOAD DIALOG
  /// **************************************************************************
  /// **************************************************************************
  funcUpdateDialogData(last_message_firestore_id) {
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}company")
        .doc(widget.strCompanyFirebaseId)
        .collection('dialog')
        .doc(widget.chatDialogData['firestore_id'].toString())
        .set(
      {
        'last_message': lastMessage.toString(),
        'message': lastMessage.toString(),
        'last_message_user_name':
            FirebaseAuth.instance.currentUser!.displayName.toString(),
        'last_message_firestore_id': last_message_firestore_id,
        //
        'time_stamp': DateTime.now().millisecondsSinceEpoch,
        'last_message_status': '0',
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        if (kDebugMode) {
          print('========================================');
          print('last message fid ====> $last_message_firestore_id');
          print('Update everything after send a message.');
          print('========================================');
        }
      },
    );
  }

  //
  /// **************************************************************************
  /// **************************************************************************
  //  EDIT SIMPLE TEXT and UPDATE DIALOG
  /// **************************************************************************
  /// **************************************************************************

  funcUpdateSimpleText() {
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}company")
        .doc(widget.strCompanyFirebaseId)
        .collection('chats')
        .doc(widget.chatDialogData['firestore_id'].toString())
        .collection('details')
        .doc(strSaveChatFirestoreIdForEdit)
        .set(
      {
        'message': contTextSendMessage.text.toString(),
        'status': '1',
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        if (kDebugMode) {
          print('========================================');
          print(strSaveChatFirestoreIdForEdit);
          print('Edit message successfully.');
          print('========================================');
        }
        //
        strEditedLastMessageTextIs = contTextSendMessage.text.toString();
        contTextSendMessage.text = '';
        strEditMessageStatus = '0';
        funcUpdateDialogAboutLastMessage();
      },
    );
  }
  //

  funcUpdateDialogAboutLastMessage() {
    FirebaseFirestore.instance
        .collection('${strFirebaseMode}company')
        .doc(widget.strCompanyFirebaseId)
        .collection('dialog')
        .where('firestore_id',
            isEqualTo: widget.chatDialogData['firestore_id'].toString())
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND,');
        }
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
          if (element.data()['last_message_firestore_id'].toString() ==
              strSaveChatFirestoreIdForEdit.toString()) {
            if (kDebugMode) {
              print('YES IT IS A LAST INDEX');
            }
            FirebaseFirestore.instance
                .collection("${strFirebaseMode}company")
                .doc(widget.strCompanyFirebaseId)
                .collection('dialog')
                .doc(widget.chatDialogData['firestore_id'].toString())
                .set(
              {
                'message': strEditedLastMessageTextIs.toString(),
                'last_message': strEditedLastMessageTextIs.toString(),
                'last_message_status': '1',
              },
              SetOptions(merge: true),
            ).then(
              (value1) {
                if (kDebugMode) {
                  print('========================================');
                  // print('last message fid ====> ' + last_message_firestore_id);
                  print('Update everything after send a message.');
                  print('========================================');
                }
              },
            );
          } else {
            if (kDebugMode) {
              print('NO IT"s NOT IS A LAST INDEX');
            }
          }
        }
        //
      }
    });
  }
  //
  /// **************************************************************************
  /// **************************************************************************
  // UPDATE OR EDIT SIMPLE TEXT
  /// **************************************************************************
  /// **************************************************************************

  funcDeleteSimpleText() {
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}company")
        .doc(widget.strCompanyFirebaseId)
        .collection('chats')
        .doc(widget.chatDialogData['firestore_id'].toString())
        .collection('details')
        .doc(strSaveChatFirestoreIdForEdit)
        .set(
      {
        'message': 'This message was deleted'.toString(),
        'status': '2',
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        if (kDebugMode) {
          print('========================================');
          print('Update everything after send a message.');
          print('========================================');
        }
        //
        strEditedLastMessageTextIs = contTextSendMessage.text.toString();
        strEditMessageStatus = '0';
        contTextSendMessage.text = '';
        //
        funcUpdateDialogAboutLastMessageDelete();
      },
    );
  }

  //
  funcUpdateDialogAboutLastMessageDelete() {
    FirebaseFirestore.instance
        .collection('${strFirebaseMode}company')
        .doc(widget.strCompanyFirebaseId)
        .collection('dialog')
        .where('firestore_id',
            isEqualTo: widget.chatDialogData['firestore_id'].toString())
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND,');
        }
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
          if (element.data()['last_message_firestore_id'].toString() ==
              strSaveChatFirestoreIdForEdit.toString()) {
            if (kDebugMode) {
              print('YES IT IS A LAST INDEX');
            }
            FirebaseFirestore.instance
                .collection("${strFirebaseMode}company")
                .doc(widget.strCompanyFirebaseId)
                .collection('dialog')
                .doc(widget.chatDialogData['firestore_id'].toString())
                .set(
              {
                'last_message_status': '2',
              },
              SetOptions(merge: true),
            ).then(
              (value1) {
                if (kDebugMode) {
                  print('========================================');
                  // print('last message fid ====> ' + last_message_firestore_id);
                  print('Update everything after send a message.');
                  print('========================================');
                }
              },
            );
          } else {
            if (kDebugMode) {
              print('NO IT"s NOT IS A LAST INDEX');
            }
          }
        }
        //
      }
    });
  }

  /// **************************************************************************
  /// **************************************************************************
  // generate random string
  /// **************************************************************************
  /// **************************************************************************
  String generateRandomString(int lengthOfString) {
    final random = Random();
    const allChars =
        'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(lengthOfString,
        (index) => allChars[random.nextInt(allChars.length)]).join();
    return randomString; // return the generated string
  }
}
