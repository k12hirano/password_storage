//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_storage/Itemkun_repository.dart';
import 'package:password_storage/db.dart';
import 'package:password_storage/lock_setting.dart';
import 'package:password_storage/settingkun.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {

  method() {
    _SettingState().initSetting();
  }

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var displayItem_tt=true;
  var displayItem_em=true;
  var displayItem_pw=true;
  var displayItem_ur=true;
  var displayItem_mm=true;
  var PWcolor=false;
  var statusbar=false;
  var PWconseal=false;
  var applicationLock=false;
  double fontsize = 20;
  Color fontcolor = Colors.brown[800];

  bool button = false;

  _SettingState(){
    //TODO
    //applicationLock=false;
    print('construtor,setting');
    initSetting();
  }


  initSetting() async {
    print('initsetting');

    SharedPreferences prefs= await SharedPreferences.getInstance();

    setState(() {
      applicationLock=prefs.getBool('lockonoff') ?? false;
      print(applicationLock);
      statusbar=prefs.getBool('status') ?? false;
      PWconseal=prefs.getBool('conseal') ?? false;
      PWcolor=prefs.getBool('emphasize') ?? false;
      displayItem_tt=prefs.getBool('display1') ?? true;
      displayItem_em=prefs.getBool('display2') ?? true;
      displayItem_pw=prefs.getBool('display3') ?? true;
      displayItem_ur=prefs.getBool('display4') ?? true;
      displayItem_mm=prefs.getBool('display5') ?? true;
    });




  /*  var karioki = await DBProvider().getSetting();
    setState(() {
      //if(karioki[0].lock==1){applicationLock=true;}else{applicationLock=false;}
      if(getPassonoff()){applicationLock=true;}else{applicationLock=false;}
      if(karioki[0].status==1){statusbar=true;}else{statusbar=false;}
      if(karioki[0].emph==1){PWcolor=true;}else{PWcolor=false;}
      if(karioki[0].conseal==1){PWconseal=true;}else{PWconseal=false;}
      if(karioki[0].display1==1){displayItem_tt=true; print('dis_tt'+displayItem_tt.toString());}else{displayItem_tt=false;}
      if(karioki[0].display2==1){displayItem_em=true; print('dis_em'+displayItem_em.toString());}else{displayItem_em=false;}
      if(karioki[0].display3==1){displayItem_pw=true; print('dis_pw'+displayItem_pw.toString());}else{displayItem_pw=false;}
      if(karioki[0].display4==1){displayItem_ur=true; print('dis_ur'+displayItem_ur.toString());}else{displayItem_ur=false;}
      if(karioki[0].display5==1){displayItem_mm=true; print('dis_mm'+displayItem_mm.toString());}else{displayItem_mm=false;}
    });*/

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
    //await prefs.setBool("lockonoff", value);

    if(applicationLock==true){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LockSetting(0, null))).then((value) => setState(() {
        initSetting();
        print('heke');
      }));



    //var dialog = await showDialog(context: context, builder: (BuildContext context){
    //  return AlertDialog(
    //    backgroundColor: Colors.amber[200],
    //    content:
    //    LockChoice(),
    //  );
   // }
    //Navigator.push(context, MaterialPageRoute(builder: (context) => LockChoice()));

   /* var karioki = await DBProvider().getSetting();
    if (karioki[0].lock == 1) {
      DBProvider().updateSetting(Settingkun(id: karioki[0].id,
          lock: 0,
          emph: karioki[0].emph,
          status: karioki[0].status,
          conseal: karioki[0].conseal,
          display1: karioki[0].display1,
          display2: karioki[0].display2,
          display3: karioki[0].display3,
          display4: karioki[0].display4,
          display5: karioki[0].display5,
          date: karioki[0].date));
    } else {
      DBProvider().updateSetting(Settingkun(id: karioki[0].id,
          lock: 1,
          emph: karioki[0].emph,
          status: karioki[0].status,
          conseal: karioki[0].conseal,
          display1: karioki[0].display1,
          display2: karioki[0].display2,
          display3: karioki[0].display3,
          display4: karioki[0].display4,
          display5: karioki[0].display5,
          date: karioki[0].date));
    }*/
    //);
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
    //var karioki = await DBProvider().getSetting();
    //if(karioki[0].emph ==1){
     // DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: 0, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
    //}else{
    //  DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: 1, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
   // }
  }

    setStatus(value) async {
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
     // var karioki = await DBProvider().getSetting();
     // if(karioki[0].status == 1){
     //   DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: 0, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
     // }else{
     //   DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: 1, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
     // }
    }
    setConseal(value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('conseal', value);
    }
    conseal() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.getBool('conseal')){
        setConseal(false);
      } else {
        setConseal(true);
      }
     // var karioki = await DBProvider().getSetting();
     // if(karioki[0].conseal ==1){
     //   DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: 0, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
     // }else{
     //   DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: 1, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
     // }
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
      //var karioki = await DBProvider().getSetting();
      //if(karioki[0].display1 ==1){
      //  DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: 0, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
      //}else{
       // DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: 1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
     // }
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
   // var karioki = await DBProvider().getSetting();
   // if(karioki[0].display2 ==1){
   //   DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: 0, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
   // }else{
   //   DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: 1, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
   // }
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
    //var karioki = await DBProvider().getSetting();
    //if(karioki[0].display3 ==1){
    //  DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: 0, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
    //}else{
    //  DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: 1, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
   // }
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

   //var karioki = await DBProvider().getSetting();
   // if(karioki[0].display4 ==1){
   //   DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: 0, display5: karioki[0].display5, date: karioki[0].date));
   // }else{
    //  DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: 1, display5: karioki[0].display5, date: karioki[0].date));
    //}
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

   /* var karioki = await DBProvider().getSetting();
    if(karioki[0].display5 ==1){
      DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: 0, date: karioki[0].date));
    }else{
      DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: 1, date: karioki[0].date));
    }*/
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
          IconButton(icon: Icon(Icons.close), onPressed: (){
            Navigator.of(context).pop();
          })
        ],
      ),
      body: Center(
          child:SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              //この行を追加
            ),
            height: height*0.9,
            child:Column(
              //shrinkWrap: true,
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
                    title: Row(children: <Widget>[Icon(Icons.enhanced_encryption,size: 30*adjustsizeh,),Text('Application Lock',style: TextStyle(fontSize: fontsize, color: fontcolor))],),
                    trailing: CupertinoSwitch(
                      activeColor: Colors.lime.shade800,
                      value: applicationLock,
                      onChanged: (bool value) {
                        setState(() {
                            applicationLock = value;
                            lock(value);
                          //applicationLock = value;
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
                    title: Row(children: <Widget>[Icon(Icons.font_download),Text('Emphasize Password',style: TextStyle(fontSize: fontsize, color: fontcolor))],),
                    trailing: CupertinoSwitch(
                      activeColor: Colors.lime.shade800,
                      value: PWcolor,
                      onChanged: (bool value) {
                        setState(() {
                          emphasize();
                          PWcolor = value;
                        });
                      },
                    ),
                  ),),
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
                      value: statusbar,
                      onChanged: (bool value) {
                        setState(() {
                          status();
                          statusbar = value;
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
                    title: Row(children: <Widget>[Icon(Icons.star),Text('Conseal Password',style: TextStyle(fontSize: fontsize, color: fontcolor))],),
                    trailing: CupertinoSwitch(
                      activeColor: Colors.lime.shade800,
                      value: PWconseal,
                      onChanged: (bool value) {
                        setState(() {
                          conseal();
                          PWconseal = value;
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
                      Row(mainAxisAlignment:MainAxisAlignment.center,children: <Widget>[Icon(Icons.list),Text('Display Item',style: TextStyle(fontSize: fontsize, color: fontcolor),),]),
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
                                        value: displayItem_tt, onChanged: (bool value) {
                                        setState(() {
                                          if(displayItem_em==false&&displayItem_pw==false&&displayItem_ur==false&&displayItem_mm==false){}else{
                                          display1();
                                          displayItem_tt = value;
                                          }
                                        });
                                      },),
                                      Text('Title',style: TextStyle(fontSize: fontsize, color: fontcolor)),
                                    ]) ),
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
                                      Text('ID,Email,UserName...',style: TextStyle(fontSize: fontsize, color: fontcolor)),
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
                                },),
                                Text('Password',style: TextStyle(fontSize: fontsize, color: fontcolor)),])),
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
                                    },),
                                    Text('URL',style: TextStyle(fontSize: fontsize, color: fontcolor)),])),
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
                                    Text('Memo',style: TextStyle(fontSize: fontsize, color: fontcolor)),
                                  ])),
                            ],))
                    ],),),
                Container(height: height*0.07), // statusの代替要素
                SizedBox(height: height*0.21,),
                (button==true)?Container(
                  height: height*0.1,
                  child:Column(children: <Widget>[
                  Text("※If you can't think of a new password, it'll help you" ,style: TextStyle(fontSize: 17,color: Colors.black54),),
                  SizedBox(height: height*0.005,),
                  Container(
                      height:height*0.07,child: ElevatedButton(child: Text('Create new PASSWORD (semi-auto)',style: TextStyle(fontSize: fontsize, color: Colors.yellow[600]),),
                    style: ElevatedButton.styleFrom(primary: Colors.brown[800]),
                    onPressed: (){},)),
                ]),)
                    :Container(height: height*0.1,)
              ],),))
      ),
    );
  }
}