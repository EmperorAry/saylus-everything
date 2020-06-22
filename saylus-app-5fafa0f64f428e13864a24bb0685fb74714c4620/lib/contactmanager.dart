import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:jinx/permissionmanager.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';

class ContactManager
{
  static ContactManager _instance;

  static MethodChannel platform;

  List<Contact> allContacts, selectedContacts;
  
  File _contactsFile;

  factory ContactManager()
  {
    if(_instance == null)
    {
      _instance = ContactManager._internal();
    }
    return _instance;
  }

  ContactManager._internal() : allContacts = List<Contact>(), selectedContacts = List<Contact>()
  {
    _initFile();
  }

  Future<Null> _initFile() async
  {
    String path = (await getApplicationDocumentsDirectory()).path;
    _contactsFile = File("$path/trusted.txt");
    if(!_contactsFile.existsSync())
    {
      await _contactsFile.create();
      return;
    }
  }

  Future<Null> tryLoad() async
  {
    if(allContacts.length != 0) return;

    allContacts = (await ContactsService.getContacts()).toList();

    log("READIN'");
    allContacts.removeWhere((Contact c) {return c.phones.length == 0;});
    List<String> lines = await _contactsFile.readAsLines();
    for(int i = 0; i < lines.length; i++)
    {
      await _select(lines[i]);
    }
  }

  Future<Null> _select(String s) async
  {
    for(int i = 0; i < allContacts.length; i++)
    {
      if(allContacts[i].phones.length == 0)continue;
      String no = allContacts[i].phones.first.value;
      if(no == s)
      {
        selectedContacts.add(allContacts[i]);
        log("loaded " + allContacts[i].phones.first.value);
        return;
      }
    }
  }

  Future<Null> trySave(List<Contact> selected) async
  {
    selectedContacts = selected;
    String write = "";
    for(int i = 0; i < selectedContacts.length; i++)
    {
      write += selectedContacts[i].phones.first.value + (i==selectedContacts.length-1? "" : "\n");
    }
    _contactsFile.writeAsString(write);
    log("Wrote: \n" + write);
  }

  Future<Null> send() async
  {
    if(platform == null) platform = MethodChannel("com.saylus/sendsms");

    LocationData cLoc = await PermissionManager.locationManager.getLocation();
    String coords = "(${cLoc.latitude.toString()}, ${cLoc.longitude.toString()})";
    String message = "I fear that my life may soon be at its end. Currently, I am at $coords";
    log(selectedContacts.length.toString());
    for(int i = 0; i < selectedContacts.length; i++)
    {
      String address = selectedContacts[i].phones.first.value;
      await platform.invokeMethod("sendSMS", {"number":address, "message":message});
      log("Sent!");
      await Future.delayed(Duration(milliseconds: 550));
    }
  }
}