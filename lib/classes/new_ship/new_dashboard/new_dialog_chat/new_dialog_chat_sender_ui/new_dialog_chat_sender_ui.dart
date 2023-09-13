// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:water_ship/classes/new_ship/new_document/new_open_documents.dart';
import 'package:water_ship/classes/new_ship/new_play_video/new_play_video.dart';

import '../../../../Utils/utils.dart';

class NewDialogChatSenderUIScreen extends StatefulWidget {
  const NewDialogChatSenderUIScreen(
      {super.key, this.getSnapshot, this.getIndex});

  final getSnapshot;
  final getIndex;

  @override
  State<NewDialogChatSenderUIScreen> createState() =>
      _NewDialogChatSenderUIScreenState();
}

class _NewDialogChatSenderUIScreenState
    extends State<NewDialogChatSenderUIScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        Align(
          alignment: Alignment.bottomRight,
          child: textWithRegularStyle(
            //
            widget.getSnapshot[widget.getIndex]['sender_name'],
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
            if (widget.getSnapshot[widget.getIndex]['type'] == 'Video') ...[
              //
              showSenderVideoUI(context)
            ] else if (widget.getSnapshot[widget.getIndex]['type'] ==
                'Image') ...[
              //
              showSenderImageUI(),
            ] else if (widget.getSnapshot[widget.getIndex]['type'] ==
                'Text') ...[
              //
              showSenderTextUI(),
            ] else if (widget.getSnapshot[widget.getIndex]['type'] ==
                'Document') ...[
              //
              showSenderDocumentUI(context),
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
            if (widget.getSnapshot[widget.getIndex]['status'].toString() ==
                '0') ...[
              textWithRegularStyle(
                funcConvertTimeStampToDateAndTime(
                  widget.getSnapshot[widget.getIndex]['time_stamp'],
                ),
                Colors.black54,
                10.0,
              ),
            ] else if (widget.getSnapshot[widget.getIndex]['status']
                    .toString() ==
                '1') ...[
              textWithRegularStyle(
                funcConvertTimeStampToDateAndTime(
                  widget.getSnapshot[widget.getIndex]['time_stamp'],
                ),
                Colors.black54,
                10.0,
              ),
              textWithRegularStyle(
                ' (Edited)',
                Colors.black,
                10.0,
              ),
            ] else if (widget.getSnapshot[widget.getIndex]['status']
                    .toString() ==
                '2') ...[
              textWithRegularStyle(
                funcConvertTimeStampToDateAndTime(
                  widget.getSnapshot[widget.getIndex]['time_stamp'],
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
  // sender : document ui
  /// **************************************************************************
  Align showSenderDocumentUI(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {
          //
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewOpenDocumentScreen(
                getURL: widget.getSnapshot[widget.getIndex]['attachment_path']
                    .toString(),
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
  Column showSenderTextUI() {
    return Column(
      children: [
        if (widget.getSnapshot[widget.getIndex]['status'].toString() ==
            '2') ...[
          // delete text
          Container(
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
              widget.getSnapshot[widget.getIndex]['message'].toString(),
              Colors.white,
              14.0,
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
                  print('user clicked on chat message line number => 218');
                  print(
                      'Status ==> ${widget.getSnapshot[widget.getIndex]['status']}');
                }
                //
                // when message delete
                if (widget.getSnapshot[widget.getIndex]['status'].toString() !=
                    '2') {
                  //
                  /*strEditMessageStatus = '1';
                      //
                      strSaveChatFirestoreIdForEdit =
                          getSnapshot[index]['firestore_id'].toString();*/
                  //
                  openSheetToEditOrDeleteMessage(
                    context,
                    widget.getSnapshot[widget.getIndex]['message'].toString(),
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
                  widget.getSnapshot[widget.getIndex]['message'].toString(),
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
  Align showSenderImageUI() {
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
                widget.getSnapshot[widget.getIndex]['attachment_path']
                    .toString(),
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
  Align showSenderVideoUI(BuildContext context) {
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
                  getURL: widget.getSnapshot[widget.getIndex]['attachment_path']
                      .toString(),
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

  //
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
              // contTextSendMessage.text = chatMessage;
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
              // funcDeleteSimpleText();
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
}
