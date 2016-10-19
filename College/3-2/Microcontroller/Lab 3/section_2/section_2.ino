//#define SW1_PIN 5
//#define SW2_PIN 4
#define CLOCK 13
#define DATA 12
#define TOP_LED 3
boolean isSw1Pressed;
boolean isSw2Pressed;
#define delaysample 20000

void setup() {
pinMode (CLOCK, OUTPUT);
pinMode (DATA, OUTPUT);
Serial.println(F("Lab 3: single LED in motion"));

} // setup()

void loop() {
 digitalWrite (DATA,HIGH);
  digitalWrite (CLOCK,LOW);
  delay(1000);
  digitalWrite(CLOCK,HIGH);
  delay(delaysample);

  
  }
    
 // loop()

//****************************************************************************


