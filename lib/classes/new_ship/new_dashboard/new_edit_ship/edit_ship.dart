// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:water_ship/classes/Utils/utils.dart';
import 'package:water_ship/classes/new_ship/new_dashboard/new_ship_add_members/new_ship_add_members.dart';

class EditShipScreen extends StatefulWidget {
  const EditShipScreen({
    super.key,
    this.getMainShipDataToEditShip,
    // this.getSubShipDataToEditShip,
    this.getShipDetails,
  });

  final getMainShipDataToEditShip;
  // final getSubShipDataToEditShip;
  final getShipDetails;

  @override
  State<EditShipScreen> createState() => _EditShipScreenState();
}

class _EditShipScreenState extends State<EditShipScreen> {
  //
  //
  final formKey = GlobalKey<FormState>();

  late final TextEditingController constShipVesselName;
  // late final TextEditingController constShipId;

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
  var arrShipController = [];
  //
  @override
  void initState() {
    //
    if (kDebugMode) {
      print('======================================');
      print('========== MAIN COMPANY DATE ==============');
      print(widget.getMainShipDataToEditShip);
      // print('========== SUB COMPANY DATE ==============');
      // print(widget.getSubShipDataToEditShip);
      print('========== SHIP DATA ==============');
      print(widget.getShipDetails);
      // print(widget.getShipDetails['ship_controller']);
      print('======================================');
    }
    //
    // arrShipController = widget.getShipDetails['ship_controller'];
    // if (kDebugMode) {
    // print(arrShipController);
    // print(arrShipController.length);
    // }
    //

    constShipVesselName = TextEditingController(
        text: widget.getShipDetails['ship_name'].toString());

    constShipBuildDate = TextEditingController(
        text: widget.getShipDetails['ship_build_date'].toString());
    constShipExpYear = TextEditingController(
        text: widget.getShipDetails['ship_exp_date'].toString());

    constShipTcOwn = TextEditingController(
        text: widget.getShipDetails['ship_tc_own'].toString());

    constShipDWT = TextEditingController(
        text: widget.getShipDetails['ship_dwt'].toString());

    contShipImoNumber = TextEditingController(
        text: widget.getShipDetails['ship_imo_number'].toString());
    contShipType = TextEditingController(
        text: widget.getShipDetails['ship_type'].toString());
    contShipSize = TextEditingController(
        text: widget.getShipDetails['ship_size'].toString());
    contShipClass = TextEditingController(
        text: widget.getShipDetails['ship_ice_class'].toString());
    contShipFlag = TextEditingController(
        text: widget.getShipDetails['ship_flag'].toString());

    contShipLadenBallast = TextEditingController(
        text: widget.getShipDetails['ship_laden_ballast'].toString());

    super.initState();
  }

  @override
  void dispose() {
    //
    // constMainCompanyName.dispose();
    // constSubCompanyName.dispose();

    constShipVesselName.dispose();
    // constShipId.dispose();
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
          'Edit ship',
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
                /*if (arrShipController.isEmpty) ...[
                  
                ],*/

                GestureDetector(
                  onTap: () {
                    //
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewShipAddMembers(
                            getMainCompanyFullData:
                                widget.getMainShipDataToEditShip,
                            getShipData: widget.getShipDetails,
                            strMemberType: 'ce'),
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWithRegularStyle(
                          ' Assign CE',
                          Colors.black,
                          14.0,
                        ),
                        //
                        const Icon(
                          Icons.chevron_right,
                        ),
                      ],
                    ),
                  ),
                ),
                //
                const SizedBox(
                  height: 10,
                ),
                //
                GestureDetector(
                  onTap: () {
                    //
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewShipAddMembers(
                            getMainCompanyFullData:
                                widget.getMainShipDataToEditShip,
                            getShipData: widget.getShipDetails,
                            strMemberType: 'captain'),
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWithRegularStyle(
                          ' Assign Captain',
                          Colors.black,
                          14.0,
                        ),
                        //
                        const Icon(
                          Icons.chevron_right,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
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
                /*const SizedBox(
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
                ),*/

                /* ************************************************************** */
                /* ************************************************************** */
                /* ship type */
                /* ************************************************************** */
                /* ************************************************************** */
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

                /* ************************************************************** */
                /* ************************************************************** */
                /* ship laden / ballast */
                /* ************************************************************** */
                /* ************************************************************** */
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

                /* ************************************************************** */
                /* ************************************************************** */
                /* ship build date */
                /* ************************************************************** */
                /* ************************************************************** */
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

                /* ************************************************************** */
                /* ************************************************************** */
                /* ship exp date */
                /* ************************************************************** */
                /* ************************************************************** */
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

                /* ************************************************************** */
                /* ************************************************************** */
                /* ship tc / own */
                /* ************************************************************** */
                /* ************************************************************** */

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

                /* ************************************************************** */
                /* ************************************************************** */
                /* ship size */
                /* ************************************************************** */
                /* ************************************************************** */

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

                /* ************************************************************** */
                /* ************************************************************** */
                /* ship class */
                /* ************************************************************** */
                /* ************************************************************** */

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

                /* ************************************************************** */
                /* ************************************************************** */
                /* ship flag */
                /* ************************************************************** */
                /* ************************************************************** */

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
                      funcEditShipXMPP();
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
                        'Update ',
                        Colors.black,
                        16.0,
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
    );
  }

  //
  //
  funcEditShipXMPP() {
    //
    startLoadingUI(context, 'Updating...');
    //
    if (kDebugMode) {
      print('======================================');
      print('========== MAIN COMPANY DATE ==============');
      print(widget.getMainShipDataToEditShip);
      print('========== SUB COMPANY DATE ==============');
      print(widget.getShipDetails);
      print(widget.getShipDetails['firestore_id'].toString());
      print('======================================');
    }
    FirebaseFirestore.instance
        .collection('${strFirebaseMode}company')
        // .doc('India')
        .doc(widget.getMainShipDataToEditShip['company_firebase_id'].toString())
        // .doc(widget.getSubShipDataToEditShip['sub_company_firebase_id']
        // .toString())
        .collection('ships')
        .doc(widget.getShipDetails['firestore_id'].toString())
        .set(
      {
        'time_stamp': DateTime.now().millisecondsSinceEpoch,
        // ship date
        'ship_name': constShipVesselName.text.toString(),

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
      },
      SetOptions(merge: true),
    ).then(
      (value) {
        if (kDebugMode) {
          print('value 1.0');
        }
        //
        funcShipAddedSuccessMessage();

        //
      },
    );
  }

  // merge firestore id to add ship
  funcEditFirestoreIdInRegistration(elementId) {
    FirebaseFirestore.instance
        .collection('${strFirebaseMode}company_ships')
        .doc('India')
        .collection('details')
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
        funcShipAddedSuccessMessage();
        //
      },
    );
  }

  // ship added successfully alert
  funcShipAddedSuccessMessage() {
    Navigator.pop(context);
    // Navigator.pop(context);
    //
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.lightBlueAccent,
        content: textWithBoldStyle(
          //
          'Successfully Updated'.toString(),
          //
          Colors.white,
          14.0,
        ),
      ),
    );
  }
  //
}
