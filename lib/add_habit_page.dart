import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:habitmanager1/Habit.dart';
import 'package:habitmanager1/HabitLists.dart';

import 'CustomButton.dart';
import 'main.dart';


class AddHabitPage extends StatefulWidget {
  @override
  _AddHabitPageState createState() => _AddHabitPageState();
}



Habit userhabit;
Habit dd;


class _AddHabitPageState extends State<AddHabitPage> {

 // GlobalKey<_HabitLists> _key = GlobalKey();

  @override
  void initState(){
    super.initState();
    userhabit = new Habit(habitName: 'mmm', habitDescription: 'dddd', numberOfDays: 30);
    dd = new Habit(habitName: '12222', habitDescription: '122', numberOfDays: 33);
  }


  String dropdownValue = 'One';
  String droptimeValue = 'Once';
  double v = 5.00;
  String selectedDate = 'Pick a Date';
  String selectedTime = 'Pick a Time';
  String selectedTime2 = 'Pick a Time';
  String selectedTime3 = 'Pick a Time';
  bool isselected = false;
  bool istwice = false;
  bool isthree = false;
  bool isonce = true;
  bool onmonday = true;
  bool ontuesday = true;
  bool onwend = true;
  bool onthur = true;
  bool onfriday = true;
  bool onsat = true;
  bool onsun = true;

  Future pickDate() async {
    DateTime datepick = await showDatePicker(context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: new DateTime.now().add(Duration(days: 365)));
    if (datepick != null) {
      setState(() {
        selectedDate = datepick.toString();
      });
    }
  }

  Future pickTime() async {
    TimeOfDay timepick = await showTimePicker(
        context: context, initialTime: TimeOfDay.now());
    if (timepick != null) {
      setState(() {
        selectedTime = timepick.toString();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Column(

              children: <Widget>[
                SizedBox(height: 20,),
                Text(
                  'Add New Habit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Container(
                    width: 220,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular((12)))
                        ),
                        labelText: 'Task Name',
                        labelStyle: TextStyle(
                          fontSize: 13,
                        ),

                      ),

                      onSubmitted: (String s) {
                        setState(() {
                          userhabit.habitName = s;
                        });
                      },

                    ),
                  ),

                ),
                datetimePicker(Icons.date_range, pickDate, selectedDate),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Number of Days'),
                      Text(v.round().toString()),
                    ],
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbColor: Color(0xFFEB1555),
                    overlayColor: Color(0x29EB1555),
                    activeTrackColor: Colors.black,
                    inactiveTrackColor: Color(0xFF8D8E98),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                  ),
                  child: Slider(
                    min: 1,
                    max: 365,
                    value: v,
                    onChanged: (double value) {
                      setState(() {
                        v = value;
                      });
                    },
                    onChangeEnd: (double d) {
                      setState(() {
                        userhabit.numberOfDays = d.round();
                      });
                    },
                  ),
                ),
                Container(
                  width: 240,
                  height: 70,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular((12)))
                          ),
                          labelText: 'Task Description',
                          labelStyle: TextStyle(
                            fontSize: 13,
                          )
                      ),
                      maxLines: 10,
                      onChanged: (String s) {
                        setState(() {
                          userhabit.habitDescription = s;
                        });
                      },
                    ),

                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(40, 5, 50, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Text('Repeat'),
                      DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                              color: Colors.deepPurple
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                              if (newValue == 'Three') {
                                isselected = true;
                              }
                              else if (newValue == 'One') {
                                isselected = false;
                              }
                              else {
                                isselected = false;
                              }
                            });
                          },
                          items: <String>['One', 'Two', 'Three'].map<
                              DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()
                      ),
                    ],
                  ),
                ),
                isselected ? customDays(context) : Container(
                  width: 0, height: 0,),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 5, 50, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Text('Daily Reptition'),
                      DropdownButton<String>(
                          value: droptimeValue,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                              color: Colors.deepPurple
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              droptimeValue = newValue;

                              if (newValue == 'Three') {
                                isthree = true;
                                istwice = false;
                                isonce = false;
                              }
                              else if (newValue == 'Twice') {
                                istwice = true;
                                isthree = false;
                                isonce = false;
                              }
                              else {
                                isonce = true;
                                isthree = false;
                                istwice = false;
                              }
                            });
                          },
                          items: <String>['Once', 'Twice', 'Three'].map<
                              DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()
                      ),
                    ],
                  ),
                ),

                isonce ? datetimePicker(
                    Icons.access_time, pickTime, selectedTime) : Container(
                  width: 0, height: 0,),
                isthree ? Column(children: <Widget>[
                  datetimePicker(Icons.access_time, pickTime, selectedTime3),
                  datetimePicker(Icons.access_time, pickTime, selectedTime3),
                  datetimePicker(Icons.access_time, pickTime, selectedTime3)
                ],) : Container(
                  width: 0, height: 0,),
                istwice ? Column(children: <Widget>[
                  datetimePicker(Icons.access_time, pickTime, selectedTime2),
                  datetimePicker(Icons.access_time, pickTime, selectedTime2)
                ],) : Container(
                  width: 0, height: 0,),

                Padding(padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: actionButton(context)),
                SizedBox(height: 20,)
              ],

            ),
          )
        ],
      ),
    );
  }

  Widget datetimePicker(IconData icon, VoidCallback onPressed, String value) {
    return FlatButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          children: <Widget>[
            Icon(
                icon,
                color: Theme
                    .of(context)
                    .accentColor, size: 30),
            SizedBox(
              width: 12,
            ),
            Text(
              value,
              style: TextStyle(fontSize: 14),
            ),

          ],
        ),
      ),
    );
  }

  Widget customDays(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Checkbox(
                value: onmonday,
                onChanged: (bool val) {
                  setState(() {
                    if (val == true) {
                      onmonday = true;
                    } else {
                      onmonday = false;
                    }
                  });
                },
              ),
              Checkbox(
                value: ontuesday,
                onChanged: (bool val) {
                  setState(() {
                    if (val == true) {
                      ontuesday = true;
                    } else {
                      ontuesday = false;
                    }
                  });
                },
              ),
              Checkbox(
                value: onwend,
                onChanged: (bool val) {
                  setState(() {
                    if (val == true) {
                      onwend = true;
                    } else {
                      onwend = false;
                    }
                  });
                },
              ),
              Checkbox(
                value: onthur,
                onChanged: (bool val) {
                  setState(() {
                    if (val == true) {
                      onthur = true;
                    } else {
                      onthur = false;
                    }
                  });
                },
              ),
              Checkbox(
                value: onfriday,
                onChanged: (bool val) {
                  setState(() {
                    if (val == true) {
                      onfriday = true;
                    } else {
                      onfriday = false;
                    }
                  });
                },
              ),
              Checkbox(
                value: onsat,
                onChanged: (bool val) {
                  setState(() {
                    if (val == true) {
                      onsat = true;
                    } else {
                      onsat = false;
                    }
                  });
                },
              ),
              Checkbox(
                value: onsun,
                onChanged: (bool val) {
                  setState(() {
                    if (val == true) {
                      onsun = true;
                    } else {
                      onsun = false;
                    }
                  });
                },
              ),
            ],
          ),
          Container(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Mo'),
                Text('Tu'),
                Text('We'),
                Text('Th'),
                Text('Fr'),
                Text('Sa'),
                Text('Su'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row actionButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          buttonText: 'Close',

        ),
        CustomButton(
          onPressed: () {
           // _key.currentState.setHabit(dd);
            setState(() {

            });
            Navigator.of(context).pop();
          },
          buttonText: 'Save',
          color: Theme
              .of(context)
              .accentColor,
          textColor: Colors.white,

        ),
      ],
    );
  }
}


