// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:water_ship/classes/Utils/utils.dart';

class ShipDepartmentScreen extends StatefulWidget {
  const ShipDepartmentScreen(
      {super.key,
      this.getMainCompanyFullDetailsInDepartment,
      this.getSubCompanyDetailsInDepartment});

  final getMainCompanyFullDetailsInDepartment;
  final getSubCompanyDetailsInDepartment;

  @override
  State<ShipDepartmentScreen> createState() => _ShipDepartmentScreenState();
}

class _ShipDepartmentScreenState extends State<ShipDepartmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithRegularStyle(
          //
          'Department',
          //
          Colors.black,
          16.0,
        ),
        backgroundColor: navigationColor,
        actions: [
          SizedBox(
            // width: 100,
            // height: 50,
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
                  if (kDebugMode) {
                    print('1');
                  }
                  //
                  if (kDebugMode) {
                    print('add department');
                  }
                  //
                },
                onTapDown: () => HapticFeedback.vibrate(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: textWithRegularStyle(
                        'add department',
                        Colors.black,
                        14.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
