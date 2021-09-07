import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LockSetting extends StatefulWidget {

  final int mode;
  final String passcode;
  LockSetting(this.mode, this.passcode);

  @override
  _LockSettingState createState() => _LockSettingState();
}

class _LockSettingState extends State<LockSetting> {

  String passcode;
  int selection;
  bool error = false;
  bool questionStyle = false;
  List<DropdownMenuItem> questions = [];
  StreamController<bool> get _verificationNotifier => StreamController<bool>.broadcast();
  var questiontext = TextEditingController();
  var answertext = TextEditingController();

  _LockSettingState() {
    questionSet();
  }

  @override
  void initState() {
    super.initState();
    if(widget.mode==2){passcode=widget.passcode;}
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  setPassonoff(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("lockonoff", value);
    prefs.setBool('questionpass', false);
  }

  setPass(String enteredPasscode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lockcode', enteredPasscode);
    setPassonoff(true);
  }

  setQuestion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('questionpass', true);
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
      child: Text('other(↓write question freely)', style: TextStyle(fontSize: 25)),
      value: 5,
    ));
  }

  enrollPass(String question, String answer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('lockonoff', true);
    prefs.setString('question', question);
    prefs.setString('answer', answer);
    prefs.setBool('questionpass', true);

    var dialog = await showDialog(context: context, builder: (BuildContext context){
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
      final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;
      return AlertDialog(
          backgroundColor: Colors.amber[200],
          content: WillPopScope(child:Container(
            height: height*0.14,
            width: width*0.6,
            child: Column(children: <Widget>[
              Container(
                  height: height*0.07,
                  width: width*0.6,
                  child: Text(' Subscribe your Passcode',style: TextStyle(fontSize: 20*adjustsizeh, fontWeight: FontWeight.w500))),
              Container(
                  height: height*0.05,
                  width: width*0.6,
                  child:Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            height: height*0.5,
                            width: width*0.2,
                            child:OutlinedButton(onPressed: (){
                              int count = 0;
                              Navigator.popUntil(context, (_) => count++ >= 3);
                            },style: OutlinedButton.styleFrom(backgroundColor: Colors.brown[800]),
                              child: Text('OK',style: TextStyle(fontSize: 24*adjustsizeh,fontWeight: FontWeight.w500,color: Colors.amber[200])))),
                      ])
              )
            ])),onWillPop:() async => false));
    });
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
          });
            var dialog = await showDialog(context: context, builder: (BuildContext context){
              final height = MediaQuery.of(context).size.height;
              final width = MediaQuery.of(context).size.width;
              final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;
              return AlertDialog(
                  backgroundColor: Colors.amber[200],
                  content: WillPopScope(child:Container(
                height: height*0.14,
                width: width*0.6,
                child: Column(children: <Widget>[
                Container(
                    height: height*0.07,
                    width: width*0.6,
                    child: Text(' Subscribe your Passcode',style: TextStyle(fontSize: 20*adjustsizeh, fontWeight: FontWeight.w500),)),
                Container(
                  height: height*0.05,
                    width: width*0.6,
                  child:Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: height*0.5,
                          width: width*0.2,
                          child:OutlinedButton(onPressed: (){
                                 int count = 0;
                                Navigator.popUntil(context, (_) => count++ >= 3);
                          },style: OutlinedButton.styleFrom(backgroundColor: Colors.brown[800]),
                          child: Text('OK',style: TextStyle(fontSize: 24*adjustsizeh,fontWeight: FontWeight.w500,color: Colors.amber[200]),),)),
                  ])
                  )
              ],),),onWillPop:() async => false)
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

    _onPasscodeCancelled() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('lockonoff', false);
      Navigator.maybePop(context);
    }

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
                    child: Text('Please choose Question',style: TextStyle(fontSize: 24*adjustsizeh))),
                  Container(
                    height: height*0.1,
                    width: width*0.45,
                    child: ElevatedButton(
                        onPressed: (){Navigator.pop(context);},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.brown[700]
                        ),
                        child: Text('OK',style: TextStyle(fontSize: 20*adjustsizeh,color: Colors.amber[200]))))
                ],))
        );
      });
    }

    return Scaffold(
        backgroundColor: Colors.amber[200],
        body:(questionStyle==false)?PasscodeScreen(title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:<Widget>[
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
            SizedBox(height: height*0.1),
      (widget.mode==0)?Text('Set App Passcode',textAlign: TextAlign.center,style: TextStyle(fontSize: 30*adjustsizeh))
        :Text('Enter Passcode Again',textAlign: TextAlign.center,style: TextStyle(fontSize: 30*adjustsizeh)),
      (error==false)?Container(height:height*0.1):Container(height: height*0.1,child: Text('Passcode do not match',style: TextStyle(fontSize: 16*adjustsizeh)))
    ]), cancelButton: Text('cancel',style: TextStyle(fontSize: 20*adjustsizeh,color: Colors.brown[800]),),
        deleteButton: Text('delete',style: TextStyle(fontSize: 20*adjustsizeh),),
        circleUIConfig: CircleUIConfig(
        borderColor: Colors.brown[800],
        fillColor: Colors.brown[700],
        circleSize: 30),
        backgroundColor: Colors.amber[200],
        keyboardUIConfig: KeyboardUIConfig(digitBorderWidth: 2,
            digitTextStyle: TextStyle(fontSize: 30*adjustsizeh,color: Colors.brown[700]),
            deleteButtonTextStyle: TextStyle(fontSize: 15), primaryColor: Colors.brown[800]),
        passwordEnteredCallback: _onPasscodeEntered, cancelCallback: _onPasscodeCancelled,
        passwordDigits: 4, shouldTriggerVerification: _verificationNotifier.stream)
    :Center(child:SingleChildScrollView(child: Container(
          child: Column(
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
              Container(child: Text('QUESTION STYLE',style: TextStyle(fontSize: 18))),
            ],),
        ),
        SizedBox(height: height*0.15,),
        Container(
          height: height*0.07,
          child: DropdownButton(
          elevation: 10,
          hint: Text('Select Question',style: TextStyle(fontSize: 20*adjustsizeh)),
          dropdownColor: Colors.amber[300],
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
              ))),
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
          } else {
            errorDialog();
          }}, style: ElevatedButton.styleFrom(
              primary: Colors.brown[700]
          ),
            child: Text('OK', style: TextStyle(fontSize: 25*adjustsizeh, color: Colors.amber[200]))))
      ])))));
  }
}
