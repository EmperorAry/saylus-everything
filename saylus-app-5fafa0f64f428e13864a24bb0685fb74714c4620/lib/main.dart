import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jinx/contactmanager.dart';
import 'package:permission_handler/permission_handler.dart';
import './landing.dart';
import './permissionmanager.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then( (_) {
    runApp(JinxApp());
    getPermissions();
    ContactManager();
  });
}

Future<Null> getPermissions() async
{
  bool granted = await PermissionManager.GetContactsPermission() == PermissionStatus.granted && await PermissionManager.GetSmsPermission() == PermissionStatus.granted && await PermissionManager.GetLocationPermission();
  if(!granted)
  {
    SystemNavigator.pop(); //TODO: TEMPorAry
  }
}

class JinxApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: "Saylus",
      theme: ThemeData(primaryColor: Color(0xFFFF8049), accentColor: Color(0xFFFFB08E), backgroundColor: Color(0xFFF9F6FF)),
      home: Landing(),
    );
  }
}