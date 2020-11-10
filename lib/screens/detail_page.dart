import 'package:flutter/material.dart';
import 'package:habitmanager1/util/dbhelper.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../entities/Habit.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class DetailPage extends StatefulWidget {

  final Habit data;
  DetailPage({this.data});

  @override
  _DetailPage createState() => _DetailPage(this.data);
}

class _DetailPage extends State<DetailPage> with TickerProviderStateMixin{

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Habit> habitList;
  int count = 0;
  Habit data1;
  _DetailPage(this.data1);

  Map<DateTime, List> _events = {};
  Map<DateTime, List> _holidays = {};

   Map<DateTime, List> _events2 = {};
  Map<DateTime, List> _holidays2 = {};
 
  List _selectedEvents;
  
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
   
    super.initState();
    initializeDateFormatting();
    
    addDatesComptolist(data1.daysCompleted);
    addDatesUncomptolist(data1.daysUncompleted);
 
   
    final _selectedDay = DateTime.now();

    // _events = addDatesComptolist(data1.daysCompleted ,_events2 );
    // _holidays = addDatesUncomptolist(data1.daysUncompleted, _holidays2);

    //_selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  Map<DateTime, List<dynamic>> addDatesComptolist(String alldates){
    List<String> dates = [];
    
    if(!(alldates==' ')){
    dates = alldates.split(" ");
    for(int i =0;i<dates.length;i++){
      if(dates[i] != ''){
      DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(dates[i]);
      _events[tempDate] = [' '];
    }
    }
    
    }
    return _events;
  }

    Map<DateTime, List<dynamic>> addDatesUncomptolist(String alldates){
    List<String> dates = [];
    
    if(!(alldates==' ')){
    dates = alldates.split(" ");
    for(int i =0;i<dates.length;i++){
      if(dates[i] != ''){
      DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(dates[i]);
      _holidays[tempDate] = [' '];
      }
    }
   
    }
    return _holidays;
  }

  
  String listStringToString(List<String> list){
    list.removeWhere((v) => v == null);
    return list.join(" ");
  }
    
  void updatedaysCompleted(){
    //data1.daysCompleted = dcomp;  
  }
  void updatedaysUncompleted(){
    //data1.daysUncompleted = duncomp;
  }

  void printEvents(Map x){
    for(int i = 0;i<x.length;i++ ){
      print('');
    }
  }

  void printHoildays(){

  }

  void _showSnackBar(BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void moveToLastScreen(){
    Navigator.pop(context,true);
  }
  void _save() async {

    //moveToLastScreen();

    int result;
    if(data1.id != null){
      //case 1 : update operation
     // print('null data');
      result = await databaseHelper.updateHabit(data1);
    }else{ //insert operation
      result = await databaseHelper.insertHabit(data1);
    }

    if(result != 0 ){
      _showAlertDialog('Status', 'Habit Saved Successfully');
      print('saved successfully');
      print(data1.habitName);
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

  @override
  Widget build(BuildContext context) {
    // addDatesComptolist(data1.daysCompleted);
    // addDatesUncomptolist(data1.daysUncompleted);
    return WillPopScope(
          onWillPop: ()async{
           
            moveToLastScreen();
            print('pop that ass up');
           return true;
          },
          child: Scaffold(
        //resizeToAvoidBottomInset: false,
          appBar: AppBar(
          elevation:0.0,
          leading: IconButton(
            icon:Icon(Icons.arrow_back),
            onPressed: (){
              //updatedaysCompleted();
              _save();
              //print('imma pop it up in');
             // print(data1.daysCompleted);
              moveToLastScreen();
            },
            ),
          //title: Text('Page title',style: TextStyle(fontFamily:'JosefinSans'),),
           actions: [
              IconButton(
              icon: Icon(Icons.more_vert,color: Colors.white,),
              onPressed: (){},
            )
            //Icon(Icons.favorite),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   child: Icon(Icons.search),
            // ),
            // Icon(Icons.more_vert),
          ],
          backgroundColor:new Color(int.parse(data1.color)), 
        ),
          body:SingleChildScrollView(
                      child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Switch out 2 lines below to play with TableCalendar's settings
              //-----------------------
              Container(
                height: 170,
                decoration: BoxDecoration(
                  color:new Color(int.parse(data1.color)),

                ),
                
                
                child: Column(
                        children: <Widget>[
                              // Container(
                              //   padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children:<Widget>[
                              //       IconButton(
                              //         icon:Icon(Icons.arrow_back,color: Colors.white,),
                              //         onPressed: (){
                              //           _save();
                              //           moveToLastScreen();
                              //         },
                              //       ),
                              //       IconButton(
                              //         icon: Icon(Icons.more_vert,color: Colors.white,),
                              //         onPressed: (){},
                              //       )
                              //     ]

                              //   ),
                              
                              // ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: 200,
                                                //height: 70,
                                                child: Text(
                                                  data1.habitName,
                                                  style: TextStyle(
                                                    fontSize: 35.0,
                                                    color:Colors.white,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height:0),
                                              Container(
                                                width: 200,
                                                height: 70,
                                                child: Text(
                                                  data1.habitDescription,
                                                  style: TextStyle(
                                                    color:Colors.white70,
                                                    fontSize: 16.0,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Days Left : ${data1.numberOfDays - data1.numberOfDaysCompleted}',
                                                style: TextStyle(
                                                  color:Colors.white,
                                                  fontSize:18,
                                                  fontWeight:FontWeight.bold,
                                                ),
                                              ),

                                            ],
                                          ),
                                          
                                        ),
                                        Column(
                                            children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                  height: 100,
                                                  width: 100,
                                                  child: LiquidCircularProgressIndicator(
                                                    value: (data1.numberOfDaysCompleted/data1.numberOfDays), // Defaults to 0.5.
                                                    valueColor: AlwaysStoppedAnimation(Colors.white), // Defaults to the current Theme's accentColor.
                                                    backgroundColor: new Color(int.parse(data1.color)), // Defaults to the current Theme's backgroundColor.
                                                    borderColor: Colors.white,
                                                    borderWidth: 5.0,
                                                    direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                                    center: Text("${((data1.numberOfDaysCompleted/data1.numberOfDays)*100).round()}%",style: TextStyle(color:Colors.black54,fontWeight: FontWeight.bold),),
                                                  ),
                                                ),SizedBox(height:10),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(12,0,0,0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                          '${data1.numberOfDays}'
                                                          ,style: TextStyle(
                                                            fontSize: 30,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                      ),
                                                      Text('Days',style:TextStyle(color:Colors.white)),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                        ),
                                        //SizedBox(height:10),
                                        
                                    ],
                            ),
                            
                        ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
                child: Text('Daily Status'
                  ,style: TextStyle(
                    fontSize:25,
                    fontWeight:FontWeight.bold,
                  ),
                ),
              ),
              Container(
                    child: _buildTableCalendarWithBuilders()
              ),
               //_buildTableCalendarWithBuilders(),
              const SizedBox(height: 8.0),
              //_buildButtons(),
              Text(data1.daysCompleted.toString()),
              Text('========================'),
              Text(data1.daysUncompleted.toString()),
              //Text(dcomp),
              const SizedBox(height: 8.0),
              Text(data1.color),
              Text(data1.reminders),
              Text(data1.repetition),
              Text(data1.dayStarted),
              Text(data1.numberOfDaysCompleted.toString()),
              Text(data1.habitDescription),
              Text(data1.habitName),
              //Expanded(child: _buildEventList()),
            ],
        ),
          ),
      ),
    );
  }
  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      //onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'en_US',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 5,
                bottom: 8,
                child: _buildEventsMarker(),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: 5,
                top: 5,
                child: _buildHolidaysMarker(),
              ),
            );
          }
        return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onDayLongPressed: (date, events){
        //addDatesComptolist(data1.daysCompleted);
        //addDatesUncomptolist(data1.daysUncompleted);
         var y =  DateFormat("yyyy-MM-dd").format(date) ;
          var x =  DateFormat("yyyy-MM-dd").format(date) + ' ';
          if((!data1.daysCompleted.contains(y) && !data1.daysUncompleted.contains(y))){
             // _events2[date]=[' '];
             // _holidays2.remove(date);
              setState(() {
                _events[date]=[' '];
                _holidays.remove(date);
                //_events = _events2;
                //_holidays = _holidays2;
                data1.daysCompleted = data1.daysCompleted + ' '+ DateFormat("yyyy-MM-dd").format(date);
                data1.numberOfDaysCompleted++;
                // _holidays.remove(date);
                 //_holidays[date] = [' '];
                 //data1.daysUncompleted = data1.daysUncompleted + ' '+ DateFormat("yyyy-MM-dd").format(date);
                 //data1.daysCompleted= data1.daysCompleted.replaceAll(x, '');
                // addDatesComptolist(data1.daysCompleted);
                // addDatesUncomptolist(data1.daysUncompleted);
                
                // _save();
              });
              
            }else if(data1.daysCompleted.contains(y) && !data1.daysUncompleted.contains(y)){
             
                // _events2.remove(date);
                // _holidays2[date] = [' '];
                setState(() {
                  _events.remove(date);
                  _holidays[date] = [' '];
                  // _events = _events2;
                  // _holidays = _holidays2;
                  //_holidays.remove(date);
                  //data1.daysUncompleted= data1.daysUncompleted.replaceAll(x, '');
                  data1.daysUncompleted = data1.daysUncompleted + ' '+ DateFormat("yyyy-MM-dd").format(date);
                  data1.daysCompleted= data1.daysCompleted.replaceAll(y, '');
                  data1.numberOfDaysCompleted--;
                  // addDatesComptolist(data1.daysCompleted);
                  // addDatesUncomptolist(data1.daysUncompleted);
                  //_save();
                });
                 
            }
            else if(!data1.daysCompleted.contains(y) && data1.daysUncompleted.contains(y) ){
              //  _holidays2.remove(date);
              //   _events2.remove(date);
              setState(() {
                _holidays.remove(date);
                _events.remove(date);
                // _events = _events2;
                // _holidays = _holidays2;
                //data1.daysCompleted = data1.daysCompleted + ' '+ DateFormat("yyyy-MM-dd").format(date);
                data1.daysUncompleted= data1.daysUncompleted.replaceAll(y, '');
                data1.daysCompleted= data1.daysCompleted.replaceAll(y, '');
                //dcomp = dcomp + ' '+ DateFormat("yyyy-MM-dd").format(date);
                //data1.daysCompleted = dcomp;
                
                //updatedaysCompleted();
                // addDatesUncomptolist(data1.daysCompleted);
                // addDatesComptolist(data1.daysCompleted);
                //addDatesUncomptolist(data1.daysUncompleted);
                //_save();
              });
               
            
            }
      
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker() {
    return Icon(
      Icons.check,
      size: 35.0,
      color: Colors.green,
    );
}

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.close,
      size: 35.0,
      color: Colors.red,
    );
  }

 
  
}











//static String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
//DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
//String x = '2020-08-2 2020-08-3 2020-08-6 2020-08-4 2020-08-5';


//convert reptitiions to list of days 
//covert reminders to list of time 
//UI finish 
//Setting
//import export