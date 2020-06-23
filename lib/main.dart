import 'package:flutter/material.dart';
import 'package:habitmanager1/HabitLists.dart';
import 'package:habitmanager1/add_habit_page.dart';

import 'CustomButton.dart';
import 'Habit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {

  final GlobalKey<_HabitLists> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //HabitLists(key: _key,)
      body:HabitLists(key: _key,),

      floatingActionButton: FloatingActionButton(
        onPressed:(){

          showDialog(
            barrierDismissible: false,
              context: context,
            builder:(BuildContext context){
                return Dialog(
                  child: AddHabitPage(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular((12)))
                  ),
                );
            }
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: (){},
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}





class HabitLists extends StatefulWidget{
  HabitLists({Key key}): super(key:key);

  @override
  _HabitLists createState() => _HabitLists();
}


class _HabitLists extends State<HabitLists>{

  List<Habit> habits = [Habit(habitName: 'first', habitDescription: 'first Descrition', numberOfDays: 30),Habit(habitName: 'Jeffirst', habitDescription: 'Jeffirst Descrition', numberOfDays: 30),Habit(habitName: 'second', habitDescription: 'secdff', numberOfDays: 60)];


  void setHabit(Habit habit){
    habits.add(habit);
  }

  @override
  Widget build(BuildContext context) {
    return myListView(context,habits);
  }

}

Widget myListView(BuildContext context,List<Habit> habits){
  return ListView.builder(
      shrinkWrap: true,
      itemCount: habits.length,
      itemBuilder: (context,index){
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.red,
            child: Column(
              children: <Widget>[
                Text(habits[index].habitName, style: TextStyle(color: Colors.deepPurple),),
                Text(habits[index].habitDescription),
                Text(habits[index].numberOfDays.toString()),
              ],
            ),
          ),
        );
      }
  );
}

