import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:water_ship/classes/Utils/utils.dart';

class SignUpMainCompanyScreen extends StatefulWidget {
  const SignUpMainCompanyScreen({super.key});

  @override
  State<SignUpMainCompanyScreen> createState() =>
      _SignUpMainCompanyScreenState();
}

class _SignUpMainCompanyScreenState extends State<SignUpMainCompanyScreen> {
  //
  final formKey = GlobalKey<FormState>();
  late final TextEditingController txtCompanyName;
  late final TextEditingController txtCompanyRegisteredEmailAddress;
  late final TextEditingController txtCompanyPassword;
  late final TextEditingController txtCompanyRePassword;
  late final TextEditingController txtTotalSubCompanies;
  //
  @override
  void initState() {
    //
    txtCompanyName = TextEditingController();
    txtCompanyRegisteredEmailAddress = TextEditingController();
    txtCompanyPassword = TextEditingController();
    txtCompanyRePassword = TextEditingController();
    txtTotalSubCompanies = TextEditingController();
    //
    super.initState();
  }

  @override
  void dispose() {
    //
    txtCompanyName.dispose();
    txtCompanyRegisteredEmailAddress.dispose();
    txtCompanyPassword.dispose();
    txtCompanyRePassword.dispose();
    txtTotalSubCompanies.dispose();
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithBoldStyle(
          'Create your Company',
          Colors.black,
          18.0,
        ),
        leading: SizedBox(
          height: 40,
          width: 40,
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
                Navigator.pop(context);
              },
              onTapDown: () => HapticFeedback.vibrate(),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
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
                    controller: txtCompanyName,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),
                ),
                //
                const SizedBox(
                  height: 10,
                ),
                /* ******************************** */
                /* company email */
                //
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
                    controller: txtCompanyRegisteredEmailAddress,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Company Email',
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 14,
                        // fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Registered Email';
                      }
                      return null;
                    },
                  ),
                ), //
                const SizedBox(
                  height: 10,
                ),
                /* ******************************** */
                /* ******************************** */
                /* company password */
                //
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
                    controller: txtCompanyPassword,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                ), //
                const SizedBox(
                  height: 10,
                ),
                /* ******************************** */
                /* ******************************** */
                /* company confirm */
                //
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Confirm Password',
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
                    controller: txtCompanyRePassword,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Confirm Password',
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 14,
                        // fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Confirm Password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                /* ******************************** */
                /* ******************************** */
                /* company sub companies */
                //
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Total Sub Companies',
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
                    controller: txtTotalSubCompanies,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Sub Company',
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 14,
                        // fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down,
                      ),
                    ),
                    onTap: () {
                      if (kDebugMode) {
                        print("I'm here!!!");
                      }
                      //
                      funcOpenCompanyCount();
                      //
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Sub Companies';
                      }
                      return null;
                    },
                  ),
                ),
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
                      funcSignUpAccount();
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
  funcOpenCompanyCount() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Total number of Sub Companies'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          for (int i = 1; i < 11; i++) ...[
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);

                //
                txtTotalSubCompanies.text = i.toString();
              },
              child: textWithRegularStyle(
                i,
                Colors.black,
                14.0,
              ),
            ),
          ],
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: textWithRegularStyle(
              'Dismiss',
              Colors.black,
              16.0,
            ),
          ),
        ],
      ),
    );
  }

  //
  //
  //
  //
  funcSignUpAccount() async {
    startLoadingUI(context, 'please wait...');
    try {
      UserCredential customUserCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: txtCompanyRegisteredEmailAddress.text,
              password: txtCompanyPassword.text);

      successCreateAccount(customUserCredential);

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

  successCreateAccount(userDetails) async {
    if (kDebugMode) {
      print('============ USER ACCOUNT DETAILS================');
      print(userDetails);
      print('=================================================');
    }
    //

    FirebaseAuth.instance.currentUser!
        // .updateDisplayName(encrypted.base64.toString())
        .updateDisplayName(txtCompanyName.text)
        .then((value) => {
              // create user in DB
              funcCreateMainCompany(),
            });
    //
  }

  funcCreateMainCompany() {
    if (kDebugMode) {
      print(get20DigitNumber());
    }

    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}registrations',
    );

    users
        .add(
          {
            'company_firebase_id': FirebaseAuth.instance.currentUser!.uid,
            'company_name': FirebaseAuth.instance.currentUser!.displayName,
            'company_email': FirebaseAuth.instance.currentUser!.email,
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'company_id': get20DigitNumber(),
            'active': 'no',
            'total_sub_companies': txtTotalSubCompanies.text.toString(),
            // 'type': 'admin'
            'type': 'company'
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

  funcEditFirestoreIdInRegistration(elementId) {
    FirebaseFirestore.instance
        .collection('${strFirebaseMode}registrations')
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
        funcSuccessMessageAfterCompleteAllRegistrationInXMPP();
        //
      },
    );
  }

//
//
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
}
