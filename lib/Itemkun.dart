import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Itemkun {
   int id;
   String title;
   String email;
   String pass;
   String url;
   String memo;
   String date;



  //String getCreatedAt() {
   // try {
      // 曜日を表示したいときは「'yyyy/MM/dd（E） HH:mm:ss'」
    //  var timestamp = DateFormat('yyyy/MM/dd HH:mm:ss', 'ja_JP');
     // return timestamp.format(date);
   // } catch (e) {
     // print(e);
     // return '';
   // }
  //}

  Itemkun({
    this.id,
    this.title,
    this.email,
    this.pass,
    this.url,
    this.memo,
    this.date
  });

   Map<String, dynamic> toMap() {
     return {
       'id': id,
       'title': title,
       'email': email,
       'pass': pass,
       'url': url,
       'memo': memo,
       'date': date
     };
   }
}