// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utils/utils.dart';

class NewShipAddMembers extends StatefulWidget {
  const NewShipAddMembers(
      {super.key,
      this.getMainCompanyFullData,
      this.getShipData,
      required this.strMemberType});

  final getShipData;
  final getMainCompanyFullData;
  final String strMemberType;

  @override
  State<NewShipAddMembers> createState() => _NewShipAddMembersState();
}

class _NewShipAddMembersState extends State<NewShipAddMembers> {
  //
  final formKey = GlobalKey<FormState>();

  late final TextEditingController contName;
  late final TextEditingController contEmail;
  late final TextEditingController contPassword;
  late final TextEditingController contMainPassword;
  //
  var strSaveMainCompanyEmail = '';
  var strSaveCompanyFirebaseId = '';
  var strSaveCompanyName = '';
  var strCompanyId = '';
  //
  @override
  void initState() {
    super.initState();
    //

    //
    strSaveMainCompanyEmail =
        FirebaseAuth.instance.currentUser!.email.toString();
    strSaveCompanyFirebaseId =
        FirebaseAuth.instance.currentUser!.uid.toString();
    strSaveCompanyName =
        FirebaseAuth.instance.currentUser!.displayName.toString();
    strCompanyId = widget.getMainCompanyFullData['company_id'].toString();
    //
    if (kDebugMode) {
      print('======================================');
      print('============= FULL DATA ==============');
      print(widget.getShipData);
      print(strSaveCompanyFirebaseId);
      print(strSaveCompanyName);
      print(strCompanyId);
    }
    contName = TextEditingController();
    contEmail = TextEditingController();
    contPassword = TextEditingController();
    contMainPassword = TextEditingController();
  }

  @override
  void dispose() {
    //
    contName.dispose();
    contEmail.dispose();
    contPassword.dispose();
    contMainPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithRegularStyle(
          'Assign',
          Colors.white,
          18.0,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: navigationColor,
        leading: IconButton(
          onPressed: () {
            //
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 32.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              /* ******************************** */
              /* ******************************** */
              /* member name */
              /* ******************************** */
              /* ******************************** */

              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: textWithRegularStyle(
                  'Name',
                  Colors.black,
                  14.0,
                ),
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: contName,
                  readOnly: false,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Name',
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 14,
                      // fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              /* ******************************** */
              /* ******************************** */
              /* member email */
              /* ******************************** */
              /* ******************************** */

              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: textWithRegularStyle(
                  'Email',
                  Colors.black,
                  14.0,
                ),
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: contEmail,
                  readOnly: false,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 14,
                      // fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              /* ******************************** */
              /* ******************************** */
              /* member password */
              /* ******************************** */
              /* ******************************** */

              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: textWithRegularStyle(
                  'Password',
                  Colors.black,
                  14.0,
                ),
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: contPassword,
                  readOnly: false,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 14,
                      // fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              //
              /* ******************************** */
              /* ******************************** */
              /* main - company password */
              //
              const SizedBox(
                height: 40,
              ),
              //
              Align(
                alignment: Alignment.topLeft,
                child: textWithBoldStyle(
                  'Your Password ( security purpose )',
                  Colors.black,
                  14.0,
                ),
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: TextFormField(
                  obscureText: true,
                  readOnly: false,
                  controller: contMainPassword,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Your password',
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 12,
                      // fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Your password';
                    }
                    return null;
                  },
                ),
              ),
              //
              //
              const SizedBox(
                height: 20,
              ),
              //
              GestureDetector(
                onTap: () {
                  //
                  if (formKey.currentState!.validate()) {
                    //
                    checkLoginMainCompanyDataIsCorrectOrNot();
                    //
                  }
                  //
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: navigationColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: textWithBoldStyle(
                      'Add',
                      Colors.black,
                      16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  ///
  ///
  //
  checkLoginMainCompanyDataIsCorrectOrNot() async {
    //
    startLoadingUI(context, 'please wait...');
    //
    try {
      UserCredential customUserCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: strSaveMainCompanyEmail.toString(),
              password: contMainPassword.text);
      // return customUserCredential.user!.uid;
      if (kDebugMode) {
        print(customUserCredential);
      }
      //
      // print('done done ');
      funcCreateAccountOfShipMemberInXMPP();

      //
      //

      //
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
        print(e.message);
      }
      //
      customException(e.message);
    } catch (e) {
      if (kDebugMode) {
        print(e);
        // print(e);
      }
      //
      customException(e);
      //
    }
  }

  //
  //
  funcCreateAccountOfShipMemberInXMPP() async {
    //
    // startLoadingUI(context, 'please wait...');
    //
    try {
      UserCredential customUserCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: contEmail.text, password: contPassword.text);

      successCreateAccount(customUserCredential.user!.uid);

      return customUserCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
        print(e.message);
      }

      customException(e.message);
    } catch (e) {
      if (kDebugMode) {
        print(e);
        // print(e);
      }
      customException(e);
    }
  }

  //
  //
  successCreateAccount(userDetails) async {
    if (kDebugMode) {
      print('======= CREATED USER FID ===========');
      print(userDetails);
      print('=================================================');
    }
    //

    FirebaseAuth.instance.currentUser!
        // .updateDisplayName(encrypted.base64.toString())
        .updateDisplayName(contName.text)
        .then((value) => {
              // create user in DB

              funcAftercreateAddThatUserInFirestoreDB(userDetails)
            });
    //
  }

  funcAftercreateAddThatUserInFirestoreDB(firebaseId) {
    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}company/${widget.getMainCompanyFullData['company_firebase_id'].toString()}/ship_members',
    );

    users
        .add(
          {
            'company_id':
                widget.getMainCompanyFullData['company_id'].toString(),
            'company_firebase_id':
                widget.getMainCompanyFullData['company_firebase_id'].toString(),
            'company_name':
                widget.getMainCompanyFullData['company_name'].toString(),
            //
            'member_name': contName.text.toString(),

            'member_email': contEmail.text.toString(),
            'member_password': contPassword.text.toString(),
            'member_firebase_id': firebaseId.toString(),
            'member': get18DigitNumber(),
            //
            'active': 'no',
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'type': 'department',
            'device_token': ''
          },
        )
        .then((value) => {
              // print(value.id),
              funcEditFirestoreId(
                value.id,
                firebaseId.toString(),
              ),
            })
        .catchError((error) => {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: navigationColor,
                  content: textWithBoldStyle(
                    //
                    'Failed to add. Please try again after sometime.'
                        .toString(),
                    //
                    Colors.white,
                    14.0,
                  ),
                ),
              ),
            });
  }

  funcEditFirestoreId(elementId, getFirebaseId) {
    FirebaseFirestore.instance
        .collection('${strFirebaseMode}company')
        .doc(widget.getMainCompanyFullData['company_firebase_id'].toString())
        .collection('ship_members')
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
        funcUpdateNameInShipList(getFirebaseId);
        //
      },
    );
  }

//
  funcUpdateNameInShipList(firebaseId) {
    if (widget.strMemberType == 'ce') {
      FirebaseFirestore.instance
          .collection('${strFirebaseMode}company')
          .doc(widget.getShipData['company_firebase_id'].toString())
          .collection('ships')
          .doc(widget.getShipData['firestore_id'].toString())
          .set(
        {
          'ship_ce_name': contName.text.toString(),
          'ship_ce_firebase_id': firebaseId.toString()
        },
        SetOptions(merge: true),
      ).then(
        (value) {
          if (kDebugMode) {
            print('value 1.0');
          }
          //

          funcSaveUserInRegistration('ce');
          //
        },
      );
    } else {
      FirebaseFirestore.instance
          .collection('${strFirebaseMode}company')
          .doc(widget.getShipData['company_firebase_id'].toString())
          .collection('ships')
          .doc(widget.getShipData['firestore_id'].toString())
          .set(
        {
          'ship_captain_name': contName.text.toString(),
          'ship_captain_firebase_id': firebaseId.toString()
        },
        SetOptions(merge: true),
      ).then(
        (value) {
          if (kDebugMode) {
            print('value 1.0');
          }
          //
          funcSaveUserInRegistration('captain');

          //
        },
      );
    }
  }

  funcSaveUserInRegistration(category) {
    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}registrations',
    );

    users
        .add(
          {
            'company_firebase_id': strSaveCompanyFirebaseId.toString(),
            'company_name': strSaveCompanyName.toString(),
            'company_email': strSaveMainCompanyEmail.toString(),
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'company_id': strCompanyId.toString(),
            'active': 'no',
            //
            'member_firebase_id': FirebaseAuth.instance.currentUser!.uid,
            'member_name': contName.text.toString(),
            'member_email': contEmail.text.toString(),
            // 'type': 'admin'
            'member_category': category.toString(),
            'type': 'ship_member'
          },
        )
        .then((value) => {
              //print(value.id),
              funcLogoutCurrentUserAndLogin(),
            })
        .catchError((error) => {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: navigationColor,
                  content: textWithBoldStyle(
                    //
                    'Failed to add. Please try again after sometime.'
                        .toString(),
                    //
                    Colors.white,
                    14.0,
                  ),
                ),
              ),
            });
  }

  //
  //
  funcLogoutCurrentUserAndLogin() async {
    //
    FirebaseAuth.instance.signOut();
    //
    try {
      UserCredential customUserCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: strSaveMainCompanyEmail.toString(),
              password: contMainPassword.text);
      // return customUserCredential.user!.uid;
      if (kDebugMode) {
        print(customUserCredential);
      }
      //

      funcSuccessMessageAfterCompleteAllRegistrationInXMPP();
      //

      //
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
        print(e.message);
      }

      customException(e.message);
    } catch (e) {
      if (kDebugMode) {
        print(e);
        // print(e);
      }
      //
      customException(e);
    }
  }

  //
  funcSuccessMessageAfterCompleteAllRegistrationInXMPP() {
    //
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    //
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.lightBlueAccent,
        content: textWithBoldStyle(
          //
          'Successfully Created'.toString(),
          //
          Colors.white,
          14.0,
        ),
      ),
    );
  }

  //
  // custom
  //
  customException(errorMessageIs) {
    //
    Navigator.pop(context);
    //
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: navigationColor,
        content: textWithBoldStyle(
          //
          errorMessageIs.toString(),
          //
          Colors.white,
          14.0,
        ),
      ),
    );
  }
}
