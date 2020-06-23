import 'package:flutter/material.dart';

class Habit {
  String habitName;

  String habitDescription;
  int numberOfDays;

  int numberOfDaysCompleted;
  List<TimeOfDay> reminders;
  DateTime dayStarted;
  List<bool> repetition;


  Habit({
    @required this.habitName,
    @required this.habitDescription,
    @required this.numberOfDays,
    this.numberOfDaysCompleted,
    this.dayStarted,
    this.reminders,
    this.repetition,
  });


}