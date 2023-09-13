// ignore_for_file: prefer_typing_uninitialized_variables, invalid_return_type_for_catch_error, avoid_print

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

import '../../../Utils/utils.dart';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

class AddShipScreen extends StatefulWidget {
  const AddShipScreen({super.key, this.getFullData});

  final getFullData;
  // final getSubShipDataToAddShip;

  @override
  State<AddShipScreen> createState() => _AddShipScreenState();
}

class _AddShipScreenState extends State<AddShipScreen> {
  //
  final formKey = GlobalKey<FormState>();

  late final TextEditingController constMainCompanyName;
  late final TextEditingController constSubCompanyName;

  late final TextEditingController constShipVesselName;
  late final TextEditingController constShipId;

  late final TextEditingController constShipBuildDate;
  late final TextEditingController constShipExpYear;

  late final TextEditingController constShipTcOwn;

  late final TextEditingController constShipDWT;
  //
  late final TextEditingController contShipImoNumber;
  late final TextEditingController contShipType;
  late final TextEditingController contShipSize;
  late final TextEditingController contShipClass;
  late final TextEditingController contShipFlag;

  late final TextEditingController contShipLadenBallast;

  final random = Random();
  //
  var strShipId = '0';
  //
  var arrShipDepartment = [
    'Operation',
    'Technical',
    'HESQ',
    'Crew Manning',
    'IT',
    'Purchase',
    'Account',
    'Owner Technical Group',
  ];
  //
  @override
  void initState() {
    //
    if (kDebugMode) {
      print('======================================');
      print('============= FULL DATA ==============');
      print(widget.getFullData);
    }
    //

    constMainCompanyName = TextEditingController(
        text: widget.getFullData['company_name'].toString());
    constSubCompanyName = TextEditingController(
        text: widget.getFullData['sub_company_name'].toString());

    constShipVesselName = TextEditingController();

    strShipId = get16DigitNumber();
    constShipId = TextEditingController(text: strShipId.toString());

    constShipBuildDate = TextEditingController();
    constShipExpYear = TextEditingController();

    constShipTcOwn = TextEditingController();

    constShipDWT = TextEditingController();

    contShipImoNumber = TextEditingController();
    contShipType = TextEditingController();
    contShipSize = TextEditingController();
    contShipClass = TextEditingController();
    contShipFlag = TextEditingController();

    contShipLadenBallast = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    //
    constMainCompanyName.dispose();
    constSubCompanyName.dispose();

    constShipVesselName.dispose();
    constShipId.dispose();
    constShipBuildDate.dispose();
    constShipExpYear.dispose();
    constShipTcOwn.dispose();
    constShipDWT.dispose();
    contShipType.dispose();
    contShipSize.dispose();
    contShipClass.dispose();
    contShipFlag.dispose();
    contShipLadenBallast.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithRegularStyle(
          'Add ship',
          Colors.white,
          18.0,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: navigationColor,
        leading: SizedBox(
          height: 40,
          width: 120,
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
                Navigator.pop(context);
                //
              },
              onTapDown: () => HapticFeedback.vibrate(),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              children: [
                //
                /* ******************************** */
                /* ******************************** */
                /* company name */
                /* ******************************** */
                /* ******************************** */
                //
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    ' Company Name',
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
                    controller: constMainCompanyName,
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: ' Company Name',
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter  Company Name';
                      }
                      return null;
                    },
                  ),
                ),
                /* ******************************** */
                /* ******************************** */
                /* sub - company name */
                /* ******************************** */
                /* ******************************** */
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Sub- Company Name',
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
                    controller: constSubCompanyName,
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Sub - Company Name',
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 14,
                        // fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Sub - Company Name';
                      }
                      return null;
                    },
                  ),
                ),

                /* ******************************** */
                /* ******************************** */
                /* ship name */
                /* ******************************** */
                /* ******************************** */

                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Vessel Name',
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
                    controller: constShipVesselName,
                    readOnly: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ship Name',
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 14,
                        // fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Vessel Name';
                      }
                      return null;
                    },
                  ),
                ),

                /* ******************************** */
                /* ******************************** */
                /* ship imo number */
                /* ******************************** */
                /* ******************************** */

                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Ship IMO',
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
                    controller: contShipImoNumber,
                    readOnly: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ship IMO',
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
                /* ship dwt */
                /* ******************************** */
                /* ******************************** */

                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Ship DWT',
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
                    controller: constShipDWT,
                    readOnly: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ship DWT',
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
                /* ship id */
                /* ******************************** */
                /* ******************************** */
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Ship Id',
                    Colors.black,
                    14.0,
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 206, 203, 203),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: constShipId,
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ship Id',
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
                /* ship type */
                /* ******************************** */
                /* ******************************** */
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Ship Type',
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
                    controller: contShipType,
                    readOnly: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ship Type',
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
                /* ship laden / ballast */
                /* ******************************** */
                /* ******************************** */
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Ship Laden / Ballast',
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
                    controller: contShipLadenBallast,
                    readOnly: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ship Laden/Ballast',
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
                /* ship build date */
                /* ******************************** */
                /* ******************************** */
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Ship Build Date',
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
                    controller: constShipBuildDate,
                    readOnly: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ship Build Date',
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
                /* ship exp date */
                /* ******************************** */
                /* ******************************** */
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Ship Exp. Date',
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
                    controller: constShipExpYear,
                    readOnly: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ship Exp. Date',
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
                /* ship tc / own */
                /* ******************************** */
                /* ******************************** */

                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Ship TC / OWN',
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
                    controller: constShipTcOwn,
                    readOnly: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ship TC / OWN',
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
                /* ship size */
                /* ******************************** */
                /* ******************************** */

                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Ship Size',
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
                    controller: contShipSize,
                    readOnly: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ship Size',
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
                /* ship class */
                /* ******************************** */
                /* ******************************** */

                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Ship Ice Class',
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
                    controller: contShipClass,
                    readOnly: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ship Ice Class',
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
                /* ship flag */
                /* ******************************** */
                /* ******************************** */

                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: textWithRegularStyle(
                    'Ship Flag',
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
                    controller: contShipFlag,
                    readOnly: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ship Flag',
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 14,
                        // fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
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
                      funcAddShipXMPP();
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
                /*SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 100,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: NeoPopButton(
                      color: Colors.lightBlueAccent,

                      // onTapUp: () => HapticFeedback.vibrate(),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      onTapUp: () {
                        //
                        if (formKey.currentState!.validate()) {
                          //
                          startLoadingUI(context, 'please wait...');
                          funcGetCompanyDetails();

                          //
                        }
                      },
                      onTapDown: () => HapticFeedback.vibrate(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textWithBoldStyle(
                            'Add',
                            Colors.black,
                            14.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),*/
                //
              ],
            ),
          ),
        ),
      ),
    );
  }

  //
  // ADD SHIP START FROM HERE
  funcAddShipXMPP() {
    //
    startLoadingUI(context, 'please wait...');
    //
    if (kDebugMode) {
      print('======================================');
      print('========== FULL DATA IS ==============');
      print(widget.getFullData);
    }
    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}company/${widget.getFullData['company_firebase_id'].toString()}/ships',
    );

    users
        .add(
          {
            // company data
            'company_firebase_id':
                widget.getFullData['company_firebase_id'].toString(),
            'company_id': widget.getFullData['company_id'].toString(),

            // sub company data
            'sub_company_id': widget.getFullData['sub_company_id'].toString(),
            'sub_company_firebase_id':
                widget.getFullData['sub_company_firebase_id'].toString(),
            'sub_company_firestore_id':
                widget.getFullData['firestore_id'].toString(),
            //
            // ship date
            'ship_name': constShipVesselName.text.toString(),
            'ship_id': constShipId.text.toString(),
            'ship_imo_number': contShipImoNumber.text.toString(),
            'ship_dwt': constShipDWT.text.toString(),
            'ship_type': contShipType.text.toString(),
            'ship_laden_ballast': contShipLadenBallast.text.toString(),
            'ship_build_date': constShipBuildDate.text.toString(),
            'ship_exp_date': constShipExpYear.text.toString(),
            'ship_tc_own': constShipTcOwn.text.toString(),
            'ship_size': contShipSize.text.toString(),
            'ship_ice_class': contShipClass.text.toString(),
            'ship_flag': contShipFlag.text.toString(),

            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'active': 'yes',
            'type': 'ship',

            'ship_captain_name': 'n.a.',
            'ship_ce_name': 'n.a',

            // 'ship_controller': []
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

  // merge firestore id to add ship
  funcEditFirestoreIdInRegistration(elementId) {
    print('element id is =====> $elementId');
    FirebaseFirestore.instance
        .collection('${strFirebaseMode}company')
        .doc(widget.getFullData['company_firebase_id'].toString())
        .collection('ships')
        .doc(elementId)
        .set(
      {
        'firestore_id': elementId,
      },
      SetOptions(merge: true),
    ).then(
      (value) {
        if (kDebugMode) {
          print('=========================================');
          print('==== Ship Created. NOW Add Departments ======');
        }
        //
        Navigator.pop(context);
        Navigator.pop(context);
        // funcAlsoCreateAllDepartmentAfterCreateShip(elementId.toString());
        //
      },
    );
  }

  //
  //
  funcAlsoCreateAllDepartmentAfterCreateShip(
    /*mainCompanyFirebaseId,
    subCompanyFirebaseId,
    subCompanyId,
    mainCompanyId,*/
    getShipFirestoreId,
  ) {
    for (int i = 0; i < arrShipDepartment.length; i++) {
      CollectionReference users = FirebaseFirestore.instance.collection(
        // '${strFirebaseMode}ship_department/India/${widget.getMainShipDataToAddShip['company_firebase_id'].toString()}/${widget.getSubShipDataToAddShip['sub_company_firebase_id'].toString()}/departments/$getShipFirestoreId/${arrShipDepartment[i]}',
        '${strFirebaseMode}ship_department/${widget.getFullData['company_firebase_id'].toString()}/$getShipFirestoreId/details',
      );

      users
          .add(
            {
              // company data
              'company_firebase_id':
                  widget.getFullData['company_firebase_id'].toString(),
              'company_id': widget.getFullData['company_id'].toString(),

              // sub company data
              'sub_company_id': widget.getFullData['sub_company_id'].toString(),
              'sub_company_firebase_id':
                  widget.getFullData['sub_company_firebase_id'].toString(),
              'sub_company_firestore_id':
                  widget.getFullData['firestore_id'].toString(),
              //
              'ship_firestore_id': getShipFirestoreId.toString(),
              //
              'members': '0',
              'department_name': arrShipDepartment[i].toString(),
              //
              //
              'time_stamp': DateTime.now().millisecondsSinceEpoch,
              'active': 'yes',
              'type': 'ship_department',
              'ship_controller': []
            },
          )
          .then((value) => {
                FirebaseFirestore.instance
                    .collection('${strFirebaseMode}ship_department')
                    // .doc('India')
                    .doc(widget.getFullData['company_firebase_id'].toString())
                    .collection("")
                    .doc(getShipFirestoreId.toString())
                    .collection('details')
                    .doc(value.id)
                    .set(
                  {
                    'firestore_id': value.id,
                  },
                  SetOptions(merge: true),
                ),
              })
          .catchError((error) => {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     backgroundColor: navigationColor,
                //     content: textWithBoldStyle(
                //       //
                //       'Failed to add. Please try again after sometime.'
                //           .toString(),
                //       //
                //       Colors.white,
                //       14.0,
                //     ),
                //   ),
                // ),
              });
    }
    //
    funcShipAddedSuccessMessage();
    //
  }

  //
  //
  funcAddFirestoreIdInShipDepartment(
    shipFirestoreId,
    elementId,
  ) {
    FirebaseFirestore.instance
        .collection('${strFirebaseMode}ship_department')
        // .doc('India')
        .doc(widget.getFullData['company_firebase_id'].toString())
        .collection('')
        .doc(shipFirestoreId.toString())
        .collection(elementId)
        .doc('details')
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
        // funcAlsoCreateAllDepartmentAfterCreateShip(elementId.toString());
        // funcShipAddedSuccessMessage();
        //
      },
    );
  }

  // ship added successfully alert
  funcShipAddedSuccessMessage() {
    Navigator.pop(context);
    Navigator.pop(context);
    //
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.lightBlueAccent,
        content: textWithBoldStyle(
          //
          'Successfully Added'.toString(),
          //
          Colors.white,
          14.0,
        ),
      ),
    );
  }
  //
}
