import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'dart:io' show Platform;

class LocalNotifyManager{

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initSetting;
  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject => BehaviorSubject<ReceiveNotification>();
  LocalNotifyManager.init(){
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if(Platform.isIOS){
      requestIOSPermission();
    }
    initializePlatform();
  }

  requestIOSPermission(){
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>().requestPermissions(
        alert:true,
        badge:true,
        sound:true
    );

  }
  initializePlatform(){
    var initSettingAndroid = AndroidInitializationSettings('app_notification_icon');
    var initSettingIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestSoundPermission: true,
        requestBadgePermission: true,
        onDidReceiveLocalNotification: (id,title,body,payload) async{
          ReceiveNotification notification = ReceiveNotification(id: id, title: title, body: body,payload: payload);
          didReceiveLocalNotificationSubject.add(notification);
        }
    );
    initSetting = InitializationSettings(android:initSettingAndroid,iOS:initSettingIOS);
  }
  setOnNotificationReceive(Function onNotificationReceive){
    didReceiveLocalNotificationSubject.listen((notification) {
      onNotificationReceive(notification);
    });
  }
  setOnNotificationClick(Function onNotificationClick)async{
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification:(String payload)async{
          onNotificationClick(payload);
        }
    );
  }
  Future<void> showNotification() async{
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL ID',
      'CHANNEL NAME',
      'CHANNEL DESCRIPTION',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
      icon:'icon_notification_replace',
      largeIcon: DrawableResourceAndroidBitmap('icon_large_notification'),
      timeoutAfter: 5000,
      enableLights: true,
    );
    var iosChannel = IOSNotificationDetails();
    var platformChannel =NotificationDetails(android: androidChannel,iOS: iosChannel);
    await flutterLocalNotificationsPlugin.show(
        0,
        'Test Title',
        'Test Body',
        platformChannel,
        payload: 'New Payload'
    );
  }
  Future<void> scheduleNotification() async{
    var scheduleNotificationDateTime = DateTime.now().add(Duration(seconds: 10));
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL ID 1',
      'CHANNEL NAME 1',
      'CHANNEL DESCRIPTION 1',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
      icon:'icon_notification_replace',
      largeIcon: DrawableResourceAndroidBitmap('icon_large_notification'),
      timeoutAfter: 5000,
      enableLights: true,
    );
    var iosChannel = IOSNotificationDetails();
    var platformChannel =NotificationDetails(android: androidChannel,iOS: iosChannel);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Schedule Test Title',
        'Schedule Test Body',
        scheduleNotificationDateTime,
        platformChannel,
        payload: 'New Payload'
    );
  }
  Future<void> repeatNotification() async{
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL ID 2',
      'CHANNEL NAME 2',
      'CHANNEL DESCRIPTION 2',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
      icon:'icon_notification_replace',
      largeIcon: DrawableResourceAndroidBitmap('icon_large_notification'),
      timeoutAfter: 5000,
      enableLights: true,
    );
    var iosChannel = IOSNotificationDetails();
    var platformChannel =NotificationDetails(android: androidChannel,iOS: iosChannel);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        'Repeat Test Title',
        'Repeat Test Body',
        RepeatInterval.everyMinute,
        platformChannel,
        payload: 'New Payload'
    );
  }
  Future<void> showDailyAtTimeNotification() async{
    var time = Time(11,54,0);
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL ID',
      'CHANNEL NAME',
      'CHANNEL DESCRIPTION',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
      icon:'icon_notification_replace',
      largeIcon: DrawableResourceAndroidBitmap('icon_large_notification'),
      timeoutAfter: 5000,
      enableLights: true,
    );
    var iosChannel = IOSNotificationDetails();
    var platformChannel =NotificationDetails(android: androidChannel,iOS: iosChannel);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Daily Test Title ${time.hour}-${time.minute}-${time.second}',
        'Daily Test Body',
        time,
        platformChannel,
        payload: 'New Payload'
    );
  }
  Future<void> showWeeklyAtDayTimeNotification() async{
    var time = Time(11,58,0);
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL ID',
      'CHANNEL NAME',
      'CHANNEL DESCRIPTION',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
      icon:'icon_notification_replace',
      largeIcon: DrawableResourceAndroidBitmap('icon_large_notification'),
      timeoutAfter: 5000,
      enableLights: true,
    );
    var iosChannel = IOSNotificationDetails();
    var platformChannel =NotificationDetails(android: androidChannel,iOS: iosChannel);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        0,
        'Weekly Test Title ${time.hour}-${time.hour}-${time.second}',
        'Weekly Test Body',
        Day.monday,
        time,
        platformChannel,
        payload: 'New Payload'
    );
  }
  Future<void> cancelNotification(int id)async{
    await flutterLocalNotificationsPlugin.cancel(id);
  }
  Future<void> cancelAllNotification()async{
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
LocalNotifyManager localNotifyManager = LocalNotifyManager.init();
class ReceiveNotification{
  final int id;
  final String title;
  final String body;
  final String payload;
  ReceiveNotification({@required this.id,@required this.title,@required this.body,this.payload});
}