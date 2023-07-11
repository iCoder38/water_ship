import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/utils.dart';

class GroupChatTagsUI extends StatefulWidget {
  const GroupChatTagsUI({super.key, this.getDataFromGroupChatUI});

  final getDataFromGroupChatUI;

  @override
  State<GroupChatTagsUI> createState() => _GroupChatTagsUIState();
}

class _GroupChatTagsUIState extends State<GroupChatTagsUI> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Column(
          children: [
            if (widget.getDataFromGroupChatUI['type'].toString() == 'tags') ...[
              Container(
                margin: const EdgeInsets.only(
                  left: 40.0,
                ),
                // height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.amber[50],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: textWithBoldStyle(
                      //
                      widget.getDataFromGroupChatUI['tags'].toString(),
                      //
                      Colors.black,
                      16.0,
                    ),
                  ),
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.only(
                  left: 40.0,
                ),
                // height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.lightBlue[100],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: textWithRegularStyle(
                      //
                      widget.getDataFromGroupChatUI['message'].toString(),
                      //
                      Colors.black,
                      16.0,
                    ),
                  ),
                ),
              ),
              //
              const SizedBox(
                height: 4,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 40.0,
                ),
                // height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        // height: 60,
                        width: MediaQuery.of(context).size.width,

                        decoration: BoxDecoration(
                          color: Colors.greenAccent[200],
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: textWithBoldStyle(
                              'Resolved',
                              Colors.black,
                              14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ] else ...[
              textWithRegularStyle('normal text', Colors.black, 14.0),
            ]
          ],
        )

        /*(getSnapshot[index]['message'].toString() == '')
              ? Container(
                  margin: const EdgeInsets.all(10.0),
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(
                      24.0,
                    ),
                  ),
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
                    color: Color.fromARGB(255, 228, 232, 235),
                  ),
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: textWithRegularStyle(
                    getSnapshot[index]['message'].toString(),
                    Colors.black,
                    16.0,
                  ),
                ),*/
        );
  }
}
