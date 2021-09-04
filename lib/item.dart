import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_storage/Itemkun.dart';
import 'package:password_storage/Itemkun_repository.dart';
import 'package:password_storage/db.dart';
import 'package:password_storage/root.dart';



class Item extends StatefulWidget {
  final argumentmode;
  final id;
  Item(this.argumentmode,
      this.id,
      );

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  List<bool> isSelected;
  //Itemkun _editItem = [];
   //List<Itemkun> forEdit = [];

  var titletext = TextEditingController();
  var emailtext = TextEditingController();
  var passtext = TextEditingController();
  var urltext = TextEditingController();
  var memotext = TextEditingController();
  var titletext123 = TextEditingController(text: 'controller');
  TextEditingController titletext0;
  TextEditingController emailtext0;
  TextEditingController passtext0;
  TextEditingController urltext0;
  TextEditingController memotext0;
  bool datagetflg = false;
  bool memostyle = false;
  double TextFieldFontSize = 20;
  bool favo;
  //_ItemState(this.titletext0, this.emailtext0, this.passtext0, this.urltext0, this.memotext0);

  @override
  void initState() {
    isSelected = [true, false];
    if(widget.argumentmode == 1){
      setState(() {
        getdata(widget.id);
      });}else{}
    super.initState();
  }

  @override
  // widgetの破棄時にコントローラも破棄する
  void dispose() {
    titletext?.dispose();
    titletext0?.dispose();
    emailtext?.dispose();
    emailtext0?.dispose();
    passtext?.dispose();
    passtext0?.dispose();
    urltext0?.dispose();
    urltext?.dispose();
    memotext0?.dispose();
    memotext?.dispose();
    super.dispose();
  }

  void getdata(int id) async{
    datagetflg = false;
   var forEdit = await DBProvider().select(id);
    titletext0 = TextEditingController(text:forEdit[0].title);
    emailtext0 = TextEditingController(text:forEdit[0].email);
    passtext0 = TextEditingController(text:forEdit[0].pass);
    urltext0 = TextEditingController(text:forEdit[0].url);
    memotext0 = TextEditingController(text:forEdit[0].memo);
    setState(() {
      datagetflg = true;
      if(forEdit[0].favorite==0){
        favo=false;
      }else{
        favo=true;
      }
    });
  }

  void insertdesu() async {
    if(memostyle==false){
    return await  DBProvider().tukkomu(Itemkun(title: titletext.text,email:emailtext.text ,pass:passtext.text ,url:urltext.text ,memo:memotext.text,favorite: 0, memostyle: 0, date: DateTime.now().toString()));}else{
      return await  DBProvider().tukkomu(Itemkun(title: titletext.text,email:emailtext.text ,pass:passtext.text ,url:urltext.text ,memo:memotext.text,favorite: 0, memostyle: 1, date: DateTime.now().toString()));
    }
  }

  void updatedesu() async {
    //TODO favorite adjust
    if(favo=false) {if(memostyle==false){
      return await DBProvider().update(Itemkun(
          id: widget.id,
          title: titletext0.text,
          email: emailtext0.text,
          pass: passtext0.text,
          url: urltext0.text,
          memo: memotext0.text,
          favorite: 0,
          memostyle: 0,
          date: DateTime.now().toString()), widget.id);}else{
      return await DBProvider().update(Itemkun(
          id: widget.id,
          title: titletext0.text,
          email: emailtext0.text,
          pass: passtext0.text,
          url: urltext0.text,
          memo: memotext0.text,
          favorite: 0,
          memostyle: 1,
          date: DateTime.now().toString()), widget.id);
    }
    }else{if(memostyle==false){
      return await DBProvider().update(Itemkun(
          id: widget.id,
          title: titletext0.text,
          email: emailtext0.text,
          pass: passtext0.text,
          url: urltext0.text,
          memo: memotext0.text,
          favorite: 1,
          memostyle: 0,
          date: DateTime.now().toString()), widget.id);}else{
      return await DBProvider().update(Itemkun(
          id: widget.id,
          title: titletext0.text,
          email: emailtext0.text,
          pass: passtext0.text,
          url: urltext0.text,
          memo: memotext0.text,
          favorite: 1,
          memostyle: 1,
          date: DateTime.now().toString()), widget.id);
    }
    }
    }

  favoriteOnOff() async{
    List<Itemkun> dataget = await DBProvider().select(widget.id);
    DBProvider().update(Itemkun(id: widget.id, title: dataget[0].title, email: dataget[0].email, pass: dataget[0].pass, url: dataget[0].url, memo: dataget[0].memo, favorite: 1, memostyle: dataget[0].memostyle, date: dataget[0].date), widget.id);
    setState(() {
      if(favo){
        favo=false;
      }else{
        favo=true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;


    return Scaffold(
      backgroundColor: Colors.amber[200],
        appBar: AppBar(
          elevation: 8,
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: (widget.argumentmode == 1) ?IconButton(
              icon: Icon(Icons.copy),
              onPressed: () => {
              },
            )
            :Container(),
          ),
          centerTitle: true,
          title:Text("Detail / Edit ",style: TextStyle(color: Colors.yellow[200]),),
          backgroundColor: Colors.brown[800],
          actions: [

            Padding(
              padding: const EdgeInsets.all(4.0),
              child:(widget.argumentmode ==1) ? IconButton(
                icon: (favo==false)?Icon(Icons.favorite,color: Colors.white)
                :Icon(Icons.favorite, color: Colors.yellow[200],),
                onPressed: () => {
                  favoriteOnOff()
                      },
                )
              :Container(),
                ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: (widget.argumentmode == 1)?IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => {
                  //TODO DIALOG TO DELETE
                   showDialog(
                  context: context,
                  builder: (_) {
    return AlertDialog(

    //content: Text("DELETE THIS ITEM?", style: TextStyle(color: Colors.lightBlue, fontSize: 20, fontWeight: FontWeight.w500),),
    actions: <Widget>[
      Container(
    height:height*0.2,
      width: width*0.7,
      child:Column(
        children: <Widget>[
          Container(
            height:height*0.15,
            width: width*0.7,
            alignment: Alignment.center,
            child: Text("DELETE THIS ITEM?", style: TextStyle(color: Colors.lightBlue, fontSize: 20, fontWeight: FontWeight.w500),),),
                    Container(
            height:height*0.05,
            width: width*0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              InkWell(
                child: Container(
                  height:height*0.05,
                  width: width*0.35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.lightBlue,
                        width: 2,
                      ),
                      right: BorderSide(
                        color: Colors.lightBlue,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text('Cancel', style: TextStyle(color: Colors.lightBlue, fontSize: 18, fontWeight: FontWeight.w500),),),
                onTap: (){
                  Navigator.pop(context);
                },),
              InkWell(child: Container(
                height:height*0.05,
                width:width*0.35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Colors.lightBlue,
                      width: 1,
                    ),
                    top: BorderSide(
                      color: Colors.lightBlue,
                      width: 2,
                    ),
                  ),
                ),
                child: Text('Delete', style: TextStyle(color: Colors.lightBlue, fontSize: 18, fontWeight: FontWeight.w500),),),
                onTap: (){
                  DBProvider().delete(widget.id);
                  int count = 0;
                  Navigator.popUntil(context, (_) => count++ >= 2);
                },)
            ],),
          )
        ],
      )
      )
      ],
    );
    },
    )
                },
              )
              :Container(),
            ),
          ],
        ),
        body: Center(child:
        //Column(children: <Widget>[
          //Container(),
             //Expanded(
            SingleChildScrollView(
              //child:Expanded(
                 child:Container(
                   height: height*0.9,
                decoration: (BoxDecoration(color: Colors.amber[200])),
                //height: height,
            //decoration: BoxDecoration(
              //image: DecorationImage(
                //image: AssetImage("lib/wooden3.jpg"),
                //fit: BoxFit.cover,
              //),
            //),
            child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget>[
              (widget.argumentmode==0)?Container(
                height: height*0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  CupertinoSwitch(
                    activeColor: Colors.brown[700],
                    value: memostyle,
                    onChanged: (bool value) {
                      setState(() {
                         memostyle= value;
                      });
                    },
                  ),
                  Container(child: Text('MEMO STYLE',style: TextStyle(fontSize: 18),),),
                ],),
              )
              :Container(),
              (memostyle == false)?Container(
        height:height*0.5,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        Container(
          height: height*0.075,
          width: width*0.85,
          child: (widget.argumentmode == 1 && datagetflg == true)?TextFormField( decoration: InputDecoration(
            labelText: 'title'),
              controller: titletext0,
              //initialValue: vm.isNew ? '' : vm.memo.title,
              //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
             // onChanged: (value) => vm.setTitle(value),
            style: TextStyle(
                fontSize: TextFieldFontSize,
                height: 2.0,
                color: Colors.brown
            ))
          :TextFormField( decoration: InputDecoration(
              labelText: 'title'),
              controller: titletext,
              //initialValue: vm.isNew ? '' : vm.memo.title,
              //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
              // onChanged: (value) => vm.setTitle(value),
              style: TextStyle(
                  fontSize: TextFieldFontSize,
                  height: 2.0,
                  color: Colors.brown
              )),),
        Container(
          height: height*0.075,
          width: width*0.85,
          child: (widget.argumentmode == 1 && datagetflg == true) ?TextFormField( decoration: InputDecoration(
        labelText: 'id/Email/user name/etc...'),
              controller: emailtext0,
              //initialValue: vm.isNew ? '' : vm.memo.title,
              //validator: (value) => (value.isEmpty) ? '' : null,
              //onChanged: (value) => vm.setTitle(value),
              style: TextStyle(
                fontSize: TextFieldFontSize,
                height: 2.0,
                color: Colors.brown
            ))
              :TextFormField( decoration: InputDecoration(
              labelText: 'id/Email/user name/etc...'),
              controller: emailtext,
              //initialValue: vm.isNew ? '' : vm.memo.title,
              //validator: (value) => (value.isEmpty) ? '' : null,
              //onChanged: (value) => vm.setTitle(value),
              style: TextStyle(
                  fontSize: TextFieldFontSize,
                  height: 2.0,
                  color: Colors.brown
              )),),
        Container(
          height: height*0.08,
          width: width*0.85,
          child: (widget.argumentmode == 1 && datagetflg == true) ?TextFormField( decoration: InputDecoration(
            labelText: 'PassWord'),
              controller: passtext0,
              //initialValue: vm.isNew ? '' : vm.memo.title,
              //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
              //onChanged: (value) => vm.setTitle(value),
            style: TextStyle(
                fontSize: TextFieldFontSize,
                height: 2.0,
                color: Colors.brown
            ))
          :TextFormField( decoration: InputDecoration(
        labelText: 'PassWord'),
                controller: passtext,
                //initialValue: vm.isNew ? '' : vm.memo.title,
                //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
                //onChanged: (value) => vm.setTitle(value),
                style: TextStyle(
                    fontSize: TextFieldFontSize,
                    height: 2.0,
                    color: Colors.brown
                )),),
        Container(
          height: height*0.075,
          width: width*0.85,
          child: (widget.argumentmode == 1 && datagetflg == true) ?TextFormField(decoration: InputDecoration(
            labelText: 'URL'),
              controller: urltext0,
              //initialValue: vm.isNew ? '' : vm.memo.title,
              //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
              //onChanged: (value) => vm.setTitle(value),
            style: TextStyle(
                fontSize: 18,
                height: 2.0,
                color: Colors.brown
            ))
          :TextFormField(decoration: InputDecoration(
              labelText: 'URL'),
              controller: urltext,
              //initialValue: vm.isNew ? '' : vm.memo.title,
              //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
              //onChanged: (value) => vm.setTitle(value),
              style: TextStyle(
                  fontSize: 18,
                  height: 2.0,
                  color: Colors.brown
              )),),
      //  Container(
        //    height: height*0.35,
        //  child: Column(children: <Widget>[
          //(isSelected[0]==true) ?
          Container(
            height: height*0.15,
            width: width*0.85,
            child: (widget.argumentmode == 1 && datagetflg == true) ?TextFormField( decoration: InputDecoration(
              labelText: 'memo'),
                controller: memotext0,
                //initialValue: vm.isNew ? '' : vm.memo.title,
                //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
                //onChanged: (value) => vm.setTitle(value),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              style: TextStyle(
                  fontSize: TextFieldFontSize,
                  height: 2.0,
                  color: Colors.brown
              ))
            :TextFormField( decoration: InputDecoration(
                labelText: 'memo'),
                controller: memotext,
                //initialValue: vm.isNew ? '' : vm.memo.title,
                //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
                //onChanged: (value) => vm.setTitle(value),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(
                    fontSize: TextFieldFontSize,
                    height: 2.0,
                    color: Colors.brown
                )),)
              //:Container()
       // ],),
        //)
      ],),)
              :Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.fromLTRB(50, 0, 50, 200),
                height: height*0.5,
                child: TextFormField( decoration: InputDecoration(
                  labelText: 'memo'),
                  controller: memotext,
                  //initialValue: vm.isNew ? '' : vm.memo.title,
                  //validator: (value) => (value.isEmpty) ? 'タイトルを入力して下さい' : null,
                  //onChanged: (value) => vm.setTitle(value),
                  keyboardType: TextInputType.multiline,
                  maxLines: 100,
                  style: TextStyle(
                      fontSize: 18,
                      height: 2.0,
                      color: Colors.brown
                  )),),
      Container(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Container(
            height: height*0.05,
            width:width*0.3,
            child:ElevatedButton(onPressed: (){
              Navigator.pop(context);
              //Navigator.push(context, MaterialPageRoute(builder: (context) =>Root(
              //)));
            }, child: Text('cancel',style: TextStyle(fontSize: 18*adjustsizeh,color: Colors.yellow[200]),), style:  ElevatedButton.styleFrom(
          primary: Colors.brown,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          )
        ))),
        SizedBox(width: width*0.1,),
        Container(
            height: height*0.05,
            width:width*0.3,
            child:(widget.argumentmode == 0)?ElevatedButton(onPressed: (){
             insertdesu();
             Navigator.pop(context);
            }, child: Text('OK',style: TextStyle(fontSize: 18*adjustsizeh ,color: Colors.yellow[400]),), style:  ElevatedButton.styleFrom(
            primary: Colors.brown,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            )
        ),)
                :ElevatedButton(onPressed: (){
              updatedesu();
              Navigator.pop(context);
            }, child: Text('OK',style: TextStyle(fontSize: 18*adjustsizeh ,color: Colors.yellow[400]),), style:  ElevatedButton.styleFrom(
                primary: Colors.brown,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                )
            ),)
        )
      ],),)
            ]))
        )
    //)
  //  ])
        ));
  }
}
