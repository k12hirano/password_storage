import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_storage/lock_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  // ignore: non_constant_identifier_names
  var displayItem_tt=true;
  // ignore: non_constant_identifier_names
  var displayItem_em=true;
  // ignore: non_constant_identifier_names
  var displayItem_pw=true;
  // ignore: non_constant_identifier_names
  var displayItem_ur=true;
  // ignore: non_constant_identifier_names
  var displayItem_mm=true;
  var emphasis=false;
  var status=false;
  var conseal=false;
  var applicationLock=false;
  double fontsize = 20;
  Color fontcolor = Colors.brown[800];
  bool button = false;

  _SettingState(){
    initSetting();
  }


  initSetting() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    setState(() {
      applicationLock=prefs.getBool('lockonoff') ?? false;
      status=prefs.getBool('status') ?? false;
      conseal=prefs.getBool('conseal') ?? false;
      emphasis=prefs.getBool('emphasize') ?? false;
      displayItem_tt=prefs.getBool('display1') ?? true;
      displayItem_em=prefs.getBool('display2') ?? true;
      displayItem_pw=prefs.getBool('display3') ?? true;
      displayItem_ur=prefs.getBool('display4') ?? true;
      displayItem_mm=prefs.getBool('display5') ?? true;
    });
  }

  getPassonoff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('lockonoff');
  }

  lock(bool value) async {
    if(applicationLock==false){
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(value);
    prefs.setBool('lockonoff', false);
    }

    if(applicationLock==true){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LockSetting(0, null))).then((value) => setState(() {
        initSetting();
      }));
    }}

    setEmphasize(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('emphasize', value);
    }
    emphasize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('emphasize')){
      setEmphasize(false);
    }else {
      setEmphasize(true);
    }
  }

    /*setStatus(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('status', value);
    }
    status() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.getBool('status')){
        setStatus(false);
      } else {
        setStatus(true);
      }
    }*/

    setConseal(value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('conseal', value);
    }
    consealOn() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.getBool('conseal')){
        setConseal(false);
      } else {
        setConseal(true);
      }
    }

    setDisplay1(value) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setBool('display1', value);
    }
    display1() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.getBool('display1')){
        setConseal(false);
      }else {
        setConseal(true);
      }
    }

    setDisplay2(value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('display2', value);
    }
  display2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('display2')){
      setDisplay2(false);
    } else {
      setDisplay2(true);
    }
  }

  setDisplay3(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('display3', value);
  }
  display3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('display3')){
      setDisplay3(false);
    }else {
      setDisplay3(true);
    }
  }

  setDisplay4(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('display4', value);
  }
  display4() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('display4')){
      setDisplay4(false);
    }else {
      setDisplay4(true);
    }
  }

  setDisplay5(value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('display5', value);
  }
  display5() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('display5')){
      setDisplay5(false);
    }else {
      setDisplay5(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(title: Text('SETTING'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown[800],
        actions: [
          IconButton(icon: Icon(Icons.close),
          onPressed: (){
            Navigator.of(context).pop();
          })
        ],
      ),
      body: Center(
          child:SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
            ),
            height: height*0.9,
            child:Column(
              children: <Widget>[
                Container(height: height*0.07,
                  decoration: (BoxDecoration(
                    border:  Border(
                      bottom:  BorderSide(
                        color: Colors.brown[700],
                        width: 1,
                      ),
                    ),
                  )),
                  child: ListTile(
                    title: Row(children: <Widget>[
                      Icon(Icons.enhanced_encryption,size: 30*adjustsizeh,),
                      Text('Application Lock',style: TextStyle(fontSize: fontsize*adjustsizeh, color: fontcolor))]),
                    trailing: CupertinoSwitch(
                      activeColor: Colors.lime.shade800,
                      value: applicationLock,
                      onChanged: (bool value) {
                        setState(() {
                            applicationLock = value;
                            lock(value);
                          }
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  height: height*0.07,
                  decoration: (BoxDecoration(
                    border:  Border(
                      bottom:  BorderSide(
                        color: Colors.brown[700],
                        width: 1,
                      ),
                    ),
                  )),
                  child:ListTile(
                    title: Row(children: <Widget>[
                      Icon(Icons.font_download),
                      Text('Emphasize Password',style: TextStyle(fontSize: fontsize*adjustsizeh, color: fontcolor))]),
                    trailing: CupertinoSwitch(
                      activeColor: Colors.lime.shade800,
                      value: emphasis,
                      onChanged: (bool value) {
                        setState(() {
                          emphasize();
                          emphasis = value;
                        });
                      },
                    ),
                  )),
               /* Container(
                  height:height*0.07,
                  decoration: (BoxDecoration(
                    border:  Border(
                      bottom:  BorderSide(
                        color: Colors.brown[700],
                        width: 1,
                      ),
                    ),
                  )),
                  child:ListTile(
                    title: Row(children: <Widget>[Icon(Icons.notifications_none),Text('Display on Status Bar',style: TextStyle(fontSize: fontsize, color: fontcolor))],),
                    trailing: CupertinoSwitch(
                      activeColor: Colors.lime.shade800,
                      value: status,
                      onChanged: (bool value) {
                        setState(() {
                          status();
                          status = value;
                        });
                      },
                    ),
                  ),),*/
                Container(
                  height: height*0.07,
                  decoration: (BoxDecoration(
                    border:  Border(
                      bottom:  BorderSide(
                        color: Colors.brown[700],
                        width: 1,
                      ),
                    ),
                  )),
                  child:ListTile(
                    title: Row(children: <Widget>[
                      Icon(Icons.star),Text('Conseal Password',style: TextStyle(fontSize: fontsize*adjustsizeh, color: fontcolor))]),
                    trailing: CupertinoSwitch(
                      activeColor: Colors.lime.shade800,
                      value: conseal,
                      onChanged: (bool value) {
                        setState(() {
                          consealOn();
                          conseal = value;
                        });
                      },
                    ),
                  ),),
                Container(height: height*0.17,
                  decoration: (BoxDecoration(
                    border:  Border(
                      bottom:  BorderSide(
                        color: Colors.brown[700],
                        width: 1,
                      ),
                    ),
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(mainAxisAlignment:MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.list),
                            Text('Display Item',style: TextStyle(fontSize: fontsize*adjustsizeh, color: fontcolor))]),
                      Container(
                          height: height*0.06,
                          width: width*0.99,
                          child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(child:Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Checkbox(
                                        activeColor: Colors.lime.shade800,
                                        value: displayItem_tt,onChanged: (bool value) {
                                        setState(() {
                                          if(displayItem_em==false&&displayItem_pw==false&&displayItem_ur==false&&displayItem_mm==false){}else{
                                          display1();
                                          displayItem_tt = value;
                                          }
                                        });
                                      }),
                                      Text('Title',style: TextStyle(fontSize: fontsize*adjustsizeh, color: fontcolor)),
                                    ])),
                                Container(child:Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Checkbox(
                                        activeColor: Colors.lime.shade800,
                                        value: displayItem_em, onChanged: (bool value) {
                                        setState(() {
                                          if(displayItem_tt==false&&displayItem_pw==false&&displayItem_ur==false&&displayItem_mm){}else {
                                            display2();
                                            displayItem_em = value;
                                          }
                                        });
                                      },),
                                      Text('ID,Email,UserName...',style: TextStyle(fontSize: fontsize*adjustsizeh, color: fontcolor)),
                                    ]))])),
                      Container(
                          height: height*0.06,
                          width: width*0.99,
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(child:Row(children: <Widget>[
                                Checkbox(
                                  activeColor: Colors.lime.shade800,
                                  value: displayItem_pw, onChanged: (bool value) {
                                  setState(() {
                                    if(displayItem_em==false&&displayItem_tt==false&&displayItem_ur==false&&displayItem_mm){}else {
                                      display3();
                                      displayItem_pw = value;
                                    }
                                  });
                                }),
                                Text('Password',style: TextStyle(fontSize: fontsize*adjustsizeh, color: fontcolor))
                              ])),
                              Container(child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Checkbox(
                                      activeColor: Colors.lime.shade800,
                                      value: displayItem_ur, onChanged: (bool value) {
                                      setState(() {
                                       if(displayItem_em==false&&displayItem_pw==false&&displayItem_tt==false&&displayItem_mm){}else {
                                         display4();
                                         displayItem_ur = value;
                                       }
                                      });
                                    }),
                                    Text('URL',style: TextStyle(fontSize: fontsize*adjustsizeh, color: fontcolor))])),
                              Container(child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Checkbox(
                                      activeColor: Colors.lime.shade800,
                                      value: displayItem_mm, onChanged: (bool value) {
                                      setState(() {
                                        if(displayItem_em==false&&displayItem_pw==false&&displayItem_ur==false&&displayItem_tt==false){}else {
                                          display5();
                                          displayItem_mm = value;
                                        }
                                      });
                                    },),
                                    Text('Memo',style: TextStyle(fontSize: fontsize*adjustsizeh, color: fontcolor)),
                                  ])),
                            ]))
                    ])),
                Container(height: height*0.07), // statusの代替要素
                SizedBox(height: height*0.21,),
                (button==true)?Container(
                  height: height*0.1,
                  child:Column(children: <Widget>[
                  Text("※If you can't think of a new password, it'll help you" ,style: TextStyle(fontSize: 17*adjustsizeh,color: Colors.black54)),
                  SizedBox(height: height*0.005,),
                  Container(
                      height:height*0.07,
                      child: ElevatedButton(
                          child: Text('Create new PASSWORD (semi-auto)',style: TextStyle(fontSize: fontsize*adjustsizeh, color: Colors.yellow[600])),
                    style: ElevatedButton.styleFrom(primary: Colors.brown[800]),
                    onPressed: (){})),
                ]))
                    :Container(height: height*0.1)
              ])))
      ),
    );
  }
}