#define CLOCK 13
#define DATA 12
#define smalldelay 0
#define longdelay 1000
int barNum = 9;
int increment;
int obarNum = barNum;

void setup() {
pinMode (CLOCK, OUTPUT);
pinMode (DATA, OUTPUT);
Serial.begin(9600);
Serial.println(F("Lab 3: single LED in motion"));
turnOffAllLEDs();
delay(longdelay);
 
} 
// setup()

void lightLED(){
  digitalWrite (DATA,HIGH);
  digitalWrite (CLOCK,LOW);
  digitalWrite(CLOCK,HIGH);
  digitalWrite (DATA,LOW);
  digitalWrite(CLOCK, LOW);
}

void darkLED(){
  digitalWrite (DATA,LOW);
  digitalWrite (CLOCK,LOW);
  //delay(1000);
  digitalWrite(CLOCK,HIGH);
  digitalWrite(CLOCK, LOW);
  //delay(delaysample);
}
void turnOffAllLEDs(){
  int counter = 8;
  while (counter > 0){
    darkLED();
    counter --;
  }
}
void loop() {
  int counter = barNum;
  //Serial.println(barNum);
  //LONGDELAY();
  if (barNum == 9){
    increment = -1;
  }
  if (barNum == 0){
//    Serial.println("success!");
    increment = 1;
//    Serial.println(increment);
  }
  int diff = obarNum - barNum;
  while (diff > 0){
    darkLED();
    diff --;
  }
  if (barNum == 8){
     digitalWrite (CLOCK,LOW);
     digitalWrite(DATA,HIGH);
     //barNum -= 1;
     delay(smalldelay);
  }
  else{
    //increment = -1;
    lightLED();
    if (barNum == 9){
    while (counter > 2){
      darkLED();
      counter --;
      //Serial.println("counter");
      //Serial.println(counter);
     // delay(smalldelay);
    }
    if (counter == 2){
      digitalWrite (DATA,HIGH);
      //delay(smalldelay);
      digitalWrite (DATA,LOW);
      //Serial.println("clock on");
      digitalWrite(CLOCK,HIGH);
      //barNum = barNum - 1;   
      //delay(smalldelay);
    }
    }
    else{
      while (counter > 0){
      darkLED();
      counter --;
//      Serial.println("counter");
//      Serial.println(counter);
      //delay(smalldelay);
    }
    }
  }  
//  if (increment == 1){
//    Serial.println("increment is 1! HUZZAH!");
//  }
  barNum = barNum + increment;
  Serial.println(barNum);
  delay(smalldelay);
}


  
  
    
 // loop()

//****************************************************************************


