import 'package:flutter/material.dart';
import 'package:habitmanager1/screens/setting.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children:<Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            width: double.infinity,
            height: 200.0,
            color:Colors.black54,
            child:Center(
              child: Column(
                children: <Widget>[
                  Container(

                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Setting',style:TextStyle(fontSize: 18)),
            onTap: (){
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage())); 
            },
          ),
           ListTile(
            leading: Icon(Icons.find_replace),
            title: Text('Setting',style:TextStyle(fontSize: 18)),
            onTap: (){
              
            },
          ),
           ListTile(
            leading: Icon(Icons.insert_invitation),
            title: Text('Setting',style:TextStyle(fontSize: 18)),
            onTap: (){
              
            },
          ),
           ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('Setting',style:TextStyle(fontSize: 18)),
            onTap: (){
              
            },
          ),
        ]
      ),
    );
  }
}