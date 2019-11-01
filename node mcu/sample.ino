//#include <ArduinoJson.h>

#include <ESP8266WiFi.h>
#include <SoftwareSerial.h>
#include <FirebaseArduino.h>

 #include <ESP8266HTTPClient.h>
 
// Set these to run example.
#define FIREBASE_HOST "lpgsensor-a128a.firebaseio.com"
#define FIREBASE_AUTH "NbkW2tasOJlnTYrazMuCZhLuBvo1GEpXhwwHFHG1"
#define WIFI_SSID "zap"
#define WIFI_PASSWORD "9638527410"
 
String myString;
int mq6 = A0;
int buzzer=D1;// variable resistor connected 
int sdata = 0; // The variable resistor value will be stored in sdata.
 
void setup()
{
  // Debug console
  Serial.begin(9600);
  pinMode(mq6 ,INPUT);
  // connect to wifi.
 // pinMode(D0,OUTPUT);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED)
      {
    Serial.print(".");
    delay(500);
      }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());
  
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
 
   
}
 
void loop()
{
 
sdata = analogRead(mq6);
myString = String(sdata); 
Serial.println(myString); 
if(sdata>190){
  tone(buzzer,1000);
    delay(100);
    noTone(buzzer);
    delay(100);
Firebase.setString("Variable/Value",myString);
if(Firebase.failed()){
  Serial.println("eror");
}
}
delay(1000);            
}
