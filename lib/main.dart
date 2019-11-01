import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
var Datap;
final databaseReference = FirebaseDatabase.instance.reference();
var Lpglevel;
 const oneSecond = const Duration(seconds:5);
void main(){
  
   
  runApp(new MyApp());

}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String textValue = 'Hello World !';
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    //dataFetch();
    super.initState();
    
            void fetchdata(){
                 databaseReference.once().then((DataSnapshot snapshot) {
          //print('Data : ${snapshot.value['Variable']['Value']}');
       Lpglevel= snapshot.value['Variable']['Value']; 

                  print(Lpglevel); 
                  setState(() {
                    
                  });              
          
        });
            }
         
        
           new Timer.periodic(oneSecond, (Timer t) => fetchdata()); 
            print('hello');
            var android = new AndroidInitializationSettings('mipmap/ic_launcher');
            var ios = new IOSInitializationSettings();
            var platform = new InitializationSettings(android, ios);
            flutterLocalNotificationsPlugin.initialize(platform);
        
            firebaseMessaging.configure(
              onLaunch: (Map<String, dynamic> msg) {
                print(" onLaunch called ${(msg)}");
              },
              onResume: (Map<String, dynamic> msg) {
                print(" onResume called ${(msg)}");
              },
              onMessage: (Map<String, dynamic> msg) {
                showNotification(msg);
                print(" onMessage called ${(msg)}");
              },
            );
            firebaseMessaging.requestNotificationPermissions(
                const IosNotificationSettings(sound: true, alert: true, badge: true));
            firebaseMessaging.onIosSettingsRegistered
                .listen((IosNotificationSettings setting) {
              print('IOS Setting Registed');
            });
            firebaseMessaging.getToken().then((token) {
              update(token);
            });  /////In app Data
          }
        
          showNotification(Map<String, dynamic> msg) async {
            var android = new AndroidNotificationDetails(
              'sdffds dsffds',
              "CHANNLE NAME",
              "channelDescription",
            );
            var iOS = new IOSNotificationDetails();
            var platform = new NotificationDetails(android, iOS);
            await flutterLocalNotificationsPlugin.show(
                0, "This is title", "this is demo", platform);
          }
        
          update(String token) {
            print(token);
            DatabaseReference databaseReference = new FirebaseDatabase().reference();
            databaseReference.child('fcm-token/${token}').set({"token": token});
            textValue = token;
            setState(() {
             
            });
          }
        
          @override
          Widget build(BuildContext context) {
           
 
                        return new MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: new Scaffold(
                            appBar: new AppBar(
                              title: new Text('LPG Detector'),
                            ),
                            body: new Center(
                              child: Container(
                                
                                padding: EdgeInsets.all(25.0),
                                child: new Column(
                                  children: <Widget>[
                                   
                                     new Text(
                                    'Level of LPG',
                                      
                                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25.0),
                                      
                    
                                    ),
                                    new Text(
                                    
                                    'Level of LPG: $Lpglevel',
              
                               
                                   
                            
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25.0),
                          
        
                        ),
                          
                       
                      ],
                    ),
              
                  ),
                ),
              ),
            );
           
          
          }
       


}
