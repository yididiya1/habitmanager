import 'package:flutter/material.dart';

class Habit {
  int _id;
  String _habitName;
  String _habitDescription;
  int _numberOfDays;
  int _numberOfDaysCompleted;
  String _reminders;
  DateTime _dayStarted;
  List<bool> _repetition;
  String _dayscompleted;
  String _daysuncompleted;


  Habit(
    this._habitName,
    this._habitDescription,
    this._numberOfDays,
    [this._numberOfDaysCompleted,
    this._dayStarted,
    this._reminders,
    this._repetition,
    this._dayscompleted,
    this._daysuncompleted,]
  );

  Habit.withId(
    this._id,
    this._habitName,
    this._habitDescription,
    this._numberOfDays,
    [this._numberOfDaysCompleted,
    this._dayStarted,
    this._reminders,
    this._repetition,
    this._dayscompleted,
    this._daysuncompleted,]
  );
  
  //TODO dayscompleted to list of Dates 



  int get id => _id;
  String get habitName => _habitName;
  String get habitDescription => _habitDescription;
  int get numberOfDays => _numberOfDays;
  

  set habitName(String newhabitName){
    if(newhabitName.length <= 255){
        this._habitName = newhabitName;
    }
  }
  set habitDescription(String newhabitDescription){
    if(habitDescription.length <= 255){
        this._habitDescription = newhabitDescription;
    }
  }
  set numberOfDays(int days){
    this._numberOfDays = days;
  }
  set id(int newId){
    this._id = newId;
  }

  //Convert a Note Object into a Map Object
  Map<String,dynamic> toMap(){
    var map = Map<String, dynamic>();
    
    if(id != null){
      map['id'] = _id;
    }

    map['habitName'] = _habitName;
    map['habitDescription'] = _habitDescription;
    map['numberOfDays'] = _numberOfDays;
  

    return map;
  }

  //NoteObject from a Map

  Habit.fromMapObject(Map<String,dynamic> map){
    this._id = map['id'];
    this._habitName = map['habitName'];
    this._habitDescription = map['habitDescription'];
    this._numberOfDays = map['numberOfDays'];
  }

}