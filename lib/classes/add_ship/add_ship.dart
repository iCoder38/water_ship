import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

import '../Utils/utils.dart';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

class AddShipScreen extends StatefulWidget {
  const AddShipScreen({super.key});

  @override
  State<AddShipScreen> createState() => _AddShipScreenState();
}

class _AddShipScreenState extends State<AddShipScreen> {
  //
  final formKey = GlobalKey<FormState>();
  late final TextEditingController constShipId;

  late final TextEditingController constShipName;
  late final TextEditingController constShipBuildYear;
  late final TextEditingController constShipExpYear;
  late final TextEditingController constShipTotalWeight;
  late final TextEditingController constShipTotalCarryWeight;
  late final TextEditingController contShipType;
  //
  final random = Random();
  //
  var strShipId = '0';
  //
  var arrShipListing = [
    'Container ship',
    'Bulk carrier ship',
    'Fishing vessel',
    'Dredger',
    'High-speed craft',
    'Gas carrier',
    'Offshore ship',
    'Passenger ship',
    'Naval ship',
    'Livestock carrier',
    'Roll-on Roll-Off ship',
    'Tanker ship',
    'Heavy life ship',
    'Yacht',
    'Tugs',
    'Submarine',
    'Hovercraft',
    'Sailboat',
    'Barge',
    'Canoe',
  ];
  //
  @override
  void initState() {
    //
    constShipId = TextEditingController();
    constShipName = TextEditingController();
    constShipBuildYear = TextEditingController();
    constShipExpYear = TextEditingController();
    constShipTotalWeight = TextEditingController();
    constShipTotalCarryWeight = TextEditingController();
    contShipType = TextEditingController();

    strShipId = get16DigitNumber();

    constShipId.text = strShipId.toString();
    //

    //
    super.initState();
  }

  @override
  void dispose() {
    //
    constShipId.dispose();
    constShipName.dispose();
    constShipBuildYear.dispose();
    constShipExpYear.dispose();
    constShipTotalWeight.dispose();
    constShipTotalCarryWeight.dispose();
    contShipType.dispose();

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
          child: Column(
            children: [
              //
              const SizedBox(
                height: 16,
              ),
              shipNameTextUI(),
              shipNameTextFieldUI(),
              //
              const SizedBox(
                height: 16,
              ),
              //
              shipIdTextUI(),
              shipIdTextFieldUI(),
              //
              const SizedBox(
                height: 16,
              ),
              //
              shipBuildYearTextUI(),
              shipBuildYearTextFieldUI(),
              //
              const SizedBox(
                height: 16,
              ),
              //
              shipExpYearTextUI(),
              shipExpYearTextFieldUI(),
              //
              const SizedBox(
                height: 16,
              ),
              //
              shipTotalWeightTextUI(),
              shipTotalWeightTextFieldUI(),
              const SizedBox(
                height: 16,
              ),
              //
              shipTotalCarryWeightTextUI(),
              shipTotalCarryWeightTextFieldUI(),
              //
              const SizedBox(
                height: 16,
              ),
              //
              shipTypeTextUI(),
              shipTypeTextFieldUI(),
              //
              const SizedBox(
                height: 20,
              ),
              //
              SizedBox(
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
                        showCustomDialog(context, 'please wait...');
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
              ),
              //
            ],
          ),
        ),
      ),
    );
  }

// SHIP TOTAL WEIGHT
  Row shipTypeTextUI() {
    return Row(
      children: [
        //
        const SizedBox(
          width: 10,
        ),
        //
        Align(
          alignment: Alignment.topLeft,
          child: textWithRegularStyle(
            'Ship Type',
            Colors.black,
            14.0,
          ),
        ),
      ],
    );
  }

  Container shipTypeTextFieldUI() {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
      ),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12.0,
        ),
        color: Colors.white,
        border: Border.all(width: 0.4),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 188, 182, 182),
            blurRadius: 6.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          )
        ],
      ),
      child: TextFormField(
        // enabled: false,
        readOnly: true,
        controller: contShipType,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Ship Type',
          suffixIcon: Icon(
            Icons.arrow_drop_down,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ship type';
          }
          return null;
        },
        onTap: () {
          if (kDebugMode) {
            print('Clicked');
          }
          //
          showAdaptiveActionSheet(
            context: context,
            title: const Text('Please select Ship Type'),
            androidBorderRadius: 30,
            actions: <BottomSheetAction>[
              for (int i = 0; i < arrShipListing.length; i++) ...[
                BottomSheetAction(
                    title: textWithRegularStyle(
                      arrShipListing[i].toString(),
                      Colors.black,
                      14.0,
                    ), // Text(arrShipListing[i]),
                    onPressed: (context) {
                      //
                      Navigator.pop(context);
                      setState(() {
                        contShipType.text = arrShipListing[i];
                      });
                      //
                    }),
              ]

              /*BottomSheetAction(
                  title: const Text('Bulk carrier ships'),
                  onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Fishing vessels'),
                  onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Dredgers'), onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('High-speed craft'),
                  onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Gas carriers'), onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Offshore ships'), onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Passenger ships'),
                  onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Naval ships'), onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Livestock carriers'),
                  onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Roll-on Roll-Off ships'),
                  onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Tanker ships'), onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Heavy life ships'),
                  onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Yacht'), onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Tugs'), onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Submarine'), onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Hovercraft'), onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Sailboat'), onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Barge'), onPressed: (context) {}),
              BottomSheetAction(
                  title: const Text('Canoe'), onPressed: (context) {}),*/
            ],
            cancelAction: CancelAction(
                title: const Text(
                    'Cancel')), // onPressed parameter is optional by default will dismiss the ActionSheet
          );
//
        },
      ),
    );
  }

// SHIP TOTAL WEIGHT
  Row shipTotalCarryWeightTextUI() {
    return Row(
      children: [
        //
        const SizedBox(
          width: 10,
        ),
        //
        Align(
          alignment: Alignment.topLeft,
          child: textWithRegularStyle(
            'Ship Total Carry Weight ( kg )',
            Colors.black,
            14.0,
          ),
        ),
      ],
    );
  }

  Container shipTotalCarryWeightTextFieldUI() {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
      ),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12.0,
        ),
        color: Colors.white,
        border: Border.all(width: 0.4),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 188, 182, 182),
            blurRadius: 6.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          )
        ],
      ),
      child: TextFormField(
        controller: constShipTotalCarryWeight,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Ship Total Carry Weight',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ship totalCarry  weight';
          }
          return null;
        },
      ),
    );
  }

// SHIP TOTAL WEIGHT
  Row shipTotalWeightTextUI() {
    return Row(
      children: [
        //
        const SizedBox(
          width: 10,
        ),
        //
        Align(
          alignment: Alignment.topLeft,
          child: textWithRegularStyle(
            'Ship Total Weight ( kg )',
            Colors.black,
            14.0,
          ),
        ),
      ],
    );
  }

  Container shipTotalWeightTextFieldUI() {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
      ),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12.0,
        ),
        color: Colors.white,
        border: Border.all(width: 0.4),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 188, 182, 182),
            blurRadius: 6.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          )
        ],
      ),
      child: TextFormField(
        controller: constShipTotalWeight,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Ship Total Weight',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ship total weight';
          }
          return null;
        },
      ),
    );
  }

// EXP YEAR
  Row shipExpYearTextUI() {
    return Row(
      children: [
        //
        const SizedBox(
          width: 10,
        ),
        //
        Align(
          alignment: Alignment.topLeft,
          child: textWithRegularStyle(
            'Ship Exp. Year',
            Colors.black,
            14.0,
          ),
        ),
      ],
    );
  }

  Container shipExpYearTextFieldUI() {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
      ),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12.0,
        ),
        color: Colors.white,
        border: Border.all(width: 0.4),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 188, 182, 182),
            blurRadius: 6.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          )
        ],
      ),
      child: TextFormField(
        controller: constShipExpYear,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Ship Exp. Year',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ship exp. year';
          }
          return null;
        },
      ),
    );
  }

  //
  Row shipBuildYearTextUI() {
    return Row(
      children: [
        //
        const SizedBox(
          width: 10,
        ),
        //
        Align(
          alignment: Alignment.topLeft,
          child: textWithRegularStyle(
            'Ship Build Year',
            Colors.black,
            14.0,
          ),
        ),
      ],
    );
  }

  Container shipBuildYearTextFieldUI() {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
      ),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12.0,
        ),
        color: Colors.white,
        border: Border.all(width: 0.4),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 188, 182, 182),
            blurRadius: 6.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          )
        ],
      ),
      child: TextFormField(
        controller: constShipBuildYear,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Ship Build Year',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ship build year';
          }
          return null;
        },
      ),
    );
  }

  //
  Row shipIdTextUI() {
    return Row(
      children: [
        //
        const SizedBox(
          width: 10,
        ),
        //
        Align(
          alignment: Alignment.topLeft,
          child: textWithRegularStyle(
            'Ship Id',
            Colors.black,
            14.0,
          ),
        ),
      ],
    );
  }

  Container shipIdTextFieldUI() {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
      ),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12.0,
        ),
        color: Colors.white,
        border: Border.all(width: 0.4),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 188, 182, 182),
            blurRadius: 6.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          )
        ],
      ),
      child: TextFormField(
        enabled: false,
        controller: constShipId,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: strShipId.toString(),
        ),
        /*validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ship Id';
          }
          return null;
        },*/
      ),
    );
  }

  //
  Row shipNameTextUI() {
    return Row(
      children: [
        //
        const SizedBox(
          width: 10,
        ),
        //
        Align(
          alignment: Alignment.topLeft,
          child: textWithRegularStyle(
            'Ship Name',
            Colors.black,
            14.0,
          ),
        ),
      ],
    );
  }

  Container shipNameTextFieldUI() {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
      ),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12.0,
        ),
        color: Colors.white,
        border: Border.all(width: 0.4),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 188, 182, 182),
            blurRadius: 6.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          )
        ],
      ),
      child: TextFormField(
        controller: constShipName,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Ship Name',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ship name';
          }
          return null;
        },
      ),
    );
  }

  // get company details
  funcGetCompanyDetails() {
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}user")
        .doc("India")
        .collection("details")
        .where("company_firebase_id",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
      } else {
        for (var element in value.docs) {
          if (kDebugMode) {
            print('======> YES,  USER FOUND');
          }
          if (kDebugMode) {
            print(element.data());
            /*print(element.data()["company_name"]);
            print(element.id);
            print(element.id.runtimeType);*/
          }
          //
          funcAddShipXMPP(
            element.data()["company_firebase_id"].toString(),
            element.data()["company_name"].toString(),
            element.data()["company_id"].toString(),
            element.data()["firestore_id"].toString(),
          );
        }
      }
    });
  }

  //
  funcAddShipXMPP(
    companyFirebaseId,
    companyName,
    companyId,
    companyFirestoreId,
  ) {
    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}ships/India/details',
    );

    users
        .add(
          {
            'company_firebase_id': companyFirebaseId,
            'company_name': companyName,
            'company_id': companyId,
            'company_firestore_id': companyFirestoreId,
            //
            'ship_name': constShipName.text.toString(),
            'ship_id': constShipId.text.toString(),
            'ship_build_year': constShipBuildYear.text.toString(),
            'ship_exp_year': constShipExpYear.text.toString(),
            'ship_total_weight': constShipTotalWeight.text.toString(),
            'ship_total_weight_carry':
                constShipTotalCarryWeight.text.toString(),
            'ship_type': contShipType.text.toString(),
            'ship_profile_image': '',
            'ship_image_gallery': [],
            'match': [
              FirebaseAuth.instance.currentUser!.uid,
            ],
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'active': 'yes',
            'type': 'ship',
          },
        )
        .then((value) => {
              print(value.id),
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
    FirebaseFirestore.instance
        .collection('${strFirebaseMode}ships')
        .doc('India')
        .collection('details')
        .doc(elementId)
        .set(
      {
        'ship_firestore_id': elementId,
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
