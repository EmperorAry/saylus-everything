import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:jinx/contactmanager.dart';

class ContactScreen extends StatefulWidget
{
  @override 
  CSState createState()
  {
    return CSState();
  }
}

class CSState extends State<ContactScreen>
{
  List<Contact> _allContacts;
  List<Contact> _selectedContacts;

  BuildContext _currentContext;

  CSState()
  {
    _allContacts = ContactManager().allContacts;
    _selectedContacts = ContactManager().selectedContacts;
  }

  Future<bool> _onDone() async
  {
    ContactManager().trySave(_selectedContacts);
    return true;
  }

  @override 
  Widget build(BuildContext context)
  {
    _currentContext = context;

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.people),
          backgroundColor: Theme.of(context).accentColor,
          title: Text("Select trusted contacts"),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: ListView.builder(itemCount: _allContacts.length, itemBuilder: (BuildContext context, int i) {
          bool selected = _selectedContains(_allContacts[i]);
          return ListTile(
            leading: CircleAvatar(child: Text(_allContacts[i].initials()), backgroundColor: Theme.of(context).primaryColor, foregroundColor: Theme.of(context).backgroundColor,),
            title: Text(_allContacts[i].displayName),
            trailing: Icon(selected? Icons.check_box : Icons.check_box_outline_blank),
            onTap: () {
              if(selected)
              {
                setState(() {
                  _selectedContacts.removeWhere((Contact c){
                    return c.phones.elementAt(0) == _allContacts[i].phones.elementAt(0);
                  });
                });
              }else{
                setState(() {
                  _selectedContacts.add(_allContacts[i]);
                });
              }
            },
          );
        },),
      ),
      onWillPop: _onDone,
    );
  }

  bool _selectedContains(Contact c)
  {
    if(c.phones.length == 0) return false;
    for(int i = 0; i < _selectedContacts.length; i++)
    {
      var cur = _selectedContacts.elementAt(i);
      if(cur.phones.length == 0) continue;
      if(c.phones.elementAt(0) == cur.phones.elementAt(0))
      {
        return true;
      }
    }
    return false;
  }
}