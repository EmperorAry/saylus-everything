import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jinx/contactmanager.dart';

import './contactscreen.dart';

class Home extends StatefulWidget
{
  @override
  HomeState createState()
  {
    return HomeState();
  }
}

class HomeState extends State<Home>
{  
  BuildContext _currentContext;

  HomeState();

  Widget build(BuildContext context)
  {
    _currentContext = context;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Header(),
          Body(),
        ],
      ),
    );
  }
}

class Header extends StatefulWidget
{
  HeaderState createState()
  {
    return HeaderState();
  }
}

class HeaderState extends State<Header>
{
  Widget build(BuildContext context)
  {
    var height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: height*0.24,
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment(1,0.85), colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor],),
      ),
      padding: EdgeInsets.fromLTRB(30, 60, 30, 12),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text("Hello,", style: TextStyle(color: Colors.white, fontSize: 24),),
            ],  
          ),
          Divider(color: Color.fromARGB(0, 1, 2, 3), height: 12,),
          Text("Meghan Dinklage", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }
}

class Body extends StatefulWidget
{
  BodyState createState() => BodyState();
}

class BodyState extends State<Body>
{
  BuildContext _currentContext;

  void _panic()
  {
    ContactManager().send();
  }
  
  void _loadContactsAndGo() async
  {
    await ContactManager().tryLoad();
    Navigator.of(_currentContext).push(
      CupertinoPageRoute(
        builder: (BuildContext context) => ContactScreen(),
      ),
    );
  }

  Widget build(BuildContext context)
  {
    _currentContext = context;

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    List<Widget> listChildren = [
      SizedCard(child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Icon(Icons.cancel, color: Theme.of(context).primaryColor, size: 60,),
            margin: EdgeInsets.fromLTRB(0, 0, 24, 0),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "My Device",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24
                  ),
                ),
                Divider(color: Color(0x00000000), height: 8,),
                Text(
                  "Please connect a Saylus compatible device to access the dashboard"
                ),
                Divider(color: Color(0x00000000), height: 8,),
                FlatButton(child: Text("Go to Dashboard",), onPressed: () {log("bruh");}, color: Theme.of(context).accentColor,),
              ],
            ),
            width: width * 0.48,
          ),
        ],
      ),),
      SizedCard(child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Icon(Icons.supervisor_account, color: Theme.of(context).accentColor, size: 60,),
            margin: EdgeInsets.fromLTRB(0, 0, 24, 0),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Trusted Contacts",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24
                  ),
                ),
                Divider(color: Color(0x00000000), height: 8,),
                Text(
                  "Choose the contacts your alert message is sent to"
                ),
                Divider(color: Color(0x00000000), height: 8,),
                FlatButton(child: Text("Select Contacts",), onPressed: _loadContactsAndGo, color: Theme.of(context).accentColor,),
              ],
            ),
            width: width * 0.48,
          ),
        ],
      ),),
      SizedCard(child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Icon(Icons.announcement, color: Theme.of(context).primaryColor, size: 60,),
            margin: EdgeInsets.fromLTRB(0, 0, 24, 0),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Alert Message",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24
                  ),
                ),
                Divider(color: Color(0x00000000), height: 8,),
                Text(
                  "Send a test message to your trusted contacts"
                ),
                Divider(color: Color(0x00000000), height: 8,),
                FlatButton(child: Text("Send Message",), onPressed: _panic, color: Theme.of(context).accentColor,),
              ],
            ),
            width: width * 0.48,
          ),
        ],
      ),),
    ];

    return Container(
      width: width,
      height: height * 0.76,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int i) => Divider(color: Color(0x00000000), height: 30,),
        itemCount: listChildren.length,
        itemBuilder: (BuildContext context, int i) => listChildren[i],
        padding: EdgeInsets.all(30),
      ),
    );
  }
}

class SizedCard extends StatelessWidget
{
  final double _height, _width;
  final Widget _child;

  SizedCard({double width = 200, double height = 200, @required Widget child}) : _height = height, _width = width, _child = child; 

  Widget build(BuildContext context)
  {
    assert(_child != null);

    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(blurRadius: 10, color: Color(0x40000000), offset: Offset(2,4))
        ]
      ),
      padding: EdgeInsets.all(30),
      child: _child,
    );
  }
}