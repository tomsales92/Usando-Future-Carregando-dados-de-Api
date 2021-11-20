import 'package:flutter/cupertino.dart';

class Post {
  int _userId;
  int _id;
  String _title;
  String _body;

  Post(this._userId, this._id, this._title, this._body);

  int get userId => this._userId;
  set userId(int  value) => this._userId = value;

  int get id => this._id;
  set id(int value) => this._id = value;

  String get title => this._title;
  set title(String value) => this._title = value;

  String get body => this._body;
  set body(String value) => this._body = value;
  

}