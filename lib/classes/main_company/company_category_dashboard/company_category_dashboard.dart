// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:water_ship/classes/main_company/sub_company/multiple_sub_companies/sub_company_listing.dart';

import '../../Utils/utils.dart';
import '../../drawer/drawer.dart';

class CompanyCategoryDashboardScreen extends StatefulWidget {
  const CompanyCategoryDashboardScreen(
      {super.key, this.getMainCompanyFullDataFromLogin});

  final getMainCompanyFullDataFromLogin;

  @override
  State<CompanyCategoryDashboardScreen> createState() =>
      _CompanyCategoryDashboardScreenState();
}

class _CompanyCategoryDashboardScreenState
    extends State<CompanyCategoryDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithRegularStyle(
          //
          'Cateogry',
          //
          Colors.black,
          16.0,
        ),
        backgroundColor: navigationColor,
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width - 100,
        child: const navigationDrawer(),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainSubCompanyListingScreen(
                    getCategoryName: 'Department'.toString(),
                    getFullDataFromLogin:
                        widget.getMainCompanyFullDataFromLogin,
                  ),
                ),
              );
              //
            },
            child: ListTile(
              title: textWithBoldStyle(
                'Department',
                Colors.black,
                18.0,
              ),
              subtitle: textWithRegularStyle(
                'Your department company',
                Colors.black,
                14.0,
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
            ),
          ),
          //
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          //
          GestureDetector(
            onTap: () {
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainSubCompanyListingScreen(
                    getCategoryName: 'Ship'.toString(),
                    getFullDataFromLogin:
                        widget.getMainCompanyFullDataFromLogin,
                  ),
                ),
              );
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainCompanyCategoryScreen(
                    getCategoryName: 'Ship'.toString(),
                    getFullDataOfMainCompany:
                        widget.getMainCompanyFullDataFromLogin,
                  ),
                ),
              );*/
            },
            child: ListTile(
              title: textWithBoldStyle(
                'Ships',
                Colors.black,
                18.0,
              ),
              subtitle: textWithRegularStyle(
                'List of all Ships',
                Colors.black,
                14.0,
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
            ),
          ),
          //
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          //
        ],
      ),
    );
  }
}
