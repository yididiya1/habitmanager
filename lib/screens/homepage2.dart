

import 'package:flutter/material.dart';
import 'package:habitmanager1/entities/Habit.dart';
import 'package:habitmanager1/screens/add_habit_page.dart';
import 'package:habitmanager1/screens/detail_page.dart';
import 'package:habitmanager1/screens/homepage.dart';
import 'package:habitmanager1/util/dbhelper.dart';
import 'package:habitmanager1/widgets/circular_progress.dart';
import 'package:sqflite/sqflite.dart';



//var recentNames=['dog','cat'];
var habitList2=[];
List<Habit> habitListCopy=[];
class HomePage2 extends StatefulWidget {
  //HomePage2({Key key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> with TickerProviderStateMixin{

  // MyHomePage myHomePage = new MyHomePage();
  TabController tabController;
  Color c1 =  Color(0xFF270AFE);
  Color c2 =  Color(0xFF270AFE);
  Color c3 = Colors.white;
  Color c4 = Colors.white;
  Color c5 = Colors.white;

  Color t1 =  Colors.white;
  Color t2 = Colors.white;
  Color t3 = Color(0xFF969DA9);
  Color t4 = Color(0xFF969DA9);
  Color t5 = Color(0xFF969DA9);

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Habit> habitList;
  List<Habit> onGoingHabits = [];
  List<Habit> doneHabits = [];
  int count = 0;
  bool isdone = false;
  

  AnimationController progressController ;
  Animation<double> animation;

 
  List<Color> colors =[Colors.green,Colors.red,Colors.yellow,Colors.blue,Colors.amberAccent,Colors.lime,Colors.pink];
  Color newcolor;
   
  List<dynamic> choices  = ['a','b','c']; 
  List<String> nn = [];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this,initialIndex: 0);
    updateListView();
    //addHabitNames();
    progressController = AnimationController(vsync: this,duration: Duration(milliseconds: 2000));
    animation = Tween<double>(begin: 0,end: 80).animate(progressController)..addListener((){
      setState(() {

      });
    });
    
    //habitList2 = habitList;
    //addOnGoing(habitList);
  }
  @override
  Widget build(BuildContext context) {
    if(habitList == null){
      habitList = List<Habit>();
      updateListView();
      //addOnGoing();
      //addOnGoing();
    }
    // if(onGoingHabits.isEmpty){
    //   addOnGoing();
    // }

    
    //addNames(habitList);
    //addHabitNames();
    habitList2 = addNames(habitList);
    habitListCopy = habitList;
    //deleteAll(context, habitList);
    //addHabitNames();
    // if(! doneHabits.isEmpty){
    //   setState(() {
    //     isdone = true;
    //   });
    // }else if(doneHabits == []){
    //   setState(() {
    //     isdone =false;
    //   });
    // }else if(doneHabits == null){
    //   setState(() {
    //     isdone = false;
    //   });
    // }
    // return MaterialApp(
    //     theme: ThemeData.dark().copyWith(
    //     primaryColor: Color(0xFF0A0E21),
    //     scaffoldBackgroundColor:Color(0xFFF5F6FC),
    //     textTheme: TextTheme(body1: TextStyle(color:Color(0xFF525355)))
    //     ),
    return  Scaffold(
          floatingActionButton: FloatingActionButton(
          onPressed:(){
          navigateToAddPage(Habit(' ',' ',2,'2000-08-2','2000-08-3',0,'','','',Color(0xFF4CAF50).value.toString()),'Add new Habit');
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.add,color: Colors.white,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
         body: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
             children: <Widget>[
               
               Container(
                 padding: EdgeInsets.fromLTRB(10,45,0,0),
                 child: Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                       Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 0),
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(90.0),

                              child: Image.asset('assets/images/kk.png')),
                        ),
                       SizedBox(width:25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:<Widget>[
                            Text('Mon, 05 October 2020',
                            
                                ),
                            SizedBox(height: 7,),
                            Text('Hi, Yididiya',
                              style: TextStyle(
                                    color:Color(0xFF969DA9),
                                    fontSize: 18,
                                  ),),
                          ]
                        ),
                        Spacer(),
                        GestureDetector(
                          child:Icon(
                          Icons.search,color:Color(0xFF969DA9),size: 25,
                          
                          ),
                          onTap: (){
                            print('Habit names length = ${nn.length}');
                            showSearch(context: context, delegate: HabitSearch(habitList2,['abc','def','feg'],habitList));
                            
                            //deleteAll(context, habitList);
                            //updateListView();
                          },
                        ),
                        SizedBox(width: 5,),
                        
                        
                   ],
                  ),
               ),
               SizedBox(height:20),
              //  Center(
              //    child: Text(
              //      '"Some Medium Sized Random Qoute"',
              //      style: TextStyle(
              //        fontSize:17,
              //        fontWeight: FontWeight.w500,
              //      ),
              //    ),
              //  ),
              // SizedBox(height:10),
              //  Container(
              //    padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
              //    child: Row(
              //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //      //crossAxisAlignment: CrossAxisAlignment.stretch,
              //      children: <Widget>[
              //         Container(
              //             height: 50,
              //             width: 260,
              //             padding: EdgeInsets.all(8),
              //             decoration: BoxDecoration(
              //                 color: Colors.white,
              //                 borderRadius: BorderRadius.circular(15)
              //             ),
              //             child: TextField(
                                       
              //               decoration: InputDecoration(
              //                   border: InputBorder.none,
              //                   prefixIcon: Icon(Icons.search,color: Colors.black87,),
              //                   hintText: "Find Habit",
              //                   hintStyle: TextStyle(color: Colors.grey,fontSize: 15)
                                
              //               ),
              //               style: TextStyle(
              //                 color:Colors.black87,
              //               ),
              //               onTap: (){
              //                 showSearch(context: context, delegate: HabitSearch());
              //               },
              //             ),
              //           ),
              //           Container(
              //             height: 50,
              //             width: 50,
              //             decoration: BoxDecoration(
              //                color: Color(0xFF270AFE) ,
              //                borderRadius: BorderRadius.circular(15),         
              //             ),
                         
              //             child: Icon(Icons.movie_filter)
              //           )
              //      ],
              //    )
              //    ),
                  Container(
                    height: 100,
                    child: TabBar(
                      controller: tabController,
                      indicatorColor:Colors.white,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 1.0,
                      isScrollable: false,
                      
                      labelColor: Color(0xFF440206),
                      unselectedLabelColor: Color(0xFF440206),
                      onTap: (f){
                        setState(() {
                          if(f==0){
                            c2 = c1;
                            c3 =c5;
                            c4 =c5;
                            t2 = t1;
                            t3 = t5;
                            t4 = t5; 
                          }else if(f ==1){
                            c3 = c1;
                            c4 = c5;
                            c2 = c5;
                            t3 = t1;
                            t4 = t5;
                            t2 = t5;

                          }else if(f == 2){
                            c4 = c1;
                            c2 = c5;
                            c3 = c5;
                            t4 = t1;
                            t2 = t5;
                            t3 = t5;
                          }
                        });
                      },
                      tabs: <Widget>[
                        Container(
                          height: 100,
                          //width: 100,
                          child: Tab(
                            
                            child:Container(
                              width: 90,
                              // height:250,
                             
                              decoration: BoxDecoration(
                                 color: c2,
                                 borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:<Widget>[
                                  SizedBox(height:3),
                                  //SizedBox(height:3),
                                  Text('${habitList.length}',style: TextStyle(fontSize:35,color: t2),),
                                  Text('Active',style: TextStyle(color:t2),),
                                  SizedBox(height:3),
                                ]
                              ),
                            )
                          ),
                        ),
                        Container(
                          height: 100,
                          //width: 100,
                          child: Tab(
                            child:Container(
                              width: 90,
                               decoration: BoxDecoration(
                                 color: c3,
                                 borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              // height:250,
                              
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:<Widget>[
                                  SizedBox(height:3),
                                  Text('${habitList.where((element) => (element.numberOfDays-element.numberOfDaysCompleted!=0)).toList().length}',style: TextStyle(fontSize:35,color: t3),),
                                  Text('Ongoing',style: TextStyle(color:t3),),
                                  SizedBox(height:3),
                                ]
                              ),
                            )
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          child: Tab(
                            child:Container(
                              width: 90,
                               decoration: BoxDecoration(
                                 color: c4,
                                 borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              // height:250,
                              
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:<Widget>[
                                  SizedBox(height:3),
                                  Text('${habitList.where((element) => (element.numberOfDays-element.numberOfDaysCompleted==0)).toList().length}',style: TextStyle(fontSize:35,color:t4),),
                                  Text('Done',style: TextStyle(color:t4),),
                                  SizedBox(height:3),
                                ]
                              ),
                            )
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    //height: ,
                    //constraints: BoxConstraints.expand(),
                    child: TabBarView(
                      controller: tabController,
                      children: <Widget>[
                        Container(
                          child: HabitLists(habitList),),
                       
                        Container(
                          child: HabitLists(habitList.where((element) => (element.numberOfDays-element.numberOfDaysCompleted!=0)).toList()),
                        ),
                           
                        Container(
                         
                         child:HabitLists(habitList.where((element) => (element.numberOfDays-element.numberOfDaysCompleted==0)).toList()),
                        ),
                      ],
                    ),
                  ),
             ],
           ),
        // )
       
    );
  }
 
Widget HabitLists(List<Habit> habitLiset){
  return   ListView.builder(
          shrinkWrap: true,
          itemCount: habitLiset.length,
          itemBuilder: (context,index){
            return Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(data: habitLiset[index],)));
                },
                child: Container(
                  
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: .0),
                  child: Card(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      //side: BorderSide(),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.white,
                    child: Container(
                      // decoration: BoxDecoration(
                      //   border: Border.all(color:colors[index],width:3.0),
                      // ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0,2,0,0),
                            //color:new Color(int.parse(habitList[index].color)),
                            height: 10.0,
                            width: 200.0,
                            decoration: BoxDecoration(
                              color:new Color(int.parse(habitLiset[index].color)),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                
                                //   Container( 
                                //       padding: EdgeInsets.only(right:5.0),
                                //             decoration: BoxDecoration(
                                //               boxShadow: [
                                //                 BoxShadow(color: Colors.black, spreadRadius:3.2),
                                //               ],                                                     
                                //             ),
                                //             //color: Colors.white,
                                //             width: 30,
                                //             height: 15,
                                //             child: IconButton(
                                //               padding: EdgeInsets.fromLTRB(7,0,0,0),
                                //               iconSize: 15,
                                //               color: Colors.white,
                                //               icon : Icon(Icons.edit),
                                //               onPressed: (){
                                                
                                //               },

                                //             )
                                //         ),
                                // SizedBox(width:5.8),
                                
                                //   Container(
                                            
                                //             decoration: BoxDecoration(
                                //               boxShadow: [
                                //                 BoxShadow(color: Colors.black, spreadRadius: 3.2),
                                //               ],                                                     
                                //             ),
                                //             width: 30,
                                //             height: 15,
                                //             child: IconButton(
                                //               padding: EdgeInsets.fromLTRB(0,0,0,0),
                                //               iconSize: 15 ,
                                //               color: Colors.white,
                                //               icon : Icon(Icons.delete),
                                //               onPressed: (){
                                //                 _delete(context, habitList[index]);
                                //               },

                                //             )
                                //         ),
                            ],),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:<Widget>[
                              Padding(
                              padding:EdgeInsets.fromLTRB(0,10,10,10),
                              child: Center(
                                  child: CustomPaint(
                                    foregroundPainter: CircularProgress(animation.value,new Color(int.parse(habitLiset[index].color))),
                                    child: Container(
                                      width: 65,
                                      height: 65,
                                        child: GestureDetector(
                                          onTap: (){
                                          if(animation.value == 80){
                                            progressController.reverse();
                                          }else{
                                            progressController.forward();
                                    }
                                  },
                                        child: Center(child: Text('${animation.value.toInt()}%',style:
                                  TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),
                                  ),)
                                ),
                                ),
                              ),
                              ),
                            ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                width: 107,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 5,),
                                    Text(habitLiset[index].habitName.toString(),
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,

                                      ),),

                                    Text(habitLiset[index].habitDescription.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black38,
                                        fontStyle: FontStyle.italic
                                    ),),

                                    SizedBox(height: 20,),
                                ],
                            ),
                              ),

                              Container(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Column(
                                    children: <Widget>[

                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                          Text(habitLiset[index].numberOfDays.toString()
                                          ,style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                                            child: Text('days',
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),),
                                          ),
                                        //PopUpMenuOption(),
                                        // Container(
                                        //   margin: EdgeInsets.fromLTRB(0, 0,0, 0),
                                        //   child: PopupMenuButton<MenuOption>(
                                        //     onSelected: (value){
                                        //       if(value == MenuOption.Delete){
                                        //         _delete(context,habitList[index]);
                                        //       }
                                        //     },
                                        //     itemBuilder: (BuildContext context){
                                        //       return <PopupMenuEntry<MenuOption>>[
                                        //         PopupMenuItem(
                                        //           child:Icon(Icons.delete),
                                        //           value: MenuOption.Delete, 
                                        //         ),
                                        //         PopupMenuItem(
                                        //           child:Icon(Icons.save),
                                        //           value: MenuOption.Save, 
                                        //         ),
                                        //         PopupMenuItem(
                                        //           child:Icon(Icons.edit),
                                        //           value: MenuOption.Edit, 
                                        //         ),
                                        //       ];
                                        //     },
                                        //   ),
                                        // ),
                                      // GestureDetector(
                                      //   onTap: (){
                                      //     _delete(context, habitList[index]);
                                      //   },
                                      //   child: Icon(Icons.delete),
                                      // ),  
                                      
                                      ]),
                                    
                                  )
                                    
                                ]),

                              ),
                              Container(
                                          margin: EdgeInsets.fromLTRB(0, 0,0, 0),
                                          child: PopupMenuButton<MenuOption>(
                                            onSelected: (value){
                                              if(value == MenuOption.Delete){
                                                _delete(context,habitLiset[index]);
                                              }else if(value == MenuOption.Edit){
                                                navigateToAddPage(habitLiset[index],'Edit Habit');
                                              }
                                            },
                                            itemBuilder: (BuildContext context){
                                              return <PopupMenuEntry<MenuOption>>[
                                                PopupMenuItem(
                                                  child:Icon(Icons.delete),
                                                  value: MenuOption.Delete, 
                                                ),
                                                PopupMenuItem(
                                                  child:Icon(Icons.save),
                                                  value: MenuOption.Save, 
                                                ),
                                                PopupMenuItem(
                                                  child:Icon(Icons.edit),
                                                  value: MenuOption.Edit, 
                                                ),
                                              ];
                                            },
                                          ),
                                        ),


                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
              
              ),
            );
          }
      );
  } 
 void _delete(BuildContext context, Habit habit) async {
    int result = await databaseHelper.deleteHabit(habit.id);
    if(result != 0){
      _showSnackBar(context,'Note Deleted Successfully');
      updateListView();
      //addHabitNames();
    }
  }
  void deleteAll(BuildContext context, List<Habit> habits){
    for(int i =0;i < habits.length;i++){  
      setState(() {
        habits.removeAt(i);
      }); 
    }
  }

  void _showSnackBar(BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

   void navigateToAddPage(Habit habit,String title)async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder:(context){
      return AddHabitPage(habit,title);
    }));

    if(result == true){
      updateListView();   
    }
  }

  // void addHabitNames() async{
  //   for(int i=0; i<habitList.length;i++){
      
  //        habitNames.add(habitList[i].habitName);
  //   }
  // }
  
  List<String> addNames(List<Habit> list){
    List<String> names = [];
    for(int i = 0;i<list.length;i++){
      names.add(list[i].habitName);
      //rint(list[i].habitName);
    }
    return names;
  }

  void updateListView(){
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database){
      Future<List<Habit>> habitListFuture = databaseHelper.getHabitList();
      habitListFuture.then((habitList) {
        setState(() {
          this.habitList = habitList;
          this.count = habitList.length;
          addOnGoing();
        });
        
      });
    });
    //addHabitNames();
  }
 
  void addOnGoing(){
    print('${habitList.length}');
    for(int i=0; i<habitList.length;i++){
      if(habitList[i].numberOfDays == habitList[i].numberOfDaysCompleted){
            doneHabits.add(habitList[i]);
            print('Done');
            print(habitList[i].habitName);          
      }else{
        // if ((lists.singleWhere((it) => it.habitName == lists[i].habitName,
        //   orElse: () => null)) != null) {
      if(!onGoingHabits.contains(habitList[i])){

          // }else{
               
          //}
          onGoingHabits.add(habitList[i]);
          print('Ongoing');
          print(habitList[i].habitName); 
       
        
      }else{
          print('Already Exist');
          print(onGoingHabits.contains(habitList[i]));
          
      }
    }
    }
    
  }


   
  
}

enum MenuOption{Save,Delete,Edit}



class HabitSearch extends SearchDelegate<String>{

  List<String> habitNames;
  List<String> recentNames;
  List<Habit> habitLists;
  HabitSearch(this.habitNames,this.recentNames,this.habitLists);

 
  //addHabitNames();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed:(){
          query='';
          print('Habit names length = ${this.habitNames.length}');
          for(int i =0;i<this.habitNames.length;i++){
            print(this.habitNames[i]);
          }
          //print('Suggestion list = ${suggestionList.length}')
        }
      )
    ];
  }
  @override
  Widget buildResults(BuildContext context) {
    //close(context, null);
    //List<Habit> h = habitListCopy.where((element) => element.habitName == query).toList();
    //print('Habit Name is ${h[0].habitName}');
    return AddHabitPage(new Habit('','',0,'','',0,'','','',''), 'x');
    //Navigator.push(context, MaterialPageRoute(builder: (context)=>AddHabitPage(new Habit('','',0,'','',0,'','','',''), '')));
    //return ;
    
  }
  @override
  Widget buildLeading(BuildContext context) {
   return 
     IconButton(
       icon:AnimatedIcon(
         icon:AnimatedIcons.menu_arrow ,
         progress: transitionAnimation,
         ), 
       onPressed:(){

         close(context,null);
       }
    )
   ;
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    //addHabitNames();
    
    final suggestionList = query.isEmpty ?this.recentNames:this.habitNames.where((element) => element.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder:(context,index)=>ListTile(
        onTap: () {
          int h = this.habitNames.indexOf(suggestionList[index]);
          print('Index is $h');
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(data:this.habitLists[h])));
          //close(context,null);
          //Navigator.pop(context);
         // showResults(context);
          //close(context, null);
          print('Suggestion List Length = ${suggestionList.length}');
        },
        leading:Icon(Icons.cached),
        title: RichText(
          text:TextSpan(
            text:suggestionList[index].substring(0,query.length),
            style: TextStyle(fontWeight:FontWeight.bold,color:Colors.black),
            children: [
              TextSpan(
                text:suggestionList[index].substring(query.length),
                style: TextStyle(color:Colors.grey),
              )
            ]
          )
          ),
      ),
      itemCount: suggestionList.length,
    );
  }
  // void addHabitNames() async{
  //   for(int i=0; i<habitList2.length;i++){
      
  //        habitNames.add(habitList2[i].habitName.toString());
  //   }
  // }
}