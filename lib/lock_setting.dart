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
import 'package:password_storage/setting.dart';
import 'package:password_storage/settingkun.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LockSetting extends StatefulWidget {

  final int mode;
  final String passcode;

  LockSetting(this.mode, this.passcode){
    //TODO
  }

  @override
  _LockSettingState createState() => _LockSettingState();
}

class _LockSettingState extends State<LockSetting> {

  bool code;
  bool authentication;
  String passcode;
  final LocalAuthentication auth = LocalAuthentication();
  StreamController<bool> get _verificationNotifier => StreamController<bool>.broadcast();
  //_SupportState _supportState = _SupportState.unknown;
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  //String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool isAuthenticated = false;
  bool error = false;
  bool questionStyle = false;

  @override
  void initState() {
    super.initState();
   // auth.isDeviceSupported().then(
   //       (isSupported) => setState(() => _supportState = isSupported
   //       ? _SupportState.supported
   //       : _SupportState.unsupported),
   // );

    if(widget.mode==2){passcode=widget.passcode;}
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  Future<void> _checkBiometrics() async {
     bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<List<BiometricType>> _getAvailableBiometrics() async {
     List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
    //  availableBiometrics = <BiometricType>[];
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
        authenticated = await auth.authenticateWithBiometrics(localizedReason: "認証してください");
      }
    } on PlatformException catch (e) {
    }
    return authenticated;
  }

  /*Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          localizedReason:
          'Scan your fingerprint (or face or whatever) to authenticate',
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return;
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }*/

  void _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }
  setPassonoff(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("lockonoff", value);
  }

  setPass(String enteredPasscode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lockcode', enteredPasscode);
    setPassonoff(true);
  }


  getPassonoff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      code = prefs.getBool("lockonoff");
    });
  }

  setAuth(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("auth", value);
  }

  getAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authentication = prefs.getBool("auth");
    });
  }

  setQuestion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('questionpass', false);
  }


  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;

    _onPasscodeEntered(String enteredPasscode) async {
      if(widget.mode==2) {
        bool isValid = passcode == enteredPasscode;
        _verificationNotifier.add(isValid);
        if (isValid) {
          setState(() {
            setPass(enteredPasscode);
            setQuestion();
            this.isAuthenticated = isValid;
          });
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
                    height: height*0.07,
                    width: width*0.6,
                    child: Text('Subscribe your Passcode',style: TextStyle(fontSize: 20*adjustsizeh),)),
                Container(
                  //decoration: BoxDecoration(color: Colors.amber[200]),
                  height: height*0.05,
                    width: width*0.6,
                  child:Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[OutlinedButton(onPressed: (){
                    int count = 0;
                    Navigator.popUntil(context, (_) => count++ >= 2);
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Setting()));
                  },style: OutlinedButton.styleFrom(backgroundColor: Colors.brown[800]),
                    child: Text('OK',style: TextStyle(fontSize: 24*adjustsizeh,fontWeight: FontWeight.bold,color: Colors.amber[200]),),),
                  /*OutlinedButton(onPressed:(){
                    _authenticate();
                  }, child: Text('Auth Setting'),)*/
                  ])
                  )
              ],),)
              );
            });
        }else {
          setState(() {
            error=true;
          });
        }
      }
      if(widget.mode==0){Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>LockSetting(2, enteredPasscode)));}

    }

    _onPasscodeCancelled() {
      Navigator.maybePop(context);
    }

    return (questionStyle==false)?PasscodeScreen(title: Column(children:<Widget>[
      (widget.mode==0)?Container(
        height: height*0.05,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoSwitch(
              activeColor: Colors.brown[700],
              value: questionStyle,
              onChanged: (bool value) {
                setState(() {
                  questionStyle= value;
                });
              },
            ),
            Container(child: Text('QUESTION STYLE',style: TextStyle(fontSize: 18),),),
          ],),
      ):Container(height: height*0.05,),
      (widget.mode==0)?Text('Set App Passcode',textAlign: TextAlign.center,style: TextStyle(fontSize: 30*adjustsizeh),)
        :Text('Enter Passcode Again',textAlign: TextAlign.center,style: TextStyle(fontSize: 30*adjustsizeh),),
      (error==false)?Container(height:height*0.1):Container(height: height*0.1,child: Text('Passcode do not match',style: TextStyle(fontSize: 16*adjustsizeh),),)
    ]), cancelButton: Text('cancel',style: TextStyle(fontSize: 20*adjustsizeh,color: Colors.brown[800]),), deleteButton: Text('delete',style: TextStyle(fontSize: 20*adjustsizeh),),
        circleUIConfig: CircleUIConfig(
        borderColor: Colors.brown[800],
        fillColor: Colors.brown[700],
        circleSize: 30),
        backgroundColor: Colors.amber[200],
        keyboardUIConfig: KeyboardUIConfig(digitBorderWidth: 2, digitTextStyle: TextStyle(fontSize: 30*adjustsizeh,color: Colors.brown[700]),
            deleteButtonTextStyle: TextStyle(fontSize: 15), primaryColor: Colors.brown[800]),
        passwordEnteredCallback: _onPasscodeEntered, cancelCallback: _onPasscodeCancelled,
        //digits: digits,
        passwordDigits: 4, shouldTriggerVerification: _verificationNotifier.stream)
    :LockQuestion();
  }

}

class LockChoice extends StatefulWidget {

  @override
  _LockChoiceState createState() => _LockChoiceState();
}

class _LockChoiceState extends State<LockChoice> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;

    return Container(
      //decoration: BoxDecoration(color: Colors.amber[200]),
      height: height*0.2,
      width: width*0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
        Container(height:height*0.07,width: width*0.6,child: ElevatedButton(onPressed:(){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => LockSetting(0, null)));
        },
            style: ElevatedButton.styleFrom(
              primary: Colors.brown[700],
            ),
            child: Text('Num or Auth', style: TextStyle(
          color: Colors.amber[200],
          fontSize: 24*adjustsizeh,
        ),))),
        Container(height:height*0.07,width:width*0.6,child: ElevatedButton(onPressed:(){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => LockQuestion()));
        },
            style: ElevatedButton.styleFrom(
              primary: Colors.brown[700]
            ),
            child: Text('Question Pass', style: TextStyle(
          color: Colors.amber[200],
          fontSize: 24*adjustsizeh,
        ),)))
      ],),
    );
  }
}

class LockQuestion extends StatefulWidget{

  @override
  _LockQuestionState createState() => _LockQuestionState();
}

class _LockQuestionState extends State<LockQuestion> {

  List<DropdownMenuItem> questions = [];
  int selection;
  var questiontext = TextEditingController();
  var answertext = TextEditingController();

  bool questionStyle = true;

  _LockQuestionState(){
    questionSet();
  }

  void questionSet() {
    questions.add(DropdownMenuItem(
      child: Text('Hometown', style: TextStyle(fontSize: 25)),
      value: 1,
    ));
    questions.add(
        DropdownMenuItem(
          child: Text("Your name", style: TextStyle(fontSize: 25)),
          value: 2,
        ));
    questions.add(DropdownMenuItem(
      child: Text('Favorite book', style: TextStyle(fontSize: 25)),
      value: 3,
    ));
    questions.add(DropdownMenuItem(
      child: Text('Nickname', style: TextStyle(fontSize: 25)),
      value: 4,
    ));
    questions.add(DropdownMenuItem(
      child: Text('other(↓write question freely)', style: TextStyle(fontSize: 25),),
      value: 5,
    ));
  }

  enrollPass(String question, String answer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('question', question);
    prefs.setString('answer', answer);
    prefs.setBool('questionpass', true);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;

    errorDialog()async{
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
                    child: Text('Please choose Question',style: TextStyle(fontSize: 24*adjustsizeh,),),),
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


    return Scaffold(
        backgroundColor: Colors.amber[200],
        body:SingleChildScrollView(child:Center(child: Container(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: height*0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CupertinoSwitch(
                    activeColor: Colors.brown[700],
                    value: questionStyle,
                    onChanged: (bool value) {
                      setState(() {
                        questionStyle= value;
                      });
                    },
                  ),
                  Container(child: Text('QUESTION STYLE',style: TextStyle(fontSize: 18),),),
                ],),
            ),
         Container(child: DropdownButton(
          elevation: 10,
          hint: Text('Select Question',style: TextStyle(fontSize: 20*adjustsizeh,),),
          //underline: ,
          //isDense: true,
          dropdownColor: Colors.amber[400],
          items: questions,
          value: selection,
          onChanged: (value) => {
            setState(() {
              selection = value;
            }),
          },
        ),
        ),
      SizedBox(height: height*0.05),
            (selection == 5)?Container(
          height: height*0.15,
          width: width*0.8,
          child: TextFormField(
          decoration: InputDecoration(
          labelText: 'Question'),
          controller: questiontext,
          style: TextStyle(
              fontSize: 20*adjustsizeh,
              height: 2*adjustsizeh,
              color: Colors.brown
          )),):Container(height: height*0.1,width: width*0.8),
            SizedBox(height: height*0.05),
          Container(
            height: height*0.15,
            width: width*0.8,
            child: TextFormField( decoration: InputDecoration(
          labelText: 'Answer'),
          controller: answertext,
          style: TextStyle(
              fontSize: 20*adjustsizeh,
              height: 2*adjustsizeh,
              color: Colors.brown
          )),),
            SizedBox(height: height*0.08),
      Container(
        height: height*0.1,
        width: width*0.8,
        padding: EdgeInsets.fromLTRB(50*adjustsizeh, 10*adjustsizeh, 50*adjustsizeh, 10*adjustsizeh),
        child: ElevatedButton(onPressed: (){if(selection!=null){
          if(selection==1){
            enrollPass('Home town', answertext.text);
          }else if(selection==2){
            enrollPass('Your name', answertext.text);
          }else if(selection==3){
            enrollPass('Favorite book', answertext.text);
          }else if(selection==4){
            enrollPass('Nickname', answertext.text);
          }else if(selection==5){
          enrollPass(questiontext.text, answertext.text);
          }
          int count = 0;
          Navigator.popUntil(context, (_) => count++ >= 2);
        } else {
         errorDialog();
        }}, style: ElevatedButton.styleFrom(
            primary: Colors.brown[700]
        ),
          child: Text('OK', style: TextStyle(fontSize: 25*adjustsizeh, color: Colors.amber[200]),),),)
    ],),),)));
  }
}