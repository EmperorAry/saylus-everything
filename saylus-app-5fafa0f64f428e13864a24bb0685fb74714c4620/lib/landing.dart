import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jinx/contactmanager.dart';

import './home.dart';

class Landing extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Title(),
          FormContainer(),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.4,
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment(1,0.85), colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor],),
      ),
      alignment: Alignment.bottomCenter,
      child: Text(
        "SAYLUS",
        style: TextStyle(
          color: Colors.white,
          fontSize: 54,
          letterSpacing: 5,
        ),
      ),
      padding: EdgeInsets.fromLTRB(0, 0, 0, height*0.125),
    );
  }
}

class FormContainer extends StatefulWidget
{
  FormCState createState() => FormCState();
}

class FormCState extends State<FormContainer>
{
  Widget build(BuildContext context)
  {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    
    return Container(
      width: width,
      height: height*0.6,
      padding: EdgeInsets.fromLTRB(24, 30, 24, 30),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Welcome, let's get you started!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              height: 1.25,
            ),
          ),
          Form(),
        ],
      ),
    );
  }
}

class Form extends StatelessWidget
{
  BuildContext _currentContext;

  void _loadContactsAndGo()
  {
    ContactManager().tryLoad();
    Navigator.push(_currentContext, CupertinoPageRoute(builder: (BuildContext context) => Home()));
  }

  Widget build(BuildContext context)
  {
    _currentContext = context;

    var height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(blurRadius: 8, color: Color(0x40000000), offset: Offset(2,4))
        ],
      ),
      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
      height: height * 0.45,
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(decoration: InputDecoration(labelText: "Email Address", isDense: false, contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 2),),),
          Divider(height: height*0.01, color: Color(0x00),),
          TextField(decoration: InputDecoration(labelText: "Full Name", isDense: false, contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 2),),),
          Divider(height: height*0.01, color: Color(0x00),),
          TextField(decoration: InputDecoration(labelText: "Set Password",helperText: "Choose a password you won't forget", isDense: false, contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 2),), obscureText: true,),
          Divider(height: height*0.07, color: Color(0x00000000),),
          Center(child: FlatButton(child: Text("Begin!", style: TextStyle(color: Colors.white),), color: Theme.of(context).primaryColor, onPressed: _loadContactsAndGo,),),
        ],
      ),
    );
  }
}