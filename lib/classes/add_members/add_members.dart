// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

import '../Utils/utils.dart';

class AddMembersScreen extends StatefulWidget {
  const AddMembersScreen({super.key});

  @override
  State<AddMembersScreen> createState() => _AddMembersScreenState();
}

class _AddMembersScreenState extends State<AddMembersScreen> {
  //
  late final TextEditingController contEmail;
  //
  var strScreenLoader = '0';
  var strSeachedUserName = '';
  var strSearchedUserImage = '';
  var strSearchedUserEmail = '';
  var strSearchedUserIdCardId = '';
  var strSearchFriendFirestoreId = '';
  var strSearchFriendFirebaseId = '';
  //
  @override
  void initState() {
    //
    contEmail = TextEditingController();
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithRegularStyle(
          'Add Member',
          Colors.white,
          18.0,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: navigationColor,
      ),
      body: Column(
        children: [
          searchViaIdCardUI(context),
          //
          const SizedBox(
            height: 40,
          ),
          //
          (strScreenLoader == '0')
              ? const SizedBox(
                  height: 0,
                )
              : searchedUserShowDataUI()
          //
        ],
      ),
    );
  }

  ListTile searchedUserShowDataUI() {
    return ListTile(
      leading: SizedBox(
        height: 46,
        width: 46,
        child: Image.asset(
          'assets/images/avatar.png',
        ),
      ),
      title: textWithBoldStyle(
        //
        strSeachedUserName,
        //
        Colors.black,
        18.0,
      ),
      subtitle: textWithRegularStyle(
        //
        strSearchedUserEmail,
        //
        Colors.black,
        14.0,
      ),
      trailing: SizedBox(
        height: 50,
        width: 80,
        // color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NeoPopButton(
            color: Colors.greenAccent,
            // onTapUp: () => HapticFeedback.vibrate(),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            onTapUp: () {
              //
              funcAddUserInMyFriendsListXMPP(); //
            },
            onTapDown: () => HapticFeedback.vibrate(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: textWithRegularStyle(
                    'Add',
                    Colors.black,
                    16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container searchViaIdCardUI(BuildContext context) {
    return Container(
      // height: 100,
      margin: const EdgeInsets.only(
        top: 20.0,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(
          246,
          248,
          253,
          1,
        ),
      ),
      child: Row(
        children: [
          // SizedBox(
          //   height: 64,
          //   width: 64,
          //   child: Image.asset(
          //     'assets/images/id-card.png',
          //   ),
          // ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                left: 10.0,
                right: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  30,
                ),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffDDDDDD),
                    blurRadius: 6.0,
                    spreadRadius: 2.0,
                    offset: Offset(0.0, 0.0),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: contEmail,
                  keyboardType: TextInputType.emailAddress,
                  readOnly: false,
                  // controller: contGrindCategory,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Id Card Number...',
                  ),
                  onTap: () {
                    //

                    //
                  },
                  // validation
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          //
          SizedBox(
            height: 64,
            width: 64,
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
                  funcSearchUserViaIdCardNumber();
                  //
                },
                onTapDown: () => HapticFeedback.vibrate(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: Icon(
                        Icons.search,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ), //
        ],
      ),
    );
  }

  // //
  // funcCheckThisUserIsAlreadyFriendOrNotInXMPP() {
  //   FirebaseFirestore.instance
  //       .collection('${strFirebaseMode}user')
  //       .doc('India')
  //       .collection('details')
  //       .where('friends', arrayContainsAny: [
  //         //
  //         contEmail.text,
  //         //
  //       ])
  //       .get()
  //       .then((value) => {
  //             if (value.docs.isEmpty)
  //               {
  //                 print('======> No, he is not your friend'),
  //                 //
  //                 funcSearchUserViaIdCardNumber(),
  //                 //
  //               }
  //             else
  //               {
  //                 print('======> Yes, he is your friend'),
  //               }
  //           });
  // }

  //
  funcSearchUserViaIdCardNumber() {
    //
    startLoadingUI(context, 'please wait...');
    //
    if (kDebugMode) {
      print('dishu');
    }
    FirebaseFirestore.instance
        .collection('${strFirebaseMode}user')
        .doc('India')
        .collection('details')
        .where('id_card_number', isEqualTo: contEmail.text)
        .get()
        .then((value) => {
              if (value.docs.isEmpty)
                {
                  Navigator.pop(context),
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: navigationColor,
                      content: textWithBoldStyle(
                        //
                        'No user found.'.toString(),
                        //
                        Colors.white,
                        14.0,
                      ),
                    ),
                  ),
                }
              else
                {
                  setState(() {
                    //
                    strSeachedUserName = value.docs[0]['user_firebase_name'];
                    strSearchedUserEmail = value.docs[0]['user_firebase_email'];
                    strSearchedUserImage = value.docs[0]['user_image'];
                    strSearchFriendFirestoreId = value.docs[0]['firestore_id'];
                    strSearchedUserIdCardId = value.docs[0]['id_card_number'];
                    strSearchFriendFirebaseId =
                        value.docs[0]['user_firebase_id'];
                    //
                    strScreenLoader = '1';
                    Navigator.pop(context);
                  }),
                }
            });
  }

  // GET LOGIN USER DETAILS
  funcAddUserInMyFriendsListXMPP() {}
}
