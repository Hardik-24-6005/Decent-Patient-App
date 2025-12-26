import "package:flutter/material.dart";
import 'package:hmz_patient/profile/fullProfile.dart';
import '../../profile/changePassword.dart';
import '../../patient/showAppointment.dart';
import '../../dashboard/dashboard.dart';

import 'package:hmz_patient/l10n/app_localizations.dart';

class AppBottomNavigationBar extends StatefulWidget {
  var screenNum;
  AppBottomNavigationBar({this.screenNum});

  @override
  _AppBottomNavigationBarState createState() =>
      _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  late int _selectedIndex;
  int? _selectedIndexValue;
  late Color selectedColor;
  late TextStyle optionStyle;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.screenNum ?? 0;
    _selectedIndexValue = widget.screenNum;

    selectedColor = Colors.blue;

    optionStyle = widget.screenNum == null
        ? const TextStyle(fontSize: 15)
        : const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  }


  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
      }
      if (index == 1) {
        Navigator.of(context)
            .pushReplacementNamed(ShowPatientAppointmentScreen.routeName);
      }

      if (index == 2) {
        Navigator.of(context).pushReplacementNamed(FullProfile.routeName);
      }

      _selectedIndex = index;
      _selectedIndexValue = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String dashboard = "${AppLocalizations.of(context)!.dashboard}";

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: (_selectedIndexValue == 0)
              ? AppLocalizations.of(context)!.dashboard
              : "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: (_selectedIndexValue == 1)
              ? AppLocalizations.of(context)!.appointments
              : "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: (_selectedIndexValue == 2)
              ? AppLocalizations.of(context)!.profile
              : "",
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: selectedColor,
      onTap: _onItemTapped,
    );
  }
}
