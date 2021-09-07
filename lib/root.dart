import 'dart:async';
import 'package:flutter/material.dart';
import 'package:password_storage/Itemkun.dart';
import 'package:password_storage/db.dart';
import 'package:password_storage/item.dart';
import 'package:password_storage/lock.dart';
import 'package:password_storage/setting.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Root extends StatefulWidget {

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root>  with WidgetsBindingObserver  {

  final fontsize = 16;
  final iconsize = 13;
  int choice;
  double displayHeight = 5.0;
  String _value;
  String get searchText => searchtext.text;
  bool lock;
  bool emphasis;
  bool status;
  bool conseal;
  bool appoffState;
  bool display1 =true;
  bool display2 =true;
  bool display3 =true;
  bool display4 =true;
  bool display5 = true;
  bool unlock = false;
  bool favoriteOnly=false;
  bool orderDate=true;
  bool orderTitle=false;
  bool orderID=false;
  bool orderPass=false;
  bool deleteon = false;
  bool consealjudge=true;
  Color fontcolor = Colors.brown[800];
  List<String> consealpassList=[];
  List<bool> deleteCheckList =[];
  var searchtext = TextEditingController();
  // ignore: non_constant_identifier_names
  final _ItemsChange = StreamController();
  final favorite = Set<int>();
  final deleteValueList = Set<String>();

  _RootState() {
    checkOff();
  if(appoffState==true){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Lock()));
  }
    getPassonff();
    if(getPassonff()==true&&unlock==false){
      unlock=true;gotoLock();
     }else{
      streamIn();
      WidgetsBinding.instance.addObserver(this);}
  }


  @override
  void dispose() {
    appOff();
    /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Lock()));*/
    _ItemsChange.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  streamIn() async{
    _streamController = StreamController<List<Itemkun>>();
    List<Itemkun> karioki=[];
    if(favoriteOnly==false){
      if(choice==1 || choice==null){
        karioki = await DBProvider().search(null);}
      else if(choice==2){
        karioki = await DBProvider().searchBytitle(null);
      }else if(choice==3){
        karioki = await DBProvider().searchByid(null);
      }else if(choice==4){
        karioki = await DBProvider().searchBypass(null);
      }
    }
    else{
      if(choice==1 || choice==null) {
        karioki = await DBProvider().searchFAV(null);
      }else if(choice==2){
        karioki = await DBProvider().searchBytitleFAV(null);
      }else if(choice==3){
        karioki = await DBProvider().searchByidFAV(null);
      }else if(choice==4){
        karioki = await DBProvider().searchBypassFAV(null);
      }
    }
    _streamController.add(karioki);
    if(deleteCheckList.length != 0){
      deleteCheckList.removeRange(0, deleteCheckList.length);
    }
    for(var i=0;i<karioki.length;i++){
      deleteCheckList.add(false);
    }
    SettingInit();

    if(favorite.isNotEmpty){
      favorite.clear();
    }
    if(karioki!=null || karioki.length!=0){
      for(var i=0;i<karioki.length;i++){
        if(karioki[i].favorite==1){
          favorite.add(karioki[i].id);
        }
      }
    }
    choiceCheck();
  }

  appOff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('appoff',true);
  }

  checkOff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appoffState = prefs.getBool('appoff');
  }

  chosen(int choice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('choice', choice);
  }
  choiceCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    choice = prefs.getInt('choice');
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive && lock == true) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Lock()));
    }else if(state == AppLifecycleState.paused && lock==true) {

    }else if(state == AppLifecycleState.resumed && lock ==true) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Lock()));
    }else if(state == AppLifecycleState.detached && lock == true) {
      appOff();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Lock()));
    }
  }

  StreamController<List<Itemkun>> _streamController;
  set(String name){
    _value = name;
  }

  getPassonff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('lockonoff')!=null){
      lock = prefs.getBool('lockonoff');
    } else {
      lock = false;
    }
    return prefs.getBool("lockonoff");
  }

  gotoLock() {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>Lock()));
  }

  // ignore: non_constant_identifier_names
  SettingInit() async{
    displayHeight=5.0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('status')==null){status=false; prefs.setBool('status', false);
    }else if(prefs.getBool('status')){status=true;}else{status=false;}
    if(prefs.getBool('emphasize')==null){emphasis=false; prefs.setBool('emphasize', false);
    }else if(prefs.getBool('emphasize')){emphasis=true;}else{emphasis=false;}
    if(prefs.getBool('conseal')==null){conseal=false; prefs.setBool('conseal', false);
    }else if(prefs.getBool('conseal')){conseal=true;}else{conseal=false;}
    if(prefs.getBool('display1')==null){display1=true; prefs.setBool('display1', true);
    }else if(prefs.getBool('display1')){display1=true;}else{display1=false;displayHeight--;}
    if(prefs.getBool('display2')==null){display2=true; prefs.setBool('display2', true);
    }else if(prefs.getBool('display2')){display2=true;}else{display2=false;displayHeight--;}
    if(prefs.getBool('display3')==null){display3=true; prefs.setBool('display3', true);
    }else if(prefs.getBool('display3')){display3=true;}else{display3=false;displayHeight--;}
    if(prefs.getBool('display4')==null){display4=true; prefs.setBool('display4', true);
    }else if(prefs.getBool('display4')){display4=true;}else{display4=false;displayHeight--;}
    if(prefs.getBool('display5')==null){display5=true; prefs.setBool('display5', true);
    }else if(prefs.getBool('display5')){display5=true;}else{display5=false;displayHeight--;}
  }

  onchanging(String keyword) async {
    List<Itemkun> karioki0 = [];
    if(favoriteOnly==false){
      if(choice==1 || choice==null){
        karioki0 = await DBProvider().search(keyword);
      }else if(choice==2){
        karioki0 = await DBProvider().searchBytitle(keyword);
      }else if(choice==3){
        karioki0 = await DBProvider().searchByid(keyword);
      }else if(choice==4){
        karioki0 = await DBProvider().searchBypass(keyword);
      }
    }else{
      if(choice==1 || choice==null){
        karioki0 = await DBProvider().searchFAV(keyword);
      }else if(choice==2){
        karioki0 = await DBProvider().searchBytitleFAV(keyword);
      }else if(choice==3){
        karioki0 = await DBProvider().searchByidFAV(keyword);
      }else if(choice==4){
        karioki0 = await DBProvider().searchBypassFAV(keyword);
      }
    }
    _streamController.add(karioki0);

    if(favorite.isNotEmpty){
     favorite.clear();
    }
    for(var i=0;i<karioki0.length;i++){
      if(karioki0[i].favorite==1){
        favorite.add(karioki0[i].id);
      }
    }
  }

  deleteflg() {
    setState(() {
      if(deleteon==false){
      deleteon = true;
      }else {
        deleteon =false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;

    deleteOn() {
      if(deleteValueList.length != 0) {
        final List<String> forDelete = deleteValueList.toList();
        for (var i = 0; i < deleteValueList.length; i++) {
          DBProvider().delete(int.parse(forDelete[i]));
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        elevation: 8,
        leading:(deleteon==false)?IconButton(
          icon:Icon(Icons.settings)
          ,onPressed:() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>Setting()),
          ).then((value) => setState(() {
            streamIn();
          }));
        }):Container(),
        centerTitle: true,
        title:Text("PASSWORDLIST",style: TextStyle(color: Colors.yellow[200])),
        backgroundColor: Colors.brown[800],
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child:PopupMenuButton(
              icon: Icon(Icons.shuffle),
              initialValue: choice,
              onSelected: (value){
                setState(() {
                  if(choice==null){choice=1;}
                  var karioki=choice;
                  choice = value;
                  if(choice==5){choice=karioki;
                  if(favoriteOnly==false){favoriteOnly=true;}else{favoriteOnly=false;}
                  }
                  chosen(value);
                  streamIn();
                });
              },
              itemBuilder: (BuildContext context) {
                return[
                  PopupMenuItem(
                    child: Text('Date'),
                    value: 1,
                     enabled: (choice==1)?false:true),
                    PopupMenuItem(
                      child: Text('Name(title)'),
                      value: 2,
                      enabled: (choice==2)?false:true,
                    ),
                  PopupMenuItem(
                    child: Text('Name(ID)'),
                  value: 3,
                    enabled: (choice==3)?false:true,
                  ),
                  PopupMenuItem(
                      child: Text('Name(pass)'),
                  value: 4,
                    enabled: (choice==4)?false:true,
                  ),
                  (favoriteOnly==true) ?PopupMenuItem(
                    child: Row(children: <Widget>[
                    Text('favorite'),
                    SizedBox(width: width*0.05,),
                    Icon(Icons.check,color: Colors.brown[800],)
                  ]),
                  value: 5,)
                      :PopupMenuItem(child: Row(children: <Widget>[
                    Text('favorite')
                  ]),
                    value: 5,)
                  ];
              },
            ) ,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: (deleteon == false)?IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => {
                  deleteflg()
                },
            )
            :IconButton(
              icon: Icon(Icons.close),
              onPressed: (){
                setState(() {
                  deleteflg();
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: (deleteon == false)?FloatingActionButton(
        child:Icon(Icons.add,color: Colors.amber[200],),backgroundColor: Colors.brown[700] ,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                Item(
                    0,
                    null
                )),
          ).then((value) =>
              setState(() {
                streamIn();
              }));
        })
        :Container(),
      body: (deleteon == false) ?Center(
            child:Container(
              decoration: BoxDecoration(
                color: Colors.amber[200]
              ),
             child:Column(children:<Widget>[
               Container(
                 padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                   height: height*0.07,
                   child:TextField(
                     controller: searchtext,
                 style: TextStyle(color: Colors.brown[700]),
                 decoration: InputDecoration(
                   prefixIcon: Icon(Icons.search, color: Colors.brown[700]),
                   hintText: 'search',
                   hintStyle: TextStyle(color: Colors.brown[700], fontSize: 20*adjustsizeh),
                 ),
                 onChanged:
                     (value){
                       onchanging(value);
                       },
                  )),
                Expanded(
                   child:
                   StreamBuilder(
                    stream: _streamController.stream,
          // ignore: missing_return
          builder: (context, snapshot){
             if(snapshot.connectionState == ConnectionState.waiting){
               return Center(child:Container(height:height*0.1,width: width*0.3,
                   child:CircularProgressIndicator()));
             }
            if(!snapshot.hasData){
              return Container();
            }
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  final itemlist00 = snapshot.data;
                  final itemkun = itemlist00[index];
                  final favoriteCheck = favorite.contains(itemkun.id);
                  return (itemkun.memostyle==0)?InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(
                        context,
                          MaterialPageRoute(builder: (context) =>Item(
                          1,
                          itemkun.id
                        )),
                      ).then((value) => setState(() {
                        streamIn();
                      }));
                    },
                    onLongPress: () async {
                      var dialog = await showDialog(context: context, builder: (BuildContext context){
                        return SimpleDialog(children: <Widget>[
                          SimpleDialogOption(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>Item(
                                  1,
                                  itemkun.id
                              )),
                            ).then((value) => setState(() {
                              streamIn();
                            }));
                          },child: Container(
                            height:height*0.05,
                            width:width*0.4,
                            alignment:Alignment.center,
                        decoration: BoxDecoration(
                        color: Colors.brown[700],
                        border: Border.all(
                        color: Colors.brown[800],
                        width:1,
                        )),
                            child:Text('edit',style: TextStyle(fontSize: 22, color: Colors.yellow[200])))),
                          SimpleDialogOption(onPressed: (){
                            DBProvider().insert(
                                Itemkun(
                                    title: itemkun.title,
                                    email: itemkun.email,
                                    pass: itemkun.pass,
                                    url: itemkun.url,
                                    memo: itemkun.memo,
                                    memostyle: itemkun.memostyle,
                                    date: DateTime.now().toString()));
                            Navigator.pop(context);
                          },child: Container(
                        height:height*0.05,
                        width:width*0.4,
                            alignment:Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.brown[700],
                                border: Border.all(
                                  color: Colors.brown[800],
                                  width:1,
                                )),
                        child:Text('copy', style: TextStyle(fontSize: 22, color: Colors.yellow[200]),),)),
                          SimpleDialogOption(onPressed: (){
                            DBProvider().delete(itemkun.id);
                            Navigator.pop(context);
                            setState(() {
                               streamIn();
                            });
                          },child: Container(
                        height:height*0.05,
                        width:width*0.4,
                            alignment:Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.brown[700],
                                border: Border.all(
                                  color: Colors.brown[800],
                                  width:1,
                                )),
                        child:Text('delete', style: TextStyle(fontSize: 22, color: Colors.yellow[200]))))
                        ]);
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        height: height*0.02+height*0.03*displayHeight,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      (display1 == true)?Container(
                                          width:width*0.85,
                                          decoration: BoxDecoration(
                                              border: Border(
                                              bottom: BorderSide(
                                                color: Colors.white,
                                                width:1,
                                              )
                                          )),
                                          height: height*0.03,
                                          child:Row(children:<Widget>[SizedBox(width: width*0.05,),Text(itemkun.title,
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 16*adjustsizeh),
                                          )])):Container(),
                                      (display2 == true)?Container(
                                          height: height*0.025,
                                          child: Row(children:<Widget>[Text(
                                            'ID/Email: '
                                                +itemkun.email,
                                            style: TextStyle(fontSize:fontsize*adjustsizeh, color: Colors.black54, fontWeight: FontWeight.w600)),
                                            (itemkun.email.length != 0) ?IconButton(icon: Icon(Icons.copy,size: iconsize*adjustsizeh,),
                                                onPressed:(){
                                              if(itemkun.email.length != 0){
                                              ClipboardManager.copyToClipBoard(
                                                  itemkun.email);}
                                            })
                                                :Container(),
                                          ])):Container(),
                                      (display3 == true)?Container(
                                        height: height*0.025,
                                        width: width*0.6,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Text("PASSWORD: ",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: fontsize*adjustsizeh,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black54)),
                                            ),
                                            Container(
                                              child:(conseal==false)?Text(itemkun.pass,
                                                style: TextStyle(
                                                    fontSize: 16*adjustsizeh,
                                                    fontWeight: FontWeight.bold,
                                                    color:(emphasis == true)? Colors.blue :Colors.black54),
                                              ):Text('********',
                                                style: TextStyle(
                                                    fontSize: 16*adjustsizeh,
                                                    fontWeight: FontWeight.bold,
                                                    color:(emphasis == true)? Colors.blue :Colors.black54)),
                                            ),
                                            (itemkun.pass.length != 0) ?IconButton(icon: Icon(Icons.copy,size: iconsize*adjustsizeh),
                                              onPressed: (){
                                              if(itemkun.pass.legth != 0){
                                                ClipboardManager.copyToClipBoard(
                                                    itemkun.pass);}
                                            },)
                                                :Container(),
                                          ],
                                        ),
                                      ):Container(),
                                      (display4 == true)?Container(
                                          height: height*0.02,
                                          width: width*0.65,
                                          child:
                                          Row(children: <Widget>[
                                            Flexible(
                                            child:Text(itemkun.url,
                                              style: TextStyle(
                                                fontSize: 16*adjustsizeh,
                                                color: Colors.brown[800],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                            (itemkun.url.length != 0)?IconButton(icon: Icon(Icons.copy, size: iconsize*adjustsizeh),
                                              onPressed: (){
                                              if(itemkun.pass.legth != 0){
                                                ClipboardManager.copyToClipBoard(
                                                    itemkun.url);}
                                            },)
                                                :Container()
                                          ])):Container(),
                                      (display5 == true)?Container(
                                        height: height*0.025,
                                        width: width*0.7,
                                              child:Row(children:<Widget>[
                                                SizedBox(width: width*0.03,),
                                              Flexible(
                                                child:Text(itemkun.memo,
                                                  style: TextStyle(
                                                    fontSize: 14*adjustsizeh,
                                                    color: Colors.brown[800],
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              Container(),
                                              ])
                                      ):Container(),
                                    ])
                              ),
                              Container(
                                height: height*0.15,
                                decoration: BoxDecoration(
                                ),
                                child: Row(children: <Widget>[
                                  SizedBox(width: width*0.02),
                                  GestureDetector(
                                      onTap: () {
                                        if(favoriteCheck){
                                          DBProvider().update(
                                              Itemkun(
                                                  id: itemkun.id,
                                                  title:itemkun.title,
                                                  email:itemkun.email,
                                                  pass: itemkun.pass,
                                                  url: itemkun.url,
                                                  memo: itemkun.memo,
                                                  favorite: 0,
                                                  memostyle:itemkun.memostyle,
                                                  date: DateTime.now().toString()) ,
                                              itemkun.id);
                                          setState(() {
                                            favorite.remove(itemkun.id);
                                          });
                                        }else{
                                          DBProvider().update(
                                              Itemkun(
                                                  id: itemkun.id,
                                                  title:itemkun.title,
                                                  email:itemkun.email,
                                                  pass: itemkun.pass,
                                                  url: itemkun.url,
                                                  memo: itemkun.memo,
                                                  favorite: 1,
                                                  memostyle: itemkun.memostyle,
                                                  date: DateTime.now().toString()),
                                              itemkun.id);
                                          setState(() {
                                            favorite.add(itemkun.id);
                                          });
                                        }
                                      },
                                      child:(favoriteCheck)?Icon(Icons.favorite,color: Colors.brown[700], size: 30*adjustsizeh,)
                                          :Icon(Icons.favorite_border, color: Colors.brown[700], size: 30*adjustsizeh,)
                                  ),
                                  SizedBox(width: width*0.025),
                                ]),
                              ),
                            ]),
                      ),
                    ),
                  ):InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                       Navigator.push(
                        context,
                       MaterialPageRoute(builder: (context) =>Item(
                         1,
                        itemkun.id
                       )),
                      ).then((value) => setState(() {
                       streamIn();
                      }));
                    },
                    onLongPress: () async {
                      var dialog = await showDialog(context: context, builder: (BuildContext context){
                        return SimpleDialog(children: <Widget>[
                          SimpleDialogOption(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>Item(
                                  1,
                                  itemkun.id
                              )),
                            ).then((value) => setState(() {
                              streamIn();
                            }));
                          },child: Container(
                            height:height*0.05,
                            width:width*0.4,
                            alignment:Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.brown[700],
                                border: Border.all(
                                  color: Colors.brown[800],
                                  width:1,
                                )),
                            child:Text('edit',style: TextStyle(fontSize: 22, color: Colors.yellow[200])))),
                          SimpleDialogOption(onPressed: (){
                            DBProvider().insert(
                                Itemkun(
                                    title: itemkun.title,
                                    email: itemkun.email,
                                    pass: itemkun.pass,
                                    url: itemkun.url,
                                    memo: itemkun.memo,
                                    memostyle: itemkun.memostyle,
                                    date: DateTime.now().toString()));
                            Navigator.pop(context);
                          },child: Container(
                            height:height*0.05,
                            width:width*0.4,
                            alignment:Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.brown[700],
                                border: Border.all(
                                  color: Colors.brown[800],
                                  width:1,
                                )),
                            child:Text('copy', style: TextStyle(fontSize: 22, color: Colors.yellow[200])))),
                          SimpleDialogOption(onPressed: (){
                            DBProvider().delete(itemkun.id);
                            Navigator.pop(context);
                            setState(() {
                              streamIn();
                            });
                          },child: Container(
                            height:height*0.05,
                            width:width*0.4,
                            alignment:Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.brown[700],
                                border: Border.all(
                                  color: Colors.brown[800],
                                  width:1,
                                )),
                            child:Text('delete', style: TextStyle(fontSize: 22, color: Colors.yellow[200]))))
                        ],);
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        height: height*0.02+height*0.03*displayHeight,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height:height*0.016),
                                      Container(
                                          height: height*0.013+height*0.02*displayHeight,
                                          width: width*0.7,
                                          alignment: Alignment.topLeft,
                                          child:Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:<Widget>[
                                            SizedBox(width: width*0.03,),
                                            Flexible(
                                              child:Text(itemkun.memo,
                                                style: TextStyle(
                                                  fontSize: 16*adjustsizeh,
                                                  color: Colors.brown[800],
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 5,
                                              ),
                                            ),
                                          ])
                                     )
                                    ])
                              ),
                              Container(
                                height: height*0.15,
                                decoration: BoxDecoration(
                                ),
                                child: Row(children: <Widget>[
                                  SizedBox(width: width*0.02),
                                  GestureDetector(
                                      onTap: () {
                                        if(favoriteCheck){
                                          DBProvider().update(
                                              Itemkun(
                                                  id: itemkun.id,
                                                  title:itemkun.title,
                                                  email:itemkun.email,
                                                  pass: itemkun.pass,
                                                  url: itemkun.url,
                                                  memo: itemkun.memo,
                                                  favorite: 0,
                                                  memostyle:itemkun.memostyle,
                                                  date: DateTime.now().toString()),
                                              itemkun.id);
                                          setState(() {
                                            favorite.remove(itemkun.id);
                                          });
                                        }else{
                                          DBProvider().update(
                                              Itemkun(
                                                  id: itemkun.id,
                                                  title:itemkun.title,
                                                  email:itemkun.email,
                                                  pass: itemkun.pass,
                                                  url: itemkun.url,
                                                  memo: itemkun.memo,
                                                  favorite: 1,
                                                  memostyle: itemkun.memostyle,
                                                  date: DateTime.now().toString()),
                                              itemkun.id);
                                          setState(() {
                                            favorite.add(itemkun.id);
                                          });
                                        }
                                      },
                                      child:(favoriteCheck)?Icon(Icons.favorite,color: Colors.brown[700], size: 30*adjustsizeh)
                                          :Icon(Icons.favorite_border, color: Colors.brown[700], size: 30*adjustsizeh)
                                  ),
                                  SizedBox(width: width*0.025),
                                ]),
                              ),
                            ]),
                      ),
                    ),
                  );
                },
              );
            }
          }
      )
                ),
           ]))
    )
          :Center(
          child:Container(
              decoration: BoxDecoration(
                  color: Colors.amber[200]
              ),
              child:Column(children:<Widget>[
                Container(
                  height: height*0.07,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget> [
                  ElevatedButton(onPressed: (){
                    setState(() {
                      for(var i=0;i<deleteCheckList.length;i++){
                        deleteCheckList[i]=true;
                      }
                    });
                  }, child: Text('all check', style: TextStyle(color: Colors.yellow[200])),
                      style: ElevatedButton.styleFrom(
                    primary: Colors.brown,
                  )),
                  SizedBox(width: width*0.2,),
                  ElevatedButton(onPressed: (){
                    setState(() {
                      for(var i=0;i<deleteCheckList.length;i++){
                        deleteCheckList[i]=false;
                      }
                    });
                  }, child: Text('all clear',style: TextStyle(color: Colors.yellow[200])),
                    style: ElevatedButton.styleFrom(
            primary: Colors.brown,
          ))
                ])),
                Expanded(
                    child: StreamBuilder(
                        stream: _streamController.stream,
                        // ignore: missing_return
                        builder: (context, snapshot){
                          if(!snapshot.hasData){
                            return Container();
                          }
                          if(snapshot.hasData){
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index){
                                final itemlist00 = snapshot.data;
                                final itemkun = itemlist00[index];
                                return Container(child:Row(children:<Widget>[
                                  Container(
                                    height:height*0.15*0.7,
                                    width:width*0.1,
                                    child: Checkbox(
                                      activeColor: Colors.brown,
                                      value: deleteCheckList[index],
                                      onChanged: (value){
                                        setState(() {
                                          if(value) {
                                            deleteCheckList[index] = value;
                                            if(deleteValueList.contains(itemkun.id.toString())==false){
                                            deleteValueList.add(itemkun.id.toString());
                                            }
                                          }
                                         else{
                                            deleteCheckList[index] = value;
                                            if(deleteValueList.contains(itemkun.id.toString())){
                                            deleteValueList.remove(itemkun.id.toString());
                                            }
                                          }
                                        });
                                      },
                                    )),
                                  (itemkun.memostyle==0)?InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    child: Container(
                                      height: height*0.7*0.02+height*0.7*0.03*displayHeight,
                                      width: width*0.8,
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: <Widget>[
                                                    (display1 ==true)?Container(
                                                        width:width*0.85*0.7,
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                  color: Colors.white,
                                                                  width:1,
                                                                )
                                                            )),
                                                        height: height*0.03*0.7,
                                                        child:Row(children:<Widget>[SizedBox(width: width*0.05*0.7,),
                                                          Text(itemkun.title,
                                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 16*adjustsizeh*0.7),
                                                        )])):Container(),
                                                    (display2 == true)?Container(
                                                        height: height*0.025*0.8,
                                                        child: Row(children:<Widget>[Text(
                                                          ' Email:'
                                                              +itemkun.email,
                                                          style: TextStyle(fontSize:fontsize*adjustsizeh*0.7, color: Colors.black54)),
                                                          (itemkun.email.length != 0) ?IconButton(icon: Icon(Icons.copy,size: iconsize*adjustsizeh*0.7), onPressed:(){
                                                            if(itemkun.email.length != 0){
                                                              ClipboardManager.copyToClipBoard(
                                                                  itemkun.email);}
                                                          })
                                                              :Container(),
                                                        ])):Container(),
                                                    (display3 == true)?Container(
                                                      height: height*0.025*0.7,
                                                      width: width*0.6*0.8,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Container(
                                                            child: Text(" PASSWORD:",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                    fontSize: fontsize*adjustsizeh*0.7,
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Colors.black54)),
                                                          ),
                                                          Container(
                                                            child:Text(itemkun.pass,
                                                              style: TextStyle(
                                                                  fontSize: 16*adjustsizeh*0.7,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: (conseal==false)?Colors.black54:Colors.blue),
                                                            ),
                                                          ),
                                                          (itemkun.pass.length != 0) ?IconButton(
                                                            icon: Icon(Icons.copy,size: iconsize*adjustsizeh*0.7),
                                                            onPressed: (){
                                                            if(itemkun.pass.legth != 0){
                                                              ClipboardManager.copyToClipBoard(
                                                                  itemkun.pass);}
                                                          },)
                                                              :Container(),
                                                        ],
                                                      ),
                                                    ):Container(),
                                                    (display4 == true)?Container(
                                                        height: height*0.02*0.7,
                                                        width: width*0.65*0.7,
                                                        child:Row(children: <Widget>[
                                                          Flexible(
                                                          child:Text(' '+itemkun.url,
                                                            style: TextStyle(
                                                              fontSize: 16*adjustsizeh*0.7,
                                                              color: Colors.brown[800],
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                          (itemkun.url.length != 0)?IconButton(icon: Icon(Icons.copy, size: iconsize*adjustsizeh*0.7),
                                                            onPressed: (){
                                                            if(itemkun.pass.legth != 0){
                                                              ClipboardManager.copyToClipBoard(
                                                                  itemkun.url);}
                                                          },)
                                                              :Container()
                                                        ])):Container(),
                                                    (display5 == true)?Container(
                                                        height: height*0.02,
                                                        width: width*0.7,
                                                        alignment: Alignment.topLeft,
                                                        child: Row(children: <Widget>
                                                        [Flexible(
                                                          child:Text(' '+itemkun.memo,
                                                            style: TextStyle(
                                                              fontSize: 16*adjustsizeh*0.7,
                                                              color: Colors.brown[800],
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        )])
                                                    ):Container(),
                                                  ])
                                            ),
                                            Container(
                                              height: height*0.15*0.7,
                                              decoration: BoxDecoration(
                                              ),
                                              child: Row(children: <Widget>[
                                                SizedBox(width: width*0.02*0.7),
                                                GestureDetector(
                                                    onTap: () {
                                                    },
                                                    child:(itemkun.favorite==true)?Icon(Icons.favorite,color: Colors.brown[700], size: 30*0.7)
                                                        :Icon(Icons.favorite_border,color: Colors.brown[700], size: 30*0.7,)
                                                ),
                                                SizedBox(width: width*0.025*0.7),
                                              ]),
                                            ),
                                          ]),
                                    ),
                                  ),
                                )
                                  :InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      child: Container(
                                        height: height*0.7*0.02+height*0.7*0.03*displayHeight,
                                        width: width*0.8,
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    children: <Widget>[
                                                      Container(
                                                          height: height*0.02,
                                                          width: width*0.7,
                                                          alignment: Alignment.topLeft,
                                                          child: Row(children: <Widget>
                                                          [Flexible(
                                                              child:Text(itemkun.memo,
                                                                style: TextStyle(
                                                                  fontSize: 16*adjustsizeh*0.7,
                                                                  color: Colors.brown[800],
                                                                ),
                                                                overflow: TextOverflow.ellipsis,
                                                                maxLines: 1,
                                                              ),
                                                            )])
                                                      )
                                                    ])
                                              ),
                                              Container(
                                                height: height*0.15*0.7,
                                                decoration: BoxDecoration(
                                                ),
                                                child: Row(children: <Widget>[
                                                  SizedBox(width: width*0.02*0.7),
                                                  GestureDetector(
                                                      onTap: () {
                                                      },
                                                      child:(itemkun.favorite==true)?Icon(Icons.favorite,color: Colors.brown[700], size: 30*0.7)
                                                          :Icon(Icons.favorite_border,color: Colors.brown[700], size: 30*0.7,)
                                                  ),
                                                  SizedBox(width: width*0.025*0.7),
                                                ]),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ]));
                                //       });
                              },
                            );
                          }
                        }
                    )
                ),
                Container(
                  height: height*0.1,
                  width: width*0.7,
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                  onPressed: () {
                    deleteOn();
                    setState(() {
                      deleteon = false;
                      streamIn();
                    });
                  },
                    style:ElevatedButton.styleFrom(
                      primary: Colors.brown,
                    ),
                  child: Text('DELETE', style: TextStyle(color: Colors.yellow[200])))),
              ]))
      )
    );
  }
}
