import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;


class PermissionManager
{
  static loc.Location locationManager = loc.Location();

  static Future<PermissionStatus> GetContactsPermission() async
  {
    PermissionStatus permissionState = await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);
    if(permissionState != PermissionStatus.granted)
    {
      Map<PermissionGroup, PermissionStatus> perm = await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
      return perm[PermissionGroup.contacts];
    }else{
      return permissionState;
    }
  }

  static Future<PermissionStatus> GetSmsPermission() async
  {
    PermissionStatus permissionState = await PermissionHandler().checkPermissionStatus(PermissionGroup.sms);
    if(permissionState != PermissionStatus.granted)
    {
      Map<PermissionGroup, PermissionStatus> perm = await PermissionHandler().requestPermissions([PermissionGroup.sms]);
      return perm[PermissionGroup.sms];
    }else{
      return permissionState;
    }
  }

  static Future<bool> GetLocationPermission() async
  {
    if(locationManager == null) locationManager = loc.Location();
    bool enabled = await locationManager.serviceEnabled();
    if(!enabled)
    {
      enabled = await locationManager.requestService();
      if(!enabled)
      {
        return false;
      }
    }

    bool permissionEnabled = await locationManager.hasPermission() == loc.PermissionStatus.granted;
    if(!permissionEnabled)
    {
      permissionEnabled = await locationManager.requestPermission() == loc.PermissionStatus.granted;
      return permissionEnabled;
    }

    return permissionEnabled && enabled;
  }
}