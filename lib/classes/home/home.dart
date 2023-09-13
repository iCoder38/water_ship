// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:water_ship/classes/new_ship/new_dashboard/new_all_ships_(_deprecated_)/home_ship_listing_ui.dart';

import '../Utils/utils.dart';
import '../add_members/add_members.dart';
import '../new_ship/new_dashboard/new_add_ship/new_add_ship.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          children: [
            textWithRegularStyle(
              'Your Ships',
              Colors.white,
              18.0,
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                width: 180,
                child: NeoPopButton(
                  color: navigationColor,
                  // onTapUp: () => HapticFeedback.vibrate(),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  onTapUp: () {
                    //
                    //
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddShipScreen(),
                      ),
                    );
                    //
                  },
                  onTapDown: () => HapticFeedback.vibrate(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //
                      const Icon(
                        Icons.add,
                        size: 20.0,
                      ),
                      Center(
                        child: textWithRegularStyle(
                          ' Add Ship',
                          Colors.black,
                          14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            //
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: navigationColor,
        leading: SizedBox(
          height: 40,
          width: 40,
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
                // print(FirebaseAuth.instance.currentUser!.photoURL);
                logoutpopup(context, 'Are you sure you want to logout?');
                //
              },
              onTapDown: () => HapticFeedback.vibrate(),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.redAccent,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          //

          //

          // Container(
          //   margin: const EdgeInsets.only(
          //     top: 64.0,
          //   ),
          //   height: 0.5,
          //   width: MediaQuery.of(context).size.width,
          //   color: Colors.blueGrey,
          // ),
          //
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('${strFirebaseMode}user')
                .doc('India')
                .collection('details')
                .where(
                  'company_firebase_id',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                )
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if (kDebugMode) {
                  print('YES YOU ARE REGISTERED.');
                  print(snapshot.data!.docs.length);
                }

                var save_snapshot_value = snapshot.data!.docs;
                if (kDebugMode) {
                  print(save_snapshot_value);
                  // print(save_snapshot_value[0]['type']);
                }
                return (snapshot.data!.docs.isEmpty)
                    ? Center(
                        child: textWithRegularStyle(
                          'No data found',
                          Colors.black,
                          14.0,
                        ),
                      )
                    : HomeShiftListingUI(
                        shipListingGetData: save_snapshot_value,
                      );
              } else if (snapshot.hasError) {
                if (kDebugMode) {
                  print(snapshot.error);
                }
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  //
  Row addMemberAndCreateGroupUI(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        addShipButtonUI(context),
        //
        //AddMemberUI(context),
        //

        //
      ],
    );
  }

  //
  SizedBox addShipButtonUI(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 160,
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
            //
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddShipScreen(),
              ),
            );
            //
          },
          onTapDown: () => HapticFeedback.vibrate(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              const Icon(
                Icons.add,
                size: 20.0,
              ),
              Center(
                child: textWithRegularStyle(
                  ' Add Ship',
                  Colors.black,
                  14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox AddMemberUI(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 180,
      // color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NeoPopButton(
          color: Colors.blueAccent,
          // onTapUp: () => HapticFeedback.vibrate(),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          onTapUp: () {
            //
            //
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddMembersScreen(),
              ),
            );
            //
          },
          onTapDown: () => HapticFeedback.vibrate(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Row(
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18.0,
                    ),
                    textWithRegularStyle(
                      'Add members',
                      Colors.white,
                      14.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //
}
