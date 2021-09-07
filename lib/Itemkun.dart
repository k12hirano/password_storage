import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Itemkun {
  int id;
  String title;
  String email;
  String pass;
  String url;
  String memo;
  int favorite;
  int memostyle;
  String date;

  Itemkun({
    this.id,
    this.title,
    this.email,
    this.pass,
    this.url,
    this.memo,
    this.favorite,
    this.memostyle,
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
      'favorite': favorite,
      'memostyle': memostyle,
      'date': date
    };
  }
}