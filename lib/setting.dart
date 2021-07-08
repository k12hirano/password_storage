import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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
  double fontsize = 20;
  Color fontcolor = Colors.brown[800];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(title: Text('Setting'),
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
                value: statusbar,
                onChanged: (bool value) {
                  setState(() {
                    statusbar = value;
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
                title: Text('Emphasize Password with Color',style: TextStyle(fontSize: fontsize, color: fontcolor)),
                trailing: CupertinoSwitch(
                  activeColor: Colors.lime.shade800,
                  value: PWcolor,
                  onChanged: (bool value) {
                    setState(() {
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
                title: Text('Display on Status Bar',style: TextStyle(fontSize: fontsize, color: fontcolor)),
                trailing: CupertinoSwitch(
                  activeColor: Colors.lime.shade800,
                  value: statusbar,
                  onChanged: (bool value) {
                    setState(() {
                      statusbar = value;
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
              children: <Widget>[
            Text('Display Item',style: TextStyle(fontSize: fontsize, color: fontcolor),),
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
                  displayItem_mm = value;
                });
              },),
                Text('Memo',style: TextStyle(fontSize: fontsize, color: fontcolor)),
              ])),
                ],))
          ],),),
            SizedBox(height: height*0.37,),
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