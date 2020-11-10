import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:habitmanager1/entities/Habit.dart';
import 'package:habitmanager1/util/dbhelper.dart';
import 'package:intl/intl.dart';


import '../widgets/CustomButton.dart';



class AddHabitPage extends StatefulWidget {

  Habit habit;
  String title;
  AddHabitPage(this.habit,this.title);
  @override
  _AddHabitPageState createState() => _AddHabitPageState(this.habit,this.title);
}
Habit userhabit;
Habit dd;

class _AddHabitPageState extends State<AddHabitPage> {

  
  Habit habit;
  String title;
  DatabaseHelper databaseHelper = DatabaseHelper();
  final TextEditingController habitNameController = new TextEditingController();
  final TextEditingController habitDescriptionController = new TextEditingController();

  _AddHabitPageState(this.habit,this.title);


  @override
  void initState(){
    super.initState();
    userhabit = new Habit(' ',' ',0,' ',' ',0,'','','','');
   }
   String weekDays ='';
  Color colorr;
  double bred = 0.0;double bgreen = 2.0;double byellow = 0.0;double borange= 0.0;double bblue= 0.0;
  double bbrown=0.0;double bwhite=0.0; double bblack=0.0;double bpink=0.0;double bcyan =0.0;
  double blime =0.0;double bpurple=0.0;
  String dropdownValue = 'Daily';
  String droptimeValue = 'Once';
  double v = 5.00;
  String selectedDate = 'Pick a Date';
  String selectedTime = 'Pick a Time';
  String selectedTime2 = 'Pick a Time';
  String selectedTime3 = 'Pick a Time';
  bool isselected = false;bool istwice = false;bool isthree = false;bool isonce = true;bool onmonday = true;
  bool ontuesday = true;bool onwend = true;bool onthur = true;bool onfriday = true;bool onsat = true;bool onsun = true;

  Future pickDate() async {
    DateTime datepick = await showDatePicker(context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: new DateTime.now().add(Duration(days: 365)));
    if (datepick != null) {
      setState(() {
        selectedDate = DateFormat('EEE, MMM d, ''yyyy').format(datepick);
        habit.dayStarted = selectedDate.toString();
              });
    }
  }

  Future pickTime() async {
    final now = new DateTime.now();
    TimeOfDay timepick = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()));
    if (timepick != null) {
      setState(() {
        DateTime time = new DateTime(now.year,now.month,now.day,timepick.hour,timepick.minute) ; 
        selectedTime = DateFormat('hh:mm aaa').format(time);
        habit.reminders=selectedTime.toString()+' ';
      });
    }
  }
   Future pickTime2() async {
    final now = new DateTime.now();
    TimeOfDay timepick = await showTimePicker(
        context: context, initialTime: TimeOfDay.now());
    if (timepick != null) {
      setState(() {
      DateTime time = new DateTime(now.year,now.month,now.day,timepick.hour,timepick.minute) ; 
      selectedTime2 = DateFormat('hh:mm aaa').format(time);
      habit.reminders+=selectedTime2.toString()+' ';
      });
    }
  }
  Future pickTime3() async {
    final now = new DateTime.now();
    TimeOfDay timepick = await showTimePicker(
        context: context, initialTime: TimeOfDay.now());
    if (timepick != null) {
      setState(() {
      DateTime time = new DateTime(now.year,now.month,now.day,timepick.hour,timepick.minute) ; 
      selectedTime3 = DateFormat('hh:mm aaa').format(time);
      habit.reminders+=selectedTime3.toString();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold( 
    appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text(title,style: TextStyle(fontFamily:'JosefinSans'),),
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
                  //maxLines: 10,
                  onSubmitted: (value) { updatehabitDescription(); },
                  
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
                          if (newValue == 'Custom') {
                            isselected = true;
                          }
                          else if (newValue == 'Daily') {
                            isselected = false;
                          }
//                          else {
//                            isselected = false;
//                          }
                        });
                      },
                      items: <String>['Daily', 'Custom'].map<
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
              datetimePicker(Icons.access_time, pickTime, selectedTime),
              datetimePicker(Icons.access_time, pickTime2, selectedTime2),
              datetimePicker(Icons.access_time, pickTime3, selectedTime3)
            ],) : Container(
              width: 0, height: 0,),
            istwice ? Column(children: <Widget>[
              datetimePicker(Icons.access_time, pickTime, selectedTime),
              datetimePicker(Icons.access_time, pickTime2, selectedTime2)
            ],) : Container(
              width: 0, height: 0,),
            SizedBox(height:20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                  
                   
                  ),
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  width:30,
                  height : 30,
                  //color: Colors.green,
                  child: GestureDetector(
                    child:Container(
                      decoration: BoxDecoration(
                        border:Border.all(width:bgreen, color: Colors.black54,),
                         color: Color(0xFF4CAF50),
                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                     
                    ),
                    onTap : (){
                      setState((){
                         bblue = 0.0;bgreen=2.0;borange=0.0;byellow=0.0;bred=0.0;bpurple=0.0;bpink=0.0;
                         bbrown=0.0;bwhite=0.0;bblack=0.0;blime=0.0;bcyan=0.0;
                         habit.color =  Color(0xFF4CAF50).value.toString();
                      });
                    }
                  ),
                ),
                 Container(
                
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  width:30,
                  height : 30,
                  //color: Colors.green,
                  child: GestureDetector(
                    child:Container(
                       decoration: BoxDecoration(
                        border:Border.all(width:borange, color: Colors.black54,),
                         color: Color(0xFFFF9800),
                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    onTap : (){
                      setState((){
                         bblue = 0.0;bgreen=0.0;borange=2.0;byellow=0.0;bred=0.0;bpurple=0.0;bpink=0.0;
                         bbrown=0.0;bwhite=0.0;bblack=0.0;blime=0.0;bcyan=0.0;
                         habit.color = Color(0xFFFF9800).value.toString();
                      });
                    }
                  ),
                ),
                 Container(
                  
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  width:30,
                  height : 30,
                  //color: Colors.green,
                  child: GestureDetector(
                    child:Container(
                        decoration: BoxDecoration(
                        border:Border.all(width:bred, color: Colors.black54,),
                         color:  Color(0xFFF43030),
                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      
                    ),
                    onTap : (){
                      setState((){
                         bblue = 0.0;bgreen=0.0;borange=0.0;byellow=0.0;bred=2.0;bpurple=0.0;bpink=0.0;
                         bbrown=0.0;bwhite=0.0;bblack=0.0;blime=0.0;bcyan=0.0;
                         habit.color = Color(0xFFF43030).value.toString();
                      });
                    }
                  ),
                ),
                 Container(
                  
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  width:30,
                  height : 30,
                  //color: Colors.green,
                  child: GestureDetector(
                    child:Container(
                      decoration: BoxDecoration(
                        border:Border.all(width:byellow, color: Colors.black54,),
                         color: Color(0xFFF4F130),
                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    onTap : (){
                      setState((){
                        bblue = 0.0;bgreen=0.0;borange=0.0;byellow=2.0;bred=0.0;bpurple=0.0;bpink=0.0;
                        bbrown=0.0;bwhite=0.0;bblack=0.0;blime=0.0;bcyan=0.0;
                        habit.color =  Color(0xFFF4E030).value.toString();
                      });
                    }
                  ),
                ),
                 Container(
                 
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  width:30,
                  height : 30,
                  //color: Colors.green,
                  child: GestureDetector(
                    child:Container(
                       decoration: BoxDecoration(
                        border:Border.all(width:bblue, color: Colors.black54,),
                         color: Color(0xFF3075F4),
                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    onTap : (){
                      setState((){
                         bblue = 2.0;bgreen=0.0;borange=0.0;byellow=0.0;bred=0.0;bpurple=0.0;bpink=0.0;
                         bbrown=0.0;bwhite=0.0;bblack=0.0;blime=0.0;bcyan=0.0;
                         habit.color = Color(0xFF3075F4).value.toString();
                      });
                    }
                  ),
                ),
                 Container(
                 
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  width:30,
                  height : 30,
                  //color: Colors.green,
                  child: GestureDetector(
                    child:Container(
                     decoration: BoxDecoration(
                        border:Border.all(width:bpurple, color: Colors.black54,),
                         color:  Color(0xFFA621F3),
                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    onTap : (){
                      setState((){
                         bblue = 0.0;bgreen=0.0;borange=0.0;byellow=0.0;bred=0.0;bpurple=2.0;bpink=0.0;
                         bbrown=0.0;bwhite=0.0;bblack=0.0;blime=0.0;bcyan=0.0;
                         habit.color = Color(0xFFA621F3).value.toString();
                      });
                    }
                  ),
                ),
                 
                
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Container(
                 
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  width:30,
                  height : 30,
                  //color: Colors.green,
                  child: GestureDetector(
                    child:Container(
                       decoration: BoxDecoration(
                        border:Border.all(width:bpink, color: Colors.black54,),
                         color: Color(0xFFE91E63),
                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    onTap : (){
                      setState((){
                         bblue = 0.0;bgreen=0.0;borange=0.0;byellow=0.0;bred=0.0;bpurple=0.0;bpink=2.0;
                         bbrown=0.0;bwhite=0.0;bblack=0.0;blime=0.0;bcyan=0.0;
                         habit.color = Color(0xFFE91E63).value.toString();
                      });
                    }
                  ),
                ),
                 Container(
                  
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  width:30,
                  height : 30,
                  //color: Colors.green,
                  child: GestureDetector(
                    child:Container(
                      decoration: BoxDecoration(
                        border:Border.all(width:bbrown, color: Colors.black54,),
                         color: Color(0xFF795548),
                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    onTap : (){
                      setState((){
                         bblue = 0.0;bgreen=0.0;borange=0.0;byellow=0.0;bred=0.0;bpurple=0.0;bpink=0.0;
                         bbrown=2.0;bwhite=0.0;bblack=0.0;blime=0.0;bcyan=0.0;
                         habit.color =  Color(0xFF795548).value.toString();
                      });
                    }
                  ),
                ),
                 Container(
                 
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  width:30,
                  height : 30,
                  //color: Colors.green,
                  child: GestureDetector(
                    child:Container(
                       decoration: BoxDecoration(
                        border:Border.all(width:bwhite, color: Colors.black54,),
                         color:  Color(0x5DFFFFFF),
                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    onTap : (){
                      setState((){
                         bblue = 0.0;bgreen=0.0;borange=0.0;byellow=0.0;bred=0.0;bpurple=0.0;bpink=0.0;
                         bbrown=0.0;bwhite=2.0;bblack=0.0;blime=0.0;bcyan=0.0;
                         habit.color = Color(0x5DFFFFFF).value.toString();
                      });
                    }
                  ),
                ),
                 Container(
                 
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  width:30,
                  height : 30,
                  //color: Colors.green,
                  child: GestureDetector(
                    child:Container(
                       decoration: BoxDecoration(
                        border:Border.all(width:bblack, color: Colors.black54,),
                         color:  Color(0x73000000),
                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    onTap : (){
                      setState((){
                         bblue = 0.0;bgreen=0.0;borange=0.0;byellow=0.0;bred=0.0;bpurple=0.0;bpink=0.0;
                         bbrown=0.0;bwhite=0.0;bblack=2.0;blime=0.0;bcyan=0.0;
                         habit.color =  Color(0x73000000).value.toString();
                      });
                    }
                  ),
                ),
                 Container(
                 
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  width:30,
                  height : 30,
                  //color: Colors.green,
                  child: GestureDetector(
                    child:Container(
                       decoration: BoxDecoration(
                        border:Border.all(width:blime, color: Colors.black54,),
                         color:  Color(0xFFCDDC39),
                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    onTap : (){
                      setState((){
                         bblue = 0.0;bgreen=0.0;borange=0.0;byellow=0.0;bred=0.0;bpurple=0.0;bpink=0.0;
                         bbrown=0.0;bwhite=0.0;bblack=0.0;blime=2.0;bcyan=0.0;
                         habit.color =   Color(0xFFCDDC39).value.toString();
                      });
                    }
                  ),
                ),
                 Container(
                 
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  width:30,
                  height : 30,
                  //color: Colors.green,
                  child: GestureDetector(
                    child:Container(
                       decoration: BoxDecoration(
                        border:Border.all(width:bcyan, color: Colors.black54,),
                         color:  Color(0xFF00BCD4),
                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    onTap : (){
                      setState((){
                         bblue = 0.0;bgreen=0.0;borange=0.0;byellow=0.0;bred=0.0;bpurple=0.0;bpink=0.0;
                         bbrown=0.0;bwhite=0.0;bblack=0.0;blime=0.0;bcyan=2.0;
                         habit.color =  Color(0xFF00BCD4).value.toString();
                      });
                    }
                  ),
                ),
            ],),
            Padding(padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
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

  void setWeekDays(){
    habit.repetition = onmonday.toString() + ' ' + ontuesday.toString() + ' ' + onwend.toString() +' '+onthur.toString()+' '+onfriday.toString()+' '+onsat.toString()+' '+onsun.toString();
  }


  //save to database
  void _save() async {


    fillforNow();
    moveToLastScreen();
    setWeekDays();


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


