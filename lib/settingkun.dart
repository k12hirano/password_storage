import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Settingkun {
  int id;
  int lock;
  int emph;
  int status;
  int conseal;
  int display1;
  int display2;
  int display3;
  int display4;
  int display5;
  String date;




  Settingkun({
    this.id,
    this.lock,
    this.emph,
    this.status,
    this.conseal,
    this.display1,
    this.display2,
    this.display3,
    this.display4,
    this.display5,
    this.date
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lock': lock,
      'emph': emph,
      'status': status,
      'conseal': conseal,
      'display1': display1,
      'display2': display2,
      'display3': display3,
      'display4': display4,
      'display5': display5,
      'date': date
    };
  }
}