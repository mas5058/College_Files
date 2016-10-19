//Michael Sarlo
//10/7/15
//Competency Exam 1

int isSwPressed; //The first state
int prevIsSwPressed; //Has the switch been pressed?
int isSwChange; //Has the switch state changed?
int isSwRise; //Has the switch state just been pressed?
int isSwFall; //Has the switch state just been released
#define gLed 7
#define rLed 12
  
void setup() {
  // initialize digital pin 13 as an output.
  Serial.begin(9600);
  Serial.println("Competency Exam");
  #define SW_PIN 5
  pinMode(gLed, OUTPUT);
  pinMode(rLed, OUTPUT);
  pinMode (SW_PIN, INPUT_PULLUP);
  digitalWrite(gLed, LOW);
  digitalWrite(rLed, HIGH);
  Serial.println("grLED_OFF");
   
}

// the loop function runs over and over again forever
void loop() {
   prevIsSwPressed = isSwPressed;  
  isSwPressed = !digitalRead(SW_PIN);   // When the switch is pressed, the SW_PIN is low, so !low is high or true 
  isSwRise = (isSwPressed && !prevIsSwPressed);  // switch edge detection
  isSwFall = (!isSwPressed && prevIsSwPressed);    
  isSwChange = (isSwRise || isSwFall);
  
  if (isSwPressed == HIGH){
    if (isSwRise == HIGH){
    digitalWrite(gLed, HIGH);
    digitalWrite(rLed,LOW);
    Serial.println("grLED_ON"); 
    }
  }
  if (isSwPressed == LOW){
    if (isSwFall == HIGH){
    digitalWrite(gLed, LOW); 
    Serial.println("grLED_OFF");
    }
  }
}
  
