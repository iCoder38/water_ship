// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:water_ship/classes/Utils/utils.dart';

class AddSubCompanyScreen extends StatefulWidget {
  const AddSubCompanyScreen(
      {super.key, this.getMainCompantData, required this.strSubCompanyName});

  final getMainCompantData;
  final String strSubCompanyName;

  @override
  State<AddSubCompanyScreen> createState() => _AddSubCompanyScreenState();
}

class _AddSubCompanyScreenState extends State<AddSubCompanyScreen> {
  //
  final formKey = GlobalKey<FormState>();
  late final TextEditingController txtMainCompanyName;
  late final TextEditingController txtMainCompanyId;
  late final TextEditingController txtSubCompanyName;
  late final TextEditingController txtSubCompanyRegisteredEmailAddress;
  late final TextEditingController txtSubCompanyPassword;
  late final TextEditingController txtTotalSubCompaniesCategory;
  // for password
  late final TextEditingController txtCompanyPassword;
  //
  //
  var strSaveMainCompanyEmail = '';

  var generateRandom16Digits = '0';
  //
  @override
  void initState() {
    //
    txtMainCompanyName = TextEditingController(
        text: widget.getMainCompantData['company_name'].toString());
    txtMainCompanyId = TextEditingController(
        text: widget.getMainCompantData['company_id'].toString());
    txtSubCompanyName = TextEditingController();
    txtSubCompanyRegisteredEmailAddress = TextEditingController();
    txtSubCompanyPassword = TextEditingController();
    txtTotalSubCompaniesCategory =
        TextEditingController(text: widget.strSubCompanyName.toString());
    txtCompanyPassword = TextEditingController();
    //
    if (kDebugMode) {
      print('<========= MAIN DATA ==========>');
      print(widget.getMainCompantData);
      print(widget.strSubCompanyName.toString());
      print('<==============================>');
    }
    //
    // SAVE COMPANY EMAIL
    strSaveMainCompanyEmail =
        widget.getMainCompantData['company_email'].toString();

    //
    super.initState();
  }

  @override
  void dispose() {
    //
    txtMainCompanyName.dispose();
    txtMainCompanyId.dispose();
    txtSubCompanyName.dispose();
    txtSubCompanyRegisteredEmailAddress.dispose();
    txtSubCompanyPassword.dispose();
    txtTotalSubCompaniesCategory.dispose();
    txtCompanyPassword.dispose();
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithRegularStyle(
          'Add Sub Company',
          Colors.black,
          18.0,
        ),
        backgroundColor: navigationColor,
      ),
      //
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                //
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Company Name',
                    Colors.black,
                    14.0,
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 218, 216, 216),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: txtMainCompanyName,
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Company Name',
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
                /* company id */
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Company Id',
                    Colors.black,
                    14.0,
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 218, 216, 216),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: txtMainCompanyId,
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Company Id',
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
                /* sub - company name */
                //
                const SizedBox(
                  height: 10,
                ),
                //
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Sub Company Name',
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
                    controller: txtSubCompanyName,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Sub - Company Name',
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 12,
                        // fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Sub-Company Name';
                      }
                      return null;
                    },
                  ),
                ), //
                /* ******************************** */
                /* ******************************** */
                /* sub - company email */
                //
                const SizedBox(
                  height: 10,
                ),
                //
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Sub Company Email',
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
                    controller: txtSubCompanyRegisteredEmailAddress,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Sub - Company Email',
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 12,
                        // fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Sub-Company Email';
                      }
                      return null;
                    },
                  ),
                ),
                /* ******************************** */
                /* ******************************** */
                /* sub - company password */
                //
                const SizedBox(
                  height: 10,
                ),
                //
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Set Password',
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
                    controller: txtSubCompanyPassword,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Sub - Company Password',
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 12,
                        // fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Sub-Company Password';
                      }
                      return null;
                    },
                  ),
                ),
                /* ******************************** */
                /* ******************************** */
                /* sub - company category */
                //
                const SizedBox(
                  height: 10,
                ),
                //
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Sub Company Category',
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
                    readOnly: true,
                    controller: txtTotalSubCompaniesCategory,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Sub - Company Category',
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 12,
                        // fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      // suffixIcon: const Icon(
                      //   Icons.arrow_drop_down,
                      // ),
                    ),
                    // onTap: () {
                    //   if (kDebugMode) {
                    //     print("I'm here!!!");
                    //   }
                    //   //
                    //   funcOpenSubCompanyCategoryCount();
                    //   //
                    // },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Sub-Company Category';
                      }
                      return null;
                    },
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
                        'Create',
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
      ),
    );
  }

  //
  //
  funcOpenSubCompanyCategoryCount() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Total number of Sub Companies'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              //
              txtTotalSubCompaniesCategory.text = 'Ships'.toString();
              //
            },
            child: textWithRegularStyle(
              'Ships',
              Colors.black,
              14.0,
            ),
          ),
          /*CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              txtTotalSubCompaniesCategory.text = 'Departments'.toString();
              //
            },
            child: textWithRegularStyle(
              'Departments',
              Colors.black,
              14.0,
            ),
          ),*/
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: textWithRegularStyle(
              'Dismiss',
              Colors.redAccent,
              16.0,
            ),
          ),
        ],
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
      funcCreateIdForSubCompany();
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
  funcCreateIdForSubCompany() async {
    //

    //
    try {
      UserCredential customUserCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: txtSubCompanyRegisteredEmailAddress.text.toString(),
              password: txtSubCompanyPassword.text.toString());

      funcAddSubCompany(customUserCredential.user!.uid);

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
    }
  }

  //
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
  funcAddSubCompany(
    getSubCompanyFirebaseId,
  ) {
    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}sub_company/${widget.getMainCompantData['company_firebase_id'].toString()}/sub_companies',
    );

    generateRandom16Digits = get20DigitNumber();
    users
        .add(
          {
            'main_company_name':
                widget.getMainCompantData['company_name'].toString(),
            'main_company_id':
                widget.getMainCompantData['company_id'].toString(),
            'main_company_firebase_id':
                widget.getMainCompantData['company_firebase_id'].toString(),
            'sub_company_name': txtSubCompanyName.text.toString(),
            'sub_company_firebase_id': getSubCompanyFirebaseId.toString(),
            'sub_company_id': generateRandom16Digits,
            'sub_company_email':
                txtSubCompanyRegisteredEmailAddress.text.toString(),
            'sub_company_password': txtSubCompanyPassword.text.toString(),
            'sub_company_category':
                txtTotalSubCompaniesCategory.text.toString(),
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'active': 'no',
            'type': 'sub_company'
          },
        )
        .then((value) => {
              // print(value.id),
              funcEditFirestoreIdInRegistration(value.id),
            })
        .catchError((error) => {
              //
              Navigator.pop(context),
              //
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
  // register firestore id in sub company
  funcEditFirestoreIdInRegistration(elementId) {
    FirebaseFirestore.instance
        .collection('${strFirebaseMode}sub_company')
        // .doc('India')
        // .collection('details')
        .doc(widget.getMainCompantData['company_firebase_id'].toString())
        .collection('sub_companies')
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
        // print('DONE CREATE SUB COMPANY');
        funcAddThisSubCompanyToMainCompany(elementId);
        //
      },
    );
  }

  //
  // add this sub company to their main company
  funcAddThisSubCompanyToMainCompany(
    getSubCompanyFirestoreId,
  ) {
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}main_company")
        .doc('India')
        .collection('details')
        .doc(widget.getMainCompantData['firestore_id'].toString())
        .set(
      {
        'sub_company_firestore_id': FieldValue.arrayUnion([
          getSubCompanyFirestoreId,
        ]),
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        //
        funcLogoutCurrentUserAndLogin();
        //
      },
    );
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
      Navigator.pop(context);
      Navigator.pop(context);
      //
      successLoaderUI(context, 'successfully registered');
      //
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
    }
  }
}
