// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../../Utils/utils.dart';
import '../../../new_document/new_open_documents.dart';
import '../../../new_play_video/new_play_video.dart';

class NewDialogChatReceiverUIScreen extends StatefulWidget {
  const NewDialogChatReceiverUIScreen(
      {super.key, this.getSnapshot, this.getIndex});

  final getSnapshot;
  final getIndex;

  @override
  State<NewDialogChatReceiverUIScreen> createState() =>
      _NewDialogChatReceiverUIScreenState();
}

class _NewDialogChatReceiverUIScreenState
    extends State<NewDialogChatReceiverUIScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        Align(
          alignment: Alignment.bottomLeft,
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
              showVideoUI(context)
            ] else if (widget.getSnapshot[widget.getIndex]['type'] ==
                'Image') ...[
              //
              showImageUI(),
            ] else if (widget.getSnapshot[widget.getIndex]['type'] ==
                'Text') ...[
              //
              showTextUI(),
            ] else if (widget.getSnapshot[widget.getIndex]['type'] ==
                'Document') ...[
              //
              showDocumentUI(context),
            ]
          ],
        ),
        //
        const SizedBox(
          height: 10,
        ),
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
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

  Align showDocumentUI(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
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
          margin: const EdgeInsets.only(right: 80.0),
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

  Column showTextUI() {
    return Column(
      children: [
        if (widget.getSnapshot[widget.getIndex]['status'].toString() ==
            '2') ...[
          // delete text
          Container(
            margin: const EdgeInsets.only(
              right: 40,
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
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: const EdgeInsets.only(
                right: 40,
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
                color: Colors.white,
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
        ],
      ],
    );
  }

  Align showImageUI() {
    return Align(
      alignment: Alignment.bottomLeft,
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            2,
          ),
          child: Image.network(
            widget.getSnapshot[widget.getIndex]['attachment_path'].toString(),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Align showVideoUI(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
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
}
