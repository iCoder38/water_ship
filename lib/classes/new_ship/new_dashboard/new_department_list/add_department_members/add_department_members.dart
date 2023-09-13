// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_ship/classes/Utils/utils.dart';

class AddDepartmentMembersScreen extends StatefulWidget {
  const AddDepartmentMembersScreen({
    super.key,
    this.getMainCompanyDetailsInAddMembers,
    this.getDepartmentDetailsInAddMembers,
  });

  final getMainCompanyDetailsInAddMembers;
  final getDepartmentDetailsInAddMembers;

  @override
  State<AddDepartmentMembersScreen> createState() =>
      _AddDepartmentMembersScreenState();
}

class _AddDepartmentMembersScreenState
    extends State<AddDepartmentMembersScreen> {
  //
  final formKey = GlobalKey<FormState>();

  late final TextEditingController txtMemberName;
  late final TextEditingController txtMemberEmail;
  late final TextEditingController txtMemberPassword;
  //
  // for password
  late final TextEditingController txtCompanyPassword;
  //
  //
  var strSaveMainCompanyEmail = '';
  var strSaveCompanyFirebaseId = '';
  var strSaveCompanyName = '';
  var strCompanyId = '';
  var strSaveNewRegisteredId = '';
  //
  @override
  void initState() {
    if (kDebugMode) {
      print('=========== MAIN COMPANY ====================');
      print(widget.getMainCompanyDetailsInAddMembers);
      print('=========== DEPARTMENT COMPANY ==============');
      print(widget.getDepartmentDetailsInAddMembers);
    }
    //
    txtMemberName = TextEditingController();
    txtMemberEmail = TextEditingController();
    txtMemberPassword = TextEditingController();
    txtCompanyPassword = TextEditingController();
    //
    //
    // SAVE COMPANY EMAIL
    strSaveMainCompanyEmail =
        FirebaseAuth.instance.currentUser!.email.toString();
    strSaveCompanyFirebaseId =
        FirebaseAuth.instance.currentUser!.uid.toString();
    strSaveCompanyName =
        FirebaseAuth.instance.currentUser!.displayName.toString();
    strCompanyId =
        widget.getMainCompanyDetailsInAddMembers['company_id'].toString();

    super.initState();
  }

  @override
  void dispose() {
    //
    txtMemberName.dispose();
    txtMemberEmail.dispose();
    txtMemberPassword.dispose();
    txtCompanyPassword.dispose();
    //

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: AppBar(
        title: textWithRegularStyle(
          //
          widget.getDepartmentDetailsInAddMembers['department_name'].toString(),
          //
          Colors.black,
          16.0,
        ),
        backgroundColor: navigationColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                /* ******************************** */
                /* ******************************** */
                /* department name */
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
                    controller: txtMemberName,
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
                /* department email */
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
                    controller: txtMemberEmail,
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
                /* department password */
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
                    controller: txtMemberPassword,
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
                    controller: txtCompanyPassword,
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
                //
                //
                //
                const SizedBox(
                  height: 20,
                ),
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
                        'Add in ( ${widget.getDepartmentDetailsInAddMembers['department_name'].toString()}) ',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //
//
  checkLoginMainCompanyDataIsCorrectOrNot() async {
    //
    startLoadingUI(context, 'please wait...');
    //
    try {
      UserCredential customUserCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: strSaveMainCompanyEmail.toString(),
              password: txtCompanyPassword.text);
      // return customUserCredential.user!.uid;
      if (kDebugMode) {
        print(customUserCredential);
      }
      //
      // print('done done ');
      funcCreateDepartmentAccountAfterCheckingMainCompanyLogin();

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
  funcCreateDepartmentAccountAfterCheckingMainCompanyLogin() async {
    //
    try {
      UserCredential customUserCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: txtMemberEmail.text, password: txtMemberPassword.text);

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
      print(
          '============ DONE CHECKING, UPDATE DEPARTMENT NAME ================');
      print(userDetails);
      print('=================================================');
    }
    //
    strSaveNewRegisteredId = userDetails.toString();
    //

    FirebaseAuth.instance.currentUser!
        // .updateDisplayName(encrypted.base64.toString())
        .updateDisplayName(txtMemberName.text)
        .then((value) => {
              // create user in DB

              funcCreateUserNowInXMPP(userDetails)
            });
    //
  }

  //
  //
  funcCreateUserNowInXMPP(firebaseId) {
    if (kDebugMode) {
      print(
          '============ DONE UPDATE NAME, ADD DEPARTMENT TO XMPP ================');
      print(firebaseId);
      print(
          '===================================================================');
    }
    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}company/${widget.getMainCompanyDetailsInAddMembers['company_firebase_id'].toString()}/department_members',
    );

    users
        .add(
          {
            'company_id': widget.getMainCompanyDetailsInAddMembers['company_id']
                .toString(),
            'company_firebase_id': widget
                .getMainCompanyDetailsInAddMembers['company_firebase_id']
                .toString(),
            'company_name': widget
                .getMainCompanyDetailsInAddMembers['company_name']
                .toString(),
            //
            'department_name': widget
                .getDepartmentDetailsInAddMembers['department_name']
                .toString(),
            'department_user_name': txtMemberName.text.toString(),
            'department_user_email': txtMemberEmail.text.toString(),
            'department_user_firebase_id': firebaseId.toString(),
            'department_id': get18DigitNumber(),
            //
            'active': 'no',
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'type': 'department',
            'device_token': ''
          },
        )
        .then((value) => {
              // print(value.id),
              funcEditFirestoreIdInRegistration(value.id),
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
  //
  funcEditFirestoreIdInRegistration(elementId) {
    FirebaseFirestore.instance
        .collection('${strFirebaseMode}company')
        .doc(widget.getMainCompanyDetailsInAddMembers['company_firebase_id']
            .toString())
        .collection('department_members')
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
        funcGetDepartmentDetailsToIncreaseMemberCount();
        //
      },
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

  //
  //
  //
  funcGetDepartmentDetailsToIncreaseMemberCount() {
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}company")
        .doc(widget.getMainCompanyDetailsInAddMembers['company_firebase_id']
            .toString())
        .collection("departments")
        .where("department_name",
            isEqualTo: widget
                .getDepartmentDetailsInAddMembers['department_name']
                .toString())
        .where("company_firebase_id",
            isEqualTo: widget
                .getMainCompanyDetailsInAddMembers['company_firebase_id']
                .toString())
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND');
        }
        //
        //
        Navigator.pop(context);
        //
      } else {
        for (var element in value.docs) {
          if (kDebugMode) {
            print('======> YES,  USER FOUND');
          }
          if (kDebugMode) {
            print(element.id);
            print(element.data()['members']);
            // print(element.id.runtimeType);
            print('================ CHECK AGAIN ===============');
          }
          var addOneInTotalMembers;

          addOneInTotalMembers = element.data()['members'].toString();
          //
          // print(int.parse(addOneInTotalMembers + 1));
          //

          FirebaseFirestore.instance
              .collection('${strFirebaseMode}company')
              .doc(widget
                  .getMainCompanyDetailsInAddMembers['company_firebase_id']
                  .toString())
              .collection('departments')
              .doc(element.id.toString())
              .set(
            {
              'members': int.parse(addOneInTotalMembers) + 1,
              'members_list': FieldValue.arrayUnion([
                {
                  'company_id': widget
                      .getMainCompanyDetailsInAddMembers['company_id']
                      .toString(),
                  'company_firebase_id': widget
                      .getMainCompanyDetailsInAddMembers['company_firebase_id']
                      .toString(),
                  'company_name': widget
                      .getMainCompanyDetailsInAddMembers['company_name']
                      .toString(),
                  //
                  'department_name': widget
                      .getDepartmentDetailsInAddMembers['department_name']
                      .toString(),
                  'department_user_name': txtMemberName.text.toString(),
                  'department_user_email': txtMemberEmail.text.toString(),
                  'department_user_firebase_id':
                      strSaveNewRegisteredId.toString(),
                  'department_id': get18DigitNumber(),
                  //
                  'active': 'no',
                  'time_stamp': DateTime.now().millisecondsSinceEpoch,
                  'type': 'department',
                  'device_token': ''
                }
              ])
            },
            SetOptions(merge: true),
          ).then(
            (value) {
              if (kDebugMode) {
                print('======');
                print(
                    '==========> DONE ALL AND NOW LOGOUT AND LOGIN MAIN COMPANY <==========');
              }
              //

              //
            },
          );
          funcSaveUserInRegistration('department');
          //
        }
      }
    });
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
            'member_name': txtMemberName.text.toString(),
            'member_email': txtMemberEmail.text.toString(),
            // 'type': 'admin'
            'member_category': category.toString(),
            'type': 'ship_department'
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
              password: txtCompanyPassword.text);
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
  //
}
