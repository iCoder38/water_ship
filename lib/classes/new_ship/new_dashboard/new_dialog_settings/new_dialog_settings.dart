// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:water_ship/classes/Utils/utils.dart';

class NewDialogSettingsScreen extends StatefulWidget {
  const NewDialogSettingsScreen({super.key, this.getDataForSettings});

  final getDataForSettings;

  @override
  State<NewDialogSettingsScreen> createState() =>
      _NewDialogSettingsScreenState();
}

class _NewDialogSettingsScreenState extends State<NewDialogSettingsScreen> {
  //
  var arrAlreadySaved = [];
  var getFullData = [];
  //
  @override
  void initState() {
    if (kDebugMode) {
      // print(widget.getDataForSettings['full_fetched_data']);
      // print(widget.getDataForSettings['chat_members_firebase_id']);
    }
    //
    arrAlreadySaved = widget.getDataForSettings['full_fetched_data'];
    if (kDebugMode) {
      print('=================================');
      // print(arrAlreadySaved);
      print('=================================');
    }
    //
    funcGetDetailsName();
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithBoldStyle(
          //
          '${widget.getDataForSettings['chat_title']} details',
          Colors.black,
          16.0,
        ),
        backgroundColor: navigationColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            for (int i = 0; i < getFullData.length; i++) ...[
              GestureDetector(
                onTap: () {
                  //
                  if (kDebugMode) {
                    print(getFullData[i]['member_firebase_id'].toString());
                  }
                },
                child: ListTile(
                  title: textWithBoldStyle(
                    //
                    getFullData[i]['member_name'].toString(),
                    Colors.black,
                    16.0,
                  ),
                  subtitle: textWithRegularStyle(
                    //
                    getFullData[i]['member_email'].toString(),
                    Colors.black,
                    12.0,
                  ),
                  trailing: Column(
                    children: [
                      for (int j = 0; j < arrAlreadySaved.length; j++) ...[
                        //
                        if (getFullData[i]['member_firebase_id'].toString() ==
                            arrAlreadySaved[j]['firebase_id'].toString()) ...[
                          textWithRegularStyle(
                            //
                            arrAlreadySaved[j]['member'].toString(),
                            Colors.black,
                            12.0,
                          ),
                        ]
                      ]
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

  //
  // Member's Details name
  funcGetDetailsName() {
    for (int i = 0;
        i < widget.getDataForSettings['chat_members_firebase_id'].length;
        i++) {
      // if (kDebugMode) {
      // print(widget.getDataForSettings['chat_members_firebase_id'][i]);
      // }
      //
      FirebaseFirestore.instance
          .collection("${strFirebaseMode}registrations")
          .where(
            "member_firebase_id",
            isEqualTo: widget.getDataForSettings['chat_members_firebase_id'][i],
          )
          .get()
          .then((value) {
        for (var element in value.docs) {
          if (kDebugMode) {
            // print('My Id =====> ${element.id}');
            // print('Data =====> ${element.data()}');
          }
          //
          getFullData.add(element.data());
        }
        //
        setState(() {
          /*if (kDebugMode) {
            print('===============================');
            print('========= GET FULL DATA ======');
            print(getFullData);
          }*/
        });
      });
      //
    }
  }
}
