import 'package:flutter/material.dart';

class Habit {
  int _id;
  String _habitName;
  String _habitDescription;
  int _numberOfDays;
  int _numberOfDaysCompleted;
  String _reminders;
  String _dayStarted;
  String _repetition;
  String _daysCompleted;
  String _daysUncompleted;
  String _color;


  Habit(
    this._habitName,
    this._habitDescription,
    this._numberOfDays,
    this._daysCompleted,
    this._daysUncompleted,
    this._numberOfDaysCompleted,
    this._dayStarted,
    this._reminders,
    this._repetition,
    this._color,

  );

  Habit.withId(
    this._id,
    this._habitName,
    this._habitDescription,
    this._numberOfDays,
    this._daysCompleted,
    this._daysUncompleted,
    this._numberOfDaysCompleted,
    this._dayStarted,
    this._reminders,
    this._repetition,
    this._color
  );
  
  //TODO dayscompleted to list of Dates 



  int get id => _id;
  String get habitName => _habitName;
  String get habitDescription => _habitDescription;
  int get numberOfDays => _numberOfDays;
  String get daysCompleted => _daysCompleted;
  String get daysUncompleted => _daysUncompleted;
  String get repetition => _repetition;
  String get color => _color;
  String get reminders => _reminders;
  String get dayStarted => _dayStarted;
  int get numberOfDaysCompleted => _numberOfDaysCompleted;
  

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
  set daysCompleted(String newdaysCompleted){
    this._daysCompleted = newdaysCompleted;
  }
  
  set daysUncompleted(String newdaysUncompleted){
    this._daysUncompleted = newdaysUncompleted;
  }
  set numberOfDays(int days){
    this._numberOfDays = days;
  }
  set color(String newColor){
    this._color = newColor;
  }
  set numberOfDaysCompleted(int newNumOfDaysCompleted){
    this._numberOfDaysCompleted = newNumOfDaysCompleted;
  }
  set repetition(String newrepetition){
    this._repetition = newrepetition;
  }
  set reminders(String newreminders){
    this._reminders = newreminders;
  }
  set dayStarted(String newdayStarted){
    this._dayStarted = newdayStarted;
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
    map['daysCompleted'] = _daysCompleted;
    map['daysUncompleted'] = _daysUncompleted;
    map['numberOfDays'] = _numberOfDays;
    map['color'] = _color;
    map['numberOfDaysCompleted'] = _numberOfDaysCompleted;
    map['repetition'] =  _repetition;
    map['reminders'] = _reminders;
    map['dayStarted'] =_dayStarted;
    return map;
  }

  //NoteObject from a Map

  Habit.fromMapObject(Map<String,dynamic> map){
    this._id = map['id'];
    this._habitName = map['habitName'];
    this._habitDescription = map['habitDescription'];
    this._numberOfDays = map['numberOfDays'];
    this._daysCompleted=map['daysCompleted'];
    this._daysUncompleted=map['daysUncompleted'];
    this._numberOfDays=map['numberOfDays'];
    this._color=map['color'];
    this._numberOfDaysCompleted=map['numberOfDaysCompleted'];
    this._repetition=map['repetition'];
    this._reminders=map['reminders'];
    this._dayStarted=map['dayStarted'];
  }

}