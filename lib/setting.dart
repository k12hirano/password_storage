import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_storage/Itemkun_repository.dart';
import 'package:password_storage/db.dart';
import 'package:password_storage/settingkun.dart';


class Setting extends StatefulWidget {

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var displayItem_tt = true;
  var displayItem_em = true;
  var displayItem_pw = true;
  var displayItem_ur = true;
  var displayItem_mm = true;
  var PWcolor =false;
  var statusbar = false;
  var PWconseal = false;
  var applicationLock = false;
  double fontsize = 20;
  Color fontcolor = Colors.brown[800];

  lock() async {
    var karioki = await DBProvider().getSetting();
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
    }
  }
  emphasize() async {
    var karioki = await DBProvider().getSetting();
    if(karioki[0].emph ==1){
      DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: 0, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
    }else{
      DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: 1, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
    }
  }
    status() async {
      var karioki = await DBProvider().getSetting();
      if(karioki[0].status == 1){
        DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: 0, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
      }else{
        DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: 1, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
      }
    }
    conseal() async {
      var karioki = await DBProvider().getSetting();
      if(karioki[0].conseal ==1){
        DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: 0, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
      }else{
        DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: 1, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
      }
    }
    display1() async {
      var karioki = await DBProvider().getSetting();
      if(karioki[0].display1 ==1){
        DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: 0, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
      }else{
        DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: 1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
      }
    }
  display2() async {
    var karioki = await DBProvider().getSetting();
    if(karioki[0].display2 ==1){
      DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: 0, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
    }else{
      DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: 1, display3: karioki[0].display3, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
    }
  }
  display3() async {
    var karioki = await DBProvider().getSetting();
    if(karioki[0].display3 ==1){
      DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: 0, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
    }else{
      DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: 1, display4: karioki[0].display4, display5: karioki[0].display5, date: karioki[0].date));
    }
  }
  display4() async {
    var karioki = await DBProvider().getSetting();
    if(karioki[0].display4 ==1){
      DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: 0, display5: karioki[0].display5, date: karioki[0].date));
    }else{
      DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: 1, display5: karioki[0].display5, date: karioki[0].date));
    }
  }
  display5() async {
    var karioki = await DBProvider().getSetting();
    if(karioki[0].display5 ==1){
      DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: 0, date: karioki[0].date));
    }else{
      DBProvider().updateSetting(Settingkun(id: karioki[0].id, lock: karioki[0].lock,emph: karioki[0].emph, status: karioki[0].status, conseal: karioki[0].conseal, display1: karioki[0].display1, display2: karioki[0].display2, display3: karioki[0].display3, display4: karioki[0].display4, display5: 1, date: karioki[0].date));
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
        backgroundColor: Colors.brown[800],
        actions: [
          IconButton(icon: Icon(Icons.close), onPressed: (){
            Navigator.of(context).pop();
          })
        ],
      ),
      body: Center(
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
                          lock();
                          applicationLock = value;
                        });
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
                Container(
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
                  ),),
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
                                          display1();
                                          displayItem_tt = value;
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
                                          display2();
                                          displayItem_em = value;
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
                                    display3();
                                    displayItem_pw = value;
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
                                        display4();
                                        displayItem_ur = value;
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
                                        display5();
                                        displayItem_mm = value;
                                      });
                                    },),
                                    Text('Memo',style: TextStyle(fontSize: fontsize, color: fontcolor)),
                                  ])),
                            ],))
                    ],),),
                SizedBox(height: height*0.21,),
                Container(child:Column(children: <Widget>[
                  Text("※If you can't think of a new password, it'll help you" ,style: TextStyle(fontSize: 17,color: Colors.black54),),
                  SizedBox(height: height*0.005,),
                  Container(
                      height:height*0.07,child: ElevatedButton(child: Text('Create new PASSWORD (semi-auto)',style: TextStyle(fontSize: fontsize, color: Colors.yellow[600]),),
                    style: ElevatedButton.styleFrom(primary: Colors.brown[800]),
                    onPressed: (){},)),
                ]),)
              ],),)
      ),
    );
  }
}