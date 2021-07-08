import 'package:flutter/material.dart';
import 'package:password_storage/root.dart';



class Item extends StatefulWidget {

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  List<bool> isSelected;

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adjustsizeh = MediaQuery.of(context).size.height * 0.0011;
    return Scaffold(
        appBar: AppBar(
          elevation: 8,
          leading:IconButton(
            icon:Icon(Icons.home)
            ,onPressed:() {
          },),
          centerTitle: true,
          title:Text("Detail / Edit ",style: TextStyle(color: Colors.yellow[200]),),
          backgroundColor: Colors.brown[800],
          actions: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                icon: Icon(Icons.copy),
                onPressed: () => {
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () => {
                      },
                ),
                ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => {
                },
              ),
            ),
          ],
        ),
        body: Center(child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/wooden3.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget>[
      Container(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        Container(
          width: width*0.85,
          child: TextField( decoration: InputDecoration(
            labelText: 'title'),
            style: TextStyle(
                fontSize: 17,
                height: 3,
                color: Colors.brown
            )),),
        Container(
          width: width*0.85,
          child: TextField( decoration: InputDecoration(
        labelText: 'id/Email/user name/etc...'),
            style: TextStyle(
                fontSize: 17,
                height: 3,
                color: Colors.brown
            )),),
        Container(
          width: width*0.85,
          child: TextField( decoration: InputDecoration(
            labelText: 'PassWord'),
            style: TextStyle(
                fontSize: 20,
                height: 3.3,
                color: Colors.brown
            )),),
        Container(
          width: width*0.85,
          child: TextField(decoration: InputDecoration(
            labelText: 'URL'),
            style: TextStyle(
                fontSize: 17,
                height: 2.2,
                color: Colors.brown
            )),),
        Container(
            height: 20,
          child: Column(children: <Widget>[
          ToggleButtons(
            borderColor: Colors.brown,
            fillColor: Colors.brown[400],
            borderWidth: 2,
            selectedBorderColor: Colors.brown[100],
            selectedColor: Colors.brown[300],
            borderRadius: BorderRadius.circular(10),
            children: <Widget>[
              Container(
                height: 15,
                width: 80,
                padding: const EdgeInsets.all(0),
                child: Text(
                  'Text',
                  style: TextStyle(fontSize: 10,color: Colors.yellow[300]),
                ),
              ),
              Container(
                height: 15,
                width: 80,
                padding: const EdgeInsets.all(0),
                child: Text(
                  'Free Drawing',
                  style: TextStyle(fontSize: 12, color: Colors.yellow[300]),
                ),
              ),
            ],
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  isSelected[i] = i == index;
                }
              });
            },
            isSelected: isSelected,
          ),
          (isSelected[0]==true) ? Container(
            width: width*0.85,
            child: TextField( decoration: InputDecoration(
              labelText: 'memo'),
              style: TextStyle(
                  fontSize: 10,
                  height: 20.0,
                  color: Colors.brown
              )),)
              :Container()
        ],),)
      ],),),
      Container(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        ElevatedButton(onPressed: (){}, child: Text('cancel'), style:  ElevatedButton.styleFrom(
          primary: Colors.white,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          )
        )),
        SizedBox(width: 30,),
        ElevatedButton(onPressed: (){}, child: Text('OK',style: TextStyle(color: Colors.yellow[200]),), style:  ElevatedButton.styleFrom(
            primary: Colors.brown,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            )
        ),)
      ],),)]))));
  }
}
