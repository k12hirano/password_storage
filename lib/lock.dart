import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:password_storage/Itemkun_repository.dart';
import 'package:password_storage/db.dart';
import 'package:password_storage/root.dart';
import 'package:password_storage/settingkun.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Lock extends StatefulWidget {


  @override
  _LockState createState() => _LockState();
}

class _LockState extends State<Lock>
//    with WidgetsBindingObserver
{

  StreamController<bool> get _verificationNotifier => StreamController<bool>.broadcast();
  bool isAuthenticated = false;
  bool authentication = false;
  String passcode = '';
  String answer = '';
  String question = '';
  LocalAuthentication auth = LocalAuthentication();
  var passtext = TextEditingController();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool questionOr = false;

  _LockState(){
   // WidgetsBinding.instance.addObserver(this);
    getQuestionpass();
    getPass();
    //getAuth();
    _authenticate();
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

  getAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        authentication =  prefs.getBool('auth');
      });
  }

   getQuestionpass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('questionpass')==null){
      prefs.setBool('questionpass', false);
      questionOr = false;
    }else {
      questionOr = prefs.getBool('questionpass');
    }
  }

  Future<List<BiometricType>> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    return availableBiometrics;
  }

  Future<bool> _authenticate() async {
    bool authenticated = false;
    List<BiometricType> availableBiometricTypes = await _getAvailableBiometrics();
    try {
      if (availableBiometricTypes.contains(BiometricType.face)
          || availableBiometricTypes.contains(BiometricType.fingerprint)) {
        authenticated = await auth.authenticateWithBiometrics(localizedReason: 'Please Approuve');
    } }on PlatformException catch (e) {
      print(e);

    }
    if(authenticated){
      Navigator.pop(context);
    }
  }


    _onPasscodeEntered(String enteredPasscode) async {
      bool isValid = passcode == enteredPasscode;
      _verificationNotifier.add(isValid);
      if (isValid) {
        setState(() {
          this.isAuthenticated = isValid;
        });
        //Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Root()));
      } else {
        setState(() {
          return Text("Wrong passcode");
        });
      }
    }

  errorPassword()async{
    var dialog = await showDialog(context: context, builder: (BuildContext context){
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
      final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;
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
                  child: Text('Wrong Password!',style: TextStyle(fontSize: 24*adjustsizeh,),),),
                Container(
                  height: height*0.1,
                  width: width*0.45,
                  child: ElevatedButton(
                      onPressed: (){Navigator.pop(context);},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.brown[700]
                      ),
                      child: Text('OK',style: TextStyle(fontSize: 20*adjustsizeh,color: Colors.amber[200]),)),)
              ],))
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
    final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;
    return WillPopScope(child: (questionOr==false)?PasscodeScreen(
        title: Text('Enter Passcode',textAlign: TextAlign.center,style: TextStyle(fontSize: 30*adjustsizeh),),
        cancelButton: Text('cancel'), deleteButton: Text('delete'),
        circleUIConfig: CircleUIConfig(
            borderColor: Colors.brown[800],
            fillColor: Colors.brown[700],
            circleSize: 30),
        backgroundColor: Colors.amber[200],
        keyboardUIConfig: KeyboardUIConfig(digitBorderWidth: 2, digitTextStyle: TextStyle(fontSize:30*adjustsizeh, color: Colors.brown[700]),
            deleteButtonTextStyle: TextStyle(fontSize: 15), primaryColor: Colors.brown[800]),
        passwordEnteredCallback: _onPasscodeEntered,
        //cancelCallback: _onPasscodeCancelled,
        //digits: digits,
        passwordDigits: 4, shouldTriggerVerification: _verificationNotifier.stream)
        :Center(child: Container(child:Column(children:<Widget> [
          Container(height: height*0.15,width: width*0.7,child: Text(question, style: TextStyle(fontSize: 28*adjustsizeh),),),
          Container(height: height*0.15,width: width*0.7,child: TextFormField( decoration: InputDecoration(
              labelText: 'answer'),
              controller: passtext,
              //initialValue: vm.isNew ? '' : vm.memo.title,
              //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
              // onChanged: (value) => vm.setTitle(value),
              style: TextStyle(
                  fontSize: 20*adjustsizeh,
                  height: 2*adjustsizeh,
                  color: Colors.brown
              ))),
          Container(height: height*0.15,width: width*0.7,child: ElevatedButton(
            onPressed: (){
              if(passtext.text==answer){
                setState(() {
                  this.isAuthenticated = true;
                });
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Root()));
              }else {
                errorPassword();
              }
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.brown[700]
            ),
            child: Text('OK',style: TextStyle(fontSize: 25*adjustsizeh,color: Colors.amber[200]),),),)
    ],)),), onWillPop:() async => false);
  }
}