import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:habitmanager1/entities/Habit.dart';
import 'package:habitmanager1/util/dbhelper.dart';


import '../widgets/CustomButton.dart';



class AddHabitPage extends StatefulWidget {

  Habit habit;
  AddHabitPage(this.habit);
  @override
  _AddHabitPageState createState() => _AddHabitPageState(this.habit);
}
Habit userhabit;
Habit dd;

class _AddHabitPageState extends State<AddHabitPage> {

  Habit habit;
  DatabaseHelper databaseHelper = DatabaseHelper();
  final TextEditingController habitNameController = new TextEditingController();
  final TextEditingController habitDescriptionController = new TextEditingController();

  _AddHabitPageState(this.habit);


  @override
  void initState(){
    super.initState();
    userhabit = new Habit(' ',' ',0,' ',' ');
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
    return Scaffold( 
    appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Add Habit',style: TextStyle(fontFamily:'JosefinSans'),),
         actions: [
          Icon(Icons.favorite),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
          Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.black54,
      ),
    body:SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left:20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 20,),
            Text(
              ' "" Add New Habit or Random Qoute ""',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 5,),
            
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Container(
                width: 300,
                height: 50,
                child: TextField(
                  
                  controller: habitNameController,
                  onChanged: (value) { updatehabitName();},
                  decoration: InputDecoration(
                    //prefixIcon: Icon(Icons.golf_course,color:Colors.black87),
                    //hintText: 'Habit Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular((12)))
                    ),
                    labelText: 'Habit Name',
                    labelStyle: TextStyle(
                      fontSize: 13,
                    ),

                  ),
                 

                ),
              ),

            ),
           
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 40, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Number of Days'),
                  Text(v.round().toString(),style:TextStyle(fontSize: 18.0)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 30, 10),
              child: SliderTheme(
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
                      habit.numberOfDays = d.round();
                    });
                  },
                ),
              ),
            ),
            Container(
              width: 300,
              height: 70,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  controller: habitDescriptionController,
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
                  onChanged: (value) { updatehabitDescription(); },
                ),

              ),
            ),
             datetimePicker(Icons.date_range, pickDate, selectedDate),
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
      ),
    ));
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
           
            _save();
            
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
  void updatehabitName(){
    habit.habitName= habitNameController.text;
    //habit.daysUncompleted=' ';
    //habit.daysCompleted=' ';
  }

  //Update the description
  void updatehabitDescription(){
    habit.habitDescription = habitDescriptionController.text;
  }

  void moveToLastScreen(){
    Navigator.pop(context,true);
  }
  void fillforNow(){
    habit.daysCompleted ='2000-08-1';
    habit.daysUncompleted='2000-08-2';
  }
  

  //save to database
  void _save() async {


    fillforNow();
    moveToLastScreen();



    int result;
    if(habit.id != null){
      //case 1 : update operation
      result = await databaseHelper.updateHabit(habit);
    }else{ //insert operation
      result = await databaseHelper.insertHabit(habit);
    }

    if(result != 0 ){
      _showAlertDialog('Status', 'Habit Saved Successfully');
      print('saved successfully');
      print(habit.habitName);
    }else{
      _showAlertDialog('Status','Problem Saving Habit');
      print('not saved');
    }
  }

  void _showAlertDialog(String title,String message){
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content:Text(message),
    );
    showDialog(context: context,builder:(_) => alertDialog);
  }
}


