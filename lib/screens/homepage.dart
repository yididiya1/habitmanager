// import 'dart:wasm';

// import 'package:flutter/material.dart';
// import 'package:habitmanager1/screens/add_habit_page.dart';
// import 'package:habitmanager1/screens/drawer.dart';
// import 'package:habitmanager1/util/dbhelper.dart';
// import 'package:habitmanager1/widgets/circular_progress.dart';
// import 'package:habitmanager1/screens/detail_page.dart';
// import 'package:habitmanager1/entities/Habit.dart';
// import 'package:sqflite/sqflite.dart';

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// //List<Habit> habits = [Habit( 'Running','Two miles per day', 30),Habit( 'BasketBall','Post Up Moves', 30),Habit( 'Reading', 'Flutter in Action',60)];


// class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

//   AnimationController progressController ;
//   Animation<double> animation;

//   DatabaseHelper databaseHelper = DatabaseHelper();
//   List<Habit> habitList;
//   List<Habit> onGoingHabits;
//   List<Habit> doneHabits;
//   int count = 0;
//   List<Color> colors =[Colors.green,Colors.red,Colors.yellow,Colors.blue,Colors.amberAccent,Colors.lime,Colors.pink];
//   Color newcolor;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     updateListView();
//     progressController = AnimationController(vsync: this,duration: Duration(milliseconds: 2000));
//     animation = Tween<double>(begin: 0,end: 80).animate(progressController)..addListener((){
//       setState(() {

//       });
//     });
//     //addOnGoing();


//   }


//   @override
//   Widget build(BuildContext context) {

//      if(habitList == null){
//       habitList = List<Habit>();
//       updateListView();
//      // addOnGoing();
//     }

//     // return Scaffold(
//     //  // backgroundColor: Colors.black12,
//     //   appBar: AppBar(
//     //     //leading: Icon(Icons.menu),
//     //     title: Text('Habit Manager',style: TextStyle(fontFamily:'JosefinSans'),),
//     //      actions: [
//     //       Icon(Icons.favorite),
//     //       Padding(
//     //         padding: EdgeInsets.symmetric(horizontal: 16),
//     //         child: Icon(Icons.search),
//     //       ),
//     //       Icon(Icons.more_vert),
//     //     ],
//     //     backgroundColor: Colors.black,
//     //   ),
//     //   drawer: HomeDrawer(),
//     //   body:// SingleChildScrollView(
//           //scrollDirection: Axis.vertical,
//           //child: Column(
//             //  children: <Widget>[
//               //  SizedBox(height: 20,),
//                // SingleChildScrollView(
//                  // scrollDirection: Axis.vertical,
//                   //child:
//              return     ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: count,
//                       itemBuilder: (context,index){
//                         return GestureDetector(
//                           onTap: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(data: habitList[index],)));
//                           },
//                           child: Container(
                            
//                             width: MediaQuery.of(context).size.width,
//                             padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: .0),
//                             child: Card(
//                               margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                               elevation: 5.0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(0.0),
//                               ),
//                               color: Colors.white,
//                               child: Container(
//                                 // decoration: BoxDecoration(
//                                 //   border: Border.all(color:colors[index],width:3.0),
//                                 // ),
//                                 child: Column(
//                                   children: <Widget>[
//                                     Container(
//                                       color:new Color(int.parse(habitList[index].color)),
//                                       height: 20.0,
//                                       child: Row(
                                        
//                                         mainAxisAlignment: MainAxisAlignment.end,
//                                         children: <Widget>[
//                                            Container( 
//                                                padding: EdgeInsets.only(right:5.0),
//                                                       decoration: BoxDecoration(
//                                                         boxShadow: [
//                                                           BoxShadow(color: Colors.black, spreadRadius:3.2),
//                                                         ],                                                     
//                                                       ),
//                                                       //color: Colors.white,
//                                                       width: 30,
//                                                       height: 15,
//                                                       child: IconButton(
//                                                         padding: EdgeInsets.fromLTRB(7,0,0,0),
//                                                         iconSize: 15,
//                                                         color: Colors.white,
//                                                         icon : Icon(Icons.edit),
//                                                         onPressed: (){
                                                         
//                                                         },

//                                                       )
//                                                   ),
//                                           SizedBox(width:5.8),
                                          
//                                            Container(
                                                     
//                                                       decoration: BoxDecoration(
//                                                         boxShadow: [
//                                                           BoxShadow(color: Colors.black, spreadRadius: 3.2),
//                                                         ],                                                     
//                                                       ),
//                                                       width: 30,
//                                                       height: 15,
//                                                       child: IconButton(
//                                                         padding: EdgeInsets.fromLTRB(0,0,0,0),
//                                                         iconSize: 15 ,
//                                                         color: Colors.white,
//                                                         icon : Icon(Icons.delete),
//                                                         onPressed: (){
//                                                           _delete(context, habitList[index]);
//                                                         },

//                                                       )
//                                                   ),
//                                       ],),
//                                     ),
//                                     Row(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                       children:<Widget>[
//                                         Padding(
//                                         padding:EdgeInsets.fromLTRB(0,10,10,10),
//                                         child: Center(
//                                             child: CustomPaint(
//                                               foregroundPainter: CircularProgress(animation.value,colors[index]),
//                                               child: Container(
//                                                 width: 65,
//                                                 height: 65,
//                                                  child: GestureDetector(
//                                                     onTap: (){
//                                                     if(animation.value == 80){
//                                                       progressController.reverse();
//                                                     }else{
//                                                       progressController.forward();
//                                               }
//                                             },
//                                                   child: Center(child: Text('${animation.value.toInt()}%',style:
//                                             TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold
//                                             ),
//                                             ),)
//                                           ),
//                                           ),
//                                         ),
//                                         ),
//                                       ),
//                                         Container(
//                                           padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
//                                           width: 107,
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: <Widget>[
//                                               SizedBox(height: 5,),
//                                               Text(this.habitList[index].habitName.toString(),
//                                                 style: TextStyle(
//                                                     color: Colors.deepPurple,
//                                                     fontWeight: FontWeight.w500,
//                                                     fontSize: 18,

//                                                 ),),

//                                               Text(this.habitList[index].habitDescription.toString(),
//                                                 style: TextStyle(
//                                                   fontSize: 12,
//                                                   fontStyle: FontStyle.italic
//                                               ),),

//                                               SizedBox(height: 20,),
//                                           ],
//                                       ),
//                                         ),

//                                         Container(
//                                           padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
//                                           child: Column(
//                                               children: <Widget>[

//                                             Container(
//                                               padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
//                                               child: Row(
//                                                 children: <Widget>[

//                                                    Text(habitList[index].numberOfDays.toString()
//                                                    ,style: TextStyle(
//                                                        fontSize: 25,
//                                                        fontWeight: FontWeight.bold,
//                                                      ),
//                                                    ),
//                                                    Padding(
//                                                      padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
//                                                      child: Text('days',
//                                                      style: TextStyle(
//                                                        fontSize: 10,
//                                                      ),),
//                                                    ),
//                                                 ]),
//                                             )
                                             
//                                           ]),
//                                         ),


//                                     ]),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
                        
//                         );
//                       }
//                   );
              
//       //  floatingActionButton: FloatingActionButton(
//       //   onPressed:(){
//       //     navigateToAddPage(Habit(' ',' ',2,'2000-08-2','2000-08-3',0,'','','',''));
//       //   },
//       //   backgroundColor: Colors.black,
//       //   child: Icon(Icons.add,color: Colors.white,),
//       // ),
//       // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

//       // bottomNavigationBar: BottomAppBar(
//       //   shape: CircularNotchedRectangle(),
//       //   child: Row(
//       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //     children: <Widget>[
//       //       IconButton(
//       //         icon: Icon(Icons.settings),
//       //         onPressed: (){},
//       //       ),
//       //       // IconButton(
//       //       //   icon: Icon(Icons.more_vert),
//       //       //   onPressed: (){},
//       //       // )
//       //     ],
//       //   ),
//       // ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     //);
//   }


//   void _delete(BuildContext context, Habit habit) async {
//     int result = await databaseHelper.deleteHabit(habit.id);
//     if(result != 0){
//       _showSnackBar(context,'Note Deleted Successfully');
//       updateListView();
//     }
//   }

//   void _showSnackBar(BuildContext context, String message){
//     final snackBar = SnackBar(content: Text(message));
//     Scaffold.of(context).showSnackBar(snackBar);
//   }

//    void navigateToAddPage(Habit habit)async{
//     bool result = await Navigator.push(context, MaterialPageRoute(builder:(context){
//       return AddHabitPage(habit);
//     }));

//     if(result == true){
//       updateListView();   
//     }
//   }
  
//   void updateListView(){
//     final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//     dbFuture.then((database){
//       Future<List<Habit>> habitListFuture = databaseHelper.getHabitList();
//       habitListFuture.then((habitList) {
//         setState(() {
//           this.habitList = habitList;
//           this.count = habitList.length;
//         });
//       });
//     });
//   }

//   void addOnGoing(){
//     for(int i=0; i<habitList.length;i++){
//       if(habitList[i].numberOfDays == habitList[i].numberOfDaysCompleted){
//         doneHabits.add(habitList[i]);
//       }
//     }
//   }

// }
