// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:water_ship/classes/Utils/utils.dart';

class NewCreateChatPanelScreen extends StatefulWidget {
  const NewCreateChatPanelScreen({super.key, this.chatDialogData});

  final chatDialogData;

  @override
  State<NewCreateChatPanelScreen> createState() =>
      _NewCreateChatPanelScreenState();
}

class _NewCreateChatPanelScreenState extends State<NewCreateChatPanelScreen> {
  //
  TextEditingController contTextSendMessage = TextEditingController();
  //
  // IMAGE
  File? imageFile;
  var str_user_select_image = '0';

  var strChatScreeLoader = '0';
  //
  var arrShipDepartment = [];
  var strCompanyFirebaseId = '';
  //
  var arrSaveAllDepartmentMembersData = [];
  var arrManagedArray = [];
  //
  var arrSaveTickedData = [];
  var arrNewArray = [];
  //
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print(widget.chatDialogData);
    }

    funcGetLoginUserDetails();
  }

  //
  funcGetLoginUserDetails() {
    //
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

          if (kDebugMode) {
            print('=====> COMPANY FIREBASE ID <=====');
            print(strCompanyFirebaseId);
          }
          //
          setState(() {
            strChatScreeLoader = '1';
          });
          // funcNowGetAllMembersOfDepartmentInThisCompany(strCompanyFirebaseId);
        }
      }
    });
    //
    //
  }

  //
  funcNowGetAllMembersOfDepartmentInThisCompany(companyFirebaseId) {
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}company")
        .doc(companyFirebaseId)
        .collection('department_members')
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
            print('======> DEPARTMENT MEMBERS LIST <======');
            print(element.id);
            // print(element.data());
          }
          //
          arrSaveAllDepartmentMembersData.add(element.data());
        }
        if (kDebugMode) {
          print('======================================');
          print('Fetched all users and loops end');
          print('======================================');
        }
        //
        setState(() {
          strChatScreeLoader = '1';
        });
        // funcNowArrangeUserAccordingToYourself();
      }
    });
    //
    //
  }

  //
  //
  funcNowArrangeUserAccordingToYourself() {
    if (kDebugMode) {
      print('======================================');
      print('======> ALL DEPARTMENT MEMBERS <======');
      print(arrSaveAllDepartmentMembersData);
      print(arrSaveAllDepartmentMembersData.length);
    }
    //

    for (int i = 0; i < arrSaveAllDepartmentMembersData.length; i++) {
      if (arrSaveAllDepartmentMembersData[i]['department_name'].toString() ==
          'IT') {
        //
        var customOperation = {
          //
          /*'name': 'Operation',
          'status': 'no',*/
          'name': arrSaveAllDepartmentMembersData[i]['department_user_name']
              .toString(),
          'email': arrSaveAllDepartmentMembersData[i]['department_user_email']
              .toString(),
          'firebase_id': arrSaveAllDepartmentMembersData[i]
                  ['department_user_firebase_id']
              .toString(),
          'firestore_id':
              arrSaveAllDepartmentMembersData[i]['firestore_id'].toString(),
        };

        arrManagedArray.add(customOperation);
      }
    }
    if (kDebugMode) {
      print(arrManagedArray);
      print(arrManagedArray.length);
    }

    setState(() {
      strChatScreeLoader = '1';
    });
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
                  ],
                ),
              ),
            ) //

          : FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('${strFirebaseMode}company')
                  .doc(strCompanyFirebaseId.toString())
                  .collection('departments')
                  // .where('department_name', isEqualTo: 'Account')
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot2) {
                if (snapshot2.hasData) {
                  // if (kDebugMode) {

                  var saveSnapshotValue2 = snapshot2.data!.docs;
                  //
                  // GET DATA WHEN IMAGE PERMISSION IS NOT EMPTY
                  if (snapshot2.data!.docs.isNotEmpty) {
                    //
                    if (kDebugMode) {
                      print('==============================================');
                      print('HURRAY, YOU HAVE MEMBERS');
                      print(saveSnapshotValue2.length);
                      print('===============================================');
                    }
                    //
                  } else {
                    if (kDebugMode) {
                      print('=========================================');
                      print('OOPS!, YOU DO NOT HAVE ANY MEMBERS');
                      print('=========================================');
                    }
                  }
                  //
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 120,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      //
                                      openGalleryOrCamera(context);
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                          35.0,
                                        ),

                                        // shape: BoxShape.circle,
                                      ),
                                      child: imageFile == null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                0,
                                              ),
                                              child: Image.asset(
                                                'assets/images/group_avatar.png',
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : ClipRRect(
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
                                            ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 70,
                                      // width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                          35.0,
                                        ),
                                      ),
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 0),
                                        color: Colors.transparent,
                                        // height: 60,
                                        // width: MediaQuery.of(context).size.width,
                                        child: Row(
                                          children: [
                                            //
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  controller:
                                                      contTextSendMessage,
                                                  minLines: 1,
                                                  maxLines: 5,
                                                  decoration:
                                                      const InputDecoration(
                                                    // labelText: '',
                                                    hintText: 'Set Chat Title',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //

                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: SizedBox(
                                                height: 40,
                                                width: 40,
                                                child: NeoPopButton(
                                                  color: navigationColor,
                                                  // onTapUp: () => HapticFeedback.vibrate(),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 2,
                                                  ),
                                                  onTapUp: () {
                                                    //
                                                    funcGetDetailsFromSelectedDepartment();
                                                  },
                                                  onTapDown: () =>
                                                      HapticFeedback.vibrate(),
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.send,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),

                                            //
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        // arrNewArray
                        Container(
                          // height: 60,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  for (int i = 0;
                                      i < arrNewArray.length;
                                      i++) ...[
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.amber,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            textWithBoldStyle(
                                              //
                                              arrNewArray[i]['name'],
                                              Colors.black,
                                              18.0,
                                            ),
                                            textWithRegularStyle(
                                              //
                                              arrNewArray[i]['department_name'],
                                              Colors.black,
                                              12.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    //
                                    const SizedBox(
                                      width: 14.0,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                        //
                        expanstionTileUI(context, saveSnapshotValue2),
                      ],
                    ),
                  );
                  /*return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.amber,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.brown,
                          child: expanstionTilesUI(saveSnapshotValue2),
                        ),
                      ],
                    ),
                  );*/
                  //
                } else if (snapshot2.hasError) {
                  if (kDebugMode) {
                    print(snapshot2.error);
                  }
                  return Center(
                    child: Text('Error: ${snapshot2.error}'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
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
                  //
                  str_user_select_image = '1';
                });
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
                  //
                  str_user_select_image = '1';
                });
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

  Expanded expanstionTileUI(BuildContext context,
      List<QueryDocumentSnapshot<Object?>> saveSnapshotValue2) {
    return Expanded(
      // Added
      child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Column(
            children: [
              Expanded(
                // Added
                child: ListView.builder(
                  itemCount: saveSnapshotValue2.length,
                  // prototypeItem: ListTile(
                  //   title: Text('10'),
                  // ),
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: textWithBoldStyle(
                        //
                        saveSnapshotValue2[index]['department_name'].toString(),
                        Colors.black,
                        18.0,
                      ),
                      // subtitle: Text('Leading expansion arrow icon'),
                      // controlAffinity: ListTileControlAffinity.leading,
                      children: <Widget>[
                        for (int j = 0;
                            j <
                                saveSnapshotValue2[index]['members_list']
                                    .length;
                            j++) ...[
                          GestureDetector(
                            onTap: () {
                              //
                              funcManageSelectUnSelectMembers(
                                  saveSnapshotValue2[index], j);
                            },
                            child: ListTile(
                              title: textWithRegularStyle(
                                //
                                saveSnapshotValue2[index]['members_list'][j]
                                        ['department_user_name']
                                    .toString(),
                                Colors.black,
                                14.0,
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int d = 0;
                                      d < arrNewArray.length;
                                      d++) ...[
                                    if (saveSnapshotValue2[index]
                                                    ['members_list'][j]
                                                ['department_user_firebase_id']
                                            .toString() ==
                                        arrNewArray[d]['firebase_id']
                                            .toString()) ...[
                                      const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 20.0,
                                      ),
                                    ]
                                  ],
                                  //
                                  // Icon(
                                  //   Icons.check,
                                  //   color: Colors.green,
                                  // ),
                                  /*Text(saveSnapshotValue2[index]
                                                ['members_list'][j][
                                            'department_user_firebase_id']
                                        .toString())*/
                                  //
                                  /*
                                  for (int d = 0;
                                      d < arrNewArray.length;
                                      d++) ...[
                                    if (arrSaveTickedData[d]['status']
                                            .toString() ==
                                        'yes') ...[
                                      const Icon(
                                        Icons.check,
                                      ),
                                    ]
                                  ]*/
                                ],
                              ),
                            ),
                          ),
                        ]
                      ],
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }

  Column expanstionTilesUI(
      List<QueryDocumentSnapshot<Object?>> saveSnapshotValue2) {
    return Column(
      children: [
        for (int index = 0; index < saveSnapshotValue2.length; index++) ...[
          ExpansionTile(
            title: textWithBoldStyle(
              //
              saveSnapshotValue2[index]['department_name'].toString(),
              Colors.black,
              18.0,
            ),
            // subtitle: Text('Leading expansion arrow icon'),
            // controlAffinity: ListTileControlAffinity.leading,
            children: <Widget>[
              for (int j = 0;
                  j < saveSnapshotValue2[index]['members_list'].length;
                  j++) ...[
                GestureDetector(
                  onTap: () {
                    //
                    funcManageSelectUnSelectMembers(
                        saveSnapshotValue2[index], j);
                  },
                  child: ListTile(
                    title: textWithRegularStyle(
                      //
                      saveSnapshotValue2[index]['members_list'][j]
                              ['department_user_name']
                          .toString(),
                      Colors.black,
                      14.0,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int d = 0; d < arrNewArray.length; d++) ...[
                          if (saveSnapshotValue2[index]['members_list'][j]
                                      ['department_user_firebase_id']
                                  .toString() ==
                              arrNewArray[d]['firebase_id'].toString()) ...[
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 20.0,
                            ),
                          ]
                        ],
                        //
                      ],
                    ),
                  ),
                ),
              ]
            ],
          ),
        ]
      ],
    );
  }

  funcManageSelectUnSelectMembers(snapshotWithIndex, indexJ) {
    //
    if (kDebugMode) {
      print('======== USER SELECT ======');
      print(snapshotWithIndex['members_list'][indexJ]);
      print('============================');
    }
    var custom = {
      'name': snapshotWithIndex['members_list'][indexJ]['department_user_name']
          .toString(),
      'firebase_id': snapshotWithIndex['members_list'][indexJ]
              ['department_user_firebase_id']
          .toString(),
      'member': 'member',
      'department_name': snapshotWithIndex['members_list'][indexJ]
              ['department_name']
          .toString(),
      'status': 'yes',
    };
    //
    // arrSaveTickedData.add(custom);
    arrNewArray.add(custom);

    if (kDebugMode) {
      print('==== SELECTED MEMBERS ====');
      print(arrNewArray);
    }
    setState(() {});
  }

  Column checkUncheckMemberUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int d = 0; d < arrSaveTickedData.length; d++) ...[
          if (arrSaveTickedData[d]['status'].toString() == 'yes') ...[
            const Icon(
              Icons.check,
            ),
          ]
        ]
      ],
    );
  }

  Align writeSomethingUI() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 0),
        color: const Color.fromRGBO(
          246,
          248,
          253,
          1,
        ),
        // height: 60,
        // width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                height: 40,
                width: 40,
                child: NeoPopButton(
                  color: navigationColor,
                  // onTapUp: () => HapticFeedback.vibrate(),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  onTapUp: () {
                    //
                    // openGalleryOrCamera(context);
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
                ),
              ),
            ),
            //
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: contTextSendMessage,
                  minLines: 1,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    // labelText: '',
                    hintText: 'Set Chat Title',
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
                child: NeoPopButton(
                  color: navigationColor,
                  // onTapUp: () => HapticFeedback.vibrate(),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  onTapUp: () {
                    //
                    funcGetDetailsFromSelectedDepartment();

                    //
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
                ),
              ),
            ),

            //
          ],
        ),
      ),
    );
  }

  //
  funcGetDetailsFromSelectedDepartment() {
    //
    if (contTextSendMessage.text.toString() == '') {
      //
      successLoaderUI(context, 'please set chat title name');
    } else if (arrNewArray.isEmpty) {
      //
      successLoaderUI(context, 'please select atleast one member');
    } else {
      //
      startLoadingUI(context, 'please wait...');
      var fetchAllMembersName = [
        FirebaseAuth.instance.currentUser!.displayName
      ];
      var fetchAllMembersFID = [FirebaseAuth.instance.currentUser!.uid];

      for (int i = 0; i < arrNewArray.length; i++) {
        //
        fetchAllMembersName.add(arrNewArray[i]['name'].toString());
        fetchAllMembersFID.add(arrNewArray[i]['firebase_id'].toString());
      }

      //
      if (str_user_select_image == '0') {
        //
        funcAddAndCreateDialog(
          fetchAllMembersFID,
          fetchAllMembersName,
          '',
        );
      } else {
        //
        uploadImageToFirebase(
          context,
          fetchAllMembersFID,
          fetchAllMembersName,
        );
      }
    }
  }

  /// **************************************************************************
  /// **************************************************************************
  // upload image via firebase
  /// **************************************************************************
  /// **************************************************************************
  Future uploadImageToFirebase(
    BuildContext context,
    getFetchMemberFID,
    getfetchAllMembersName,
  ) async {
    // String fileName = basename(imageFile_for_profile!.path);
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child(
          'dialog_display/${FirebaseAuth.instance.currentUser!.uid}',
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

          funcAddAndCreateDialog(
            getFetchMemberFID,
            getfetchAllMembersName,
            value.toString(),
          ),
        });
  }

  /// **************************************************************************
  /// **************************************************************************
  // CREATE DIALOG
  /// **************************************************************************
  /// **************************************************************************
  funcAddAndCreateDialog(
    allFirebaseIds,
    allNames,
    attachmentPath,
  ) {
    ////////////////////////////////
    // ADD ME AS A ADMIN
    ////////////////////////////////
    var custom = {
      'name': FirebaseAuth.instance.currentUser!.displayName.toString(),
      'firebase_id': FirebaseAuth.instance.currentUser!.uid.toString(),
      'member': 'admin',
      'status': 'yes',
    };
    arrNewArray.insert(0, custom);
    ////////////////////////////////
    ////////////////////////////////
    CollectionReference users = FirebaseFirestore.instance.collection(
        '${strFirebaseMode}company/${strCompanyFirebaseId.toString()}/dialog');

    users
        .add(
          {
            'attachment_path': attachmentPath.toString(),
            'sender_image': '',
            'sender_name': FirebaseAuth.instance.currentUser!.displayName,
            'sender_firebase_id': FirebaseAuth.instance.currentUser!.uid,
            'message': '',
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'room': 'group',
            'type': 'text',
            //
            'room_id': generateRandomString(10).toString(),
            //
            'department_name': ''.toString(),
            //
            'chat_title': contTextSendMessage.text.toString(),
            'chat_members_firebase_id': allFirebaseIds,
            'chat_members_name': allNames,
            //
            'full_fetched_data': arrNewArray,
            //
            'last_message': '',
            'last_message_user_name': '', 'last_message_status': '0',
          },
        )
        .then(
          (value) =>
              //

              funcEditFirestoreIdInRegistration(value.id),
          //
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  /// **************************************************************************
  /// **************************************************************************
  // GENERATE RANDOM STRINGS
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

  // merge firestore id to add ship
  funcEditFirestoreIdInRegistration(elementId) {
    FirebaseFirestore.instance
        .collection('${strFirebaseMode}company')
        .doc(strCompanyFirebaseId.toString())
        .collection('dialog')
        .doc(elementId)
        .set(
      {
        'firestore_id': elementId,
      },
      SetOptions(merge: true),
    ).then(
      (value) {
        if (kDebugMode) {
          print('value 1.0');
        }
        //
        Navigator.pop(context);
        Navigator.pop(context);
        //
      },
    );
  }
}
