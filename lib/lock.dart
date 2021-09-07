import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:password_storage/root.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Lock extends StatefulWidget {

  @override
  _LockState createState() => _LockState();
}

class _LockState extends State<Lock> /* with WidgetsBindingObserver*/ {

  String passcode = '';
  String answer = '';
  String question = '';
  bool questionOr;
  bool isAuthenticated = false;
  bool authentication = false;
  StreamController<bool> get _verificationNotifier => StreamController<bool>.broadcast();
  var passtext = TextEditingController();


  _LockState(){
    getQuestionpass();
    getPass();
    // WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    //WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  getPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('questionpass')==null || prefs.getBool('questionpass')==false){
    passcode =  prefs.getString('lockcode');}else{
    question =  prefs.getString('question');
    answer = prefs.getString('answer');}
  }

   getQuestionpass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var or = prefs.getBool('questionpass');
    if(or==null){
      prefs.setBool('questionpass', false);
      setState(() {
        questionOr = false;
      });
    }else {
      setState(() {
        questionOr = prefs.getBool('questionpass');
      });
    }
  }

  appOn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('appoff',false);
  }

    _onPasscodeEntered(String enteredPasscode) async {
      bool isValid = passcode == enteredPasscode;
      _verificationNotifier.add(isValid);
      if (isValid) {
        appOn();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Root()));
      } else {
        errorPassword();
      }
    }

  errorPassword()async{
    var dialog = await showDialog(context: context, builder: (BuildContext context){
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
      final adjustsizeh = MediaQuery.of(context).size.height*0.0011;
      return AlertDialog(
          backgroundColor: Colors.amber[200],
          content: Container(
              height: height*0.15,
              width: width*0.6,
              child: Column(children: <Widget>[
                Container(
                  height: height*0.04,
                  width: width*0.5,
                  alignment: Alignment.center,
                  child: Text('Wrong Password!',style: TextStyle(fontSize: 24*adjustsizeh))),
                SizedBox(height: height*0.05,),
                Container(
                  height: height*0.05,
                  width: width*0.3,
                  child: ElevatedButton(
                      onPressed: (){Navigator.pop(context);},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.brown[700]
                      ),
                      child: Text('OK',style: TextStyle(fontSize: 20*adjustsizeh,color: Colors.amber[200]))))
              ]))
      );
    });
  }
    //_onPasscodeCancelled() async {}

 /* void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {}else if(state == AppLifecycleState.paused) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Lock()));
    }else if(state == AppLifecycleState.resumed) {
    }
  }*/

  @override
    Widget  build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adjustsizeh = MediaQuery.of(context).size.height*0.0011;
    return Scaffold(
        backgroundColor: Colors.amber[200],
        body:WillPopScope(child: (questionOr==false)?PasscodeScreen(
        title: Text('Enter Passcode',textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30*adjustsizeh)),
        cancelButton: Text('cancel'), deleteButton: Text('delete'),
        circleUIConfig: CircleUIConfig(
            borderColor: Colors.brown[800],
            fillColor: Colors.brown[700],
            circleSize: 30),
        backgroundColor: Colors.amber[200],
        keyboardUIConfig: KeyboardUIConfig(digitBorderWidth: 2, digitTextStyle: TextStyle(fontSize:30*adjustsizeh, color: Colors.brown[700]),
            deleteButtonTextStyle: TextStyle(fontSize: 15*adjustsizeh), primaryColor: Colors.brown[800]),
        passwordEnteredCallback: _onPasscodeEntered,
        //cancelCallback: _onPasscodeCancelled,
        passwordDigits: 4, shouldTriggerVerification: _verificationNotifier.stream)
        :Center(child: SingleChildScrollView(child:Container(child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:<Widget> [
          Container(height: height*0.2,width: width*0.7,child: Text(question, style: TextStyle(fontSize: 26*adjustsizeh))),
          Container(height: height*0.15,width: width*0.7,child: TextFormField( decoration: InputDecoration(
              labelText: 'answer'),
              controller: passtext,
              style: TextStyle(
                  fontSize: 20*adjustsizeh,
                  height: 2*adjustsizeh,
                  color: Colors.brown
              ))),
          SizedBox(height: height*0.1,),
          Container(height: height*0.08,width: width*0.6,child: ElevatedButton(
            onPressed: (){
              if(passtext.text==answer){
                appOn();
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Root()));
              }else {
                errorPassword();
              }
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.brown[700]
            ),
            child: Text('OK',style: TextStyle(fontSize: 25*adjustsizeh,color: Colors.amber[200]))))
    ])))), onWillPop:() async => false));
  }
}