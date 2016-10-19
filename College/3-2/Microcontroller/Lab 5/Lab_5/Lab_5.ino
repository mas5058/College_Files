
// Michael Sarlo Lab 5

#define CLOCK            13    
#define DATA             12  
#define SPKR1_PIN        A5   
#define SPKR2_PIN        9
#define SW1_PIN          5  
#define SW2_PIN          4
#define QTR1_PIN         A3 
#define QTR2_PIN         A4 

boolean isSw1Pressed, prevIsSw1Pressed = false, isSw1Up2Dn, isSw1Dn2Up, isSw1Change;
boolean isSw2Pressed, prevIsSw2Pressed = false, isSw2Up2Dn, isSw2Dn2Up, isSw2Change;
//boolean isSw1Rise, isSw2Rise;
//boolean isSw1Change, isSw1Change;
//boolean isSw1Fall, isSw2Fall;
int beepPin; // a variable since it is not known yet which pin has the speaker attached
int numTimesPressed=0;
long startMicroseconds=0, elapsedMicroseconds=0;

   
//***********************************************************************************
void setup()
{
  Serial.begin(9600);
  Serial.println(F("Lab 5: Configuration Detection"));
  configureBoardPins();
  beepPin = getActiveBeepPin();  // will affect beeper sound when in main loop
  TCCR1A = 0b01000000;
  TCCR1B = 0b00001001;
  OCR1A = 7999;
  DDRB |= 0b00000010;
 
}

//***********************************************************************************
void loop()
{ 
  //added
  //startMicroseconds=micros(); // to measure execution time
  //digitalWrite(QTR2_PIN,HIGH); // connect oscilloscope probe to this pin. 
  //end
  
  updateSwitchStates(); // function call to update state of switches (pressed/not pressed)
  countSwitchPresses(); // increment or decrement counter of switch presses
//  countSwitchPressesUsingStateMachine(); // avoids any risk of switch bounce
  lightUpBarGraph(numTimesPressed); // light all LEDs from bottom up to numTimesPressed level
  
  

  //beepPin = SPKR1_PIN;
  //beepPin = getActiveBeepPin();  // will affect beeper sound when in main loop

  if (isSw1Pressed|| isSw2Pressed) {
//    TCCR1A = 0b01000000;
//    TCCR1B = 0b00001000;
    //tone(beepPin,880+numTimesPressed*20);  //change to counts (ocr1a)
    OCR1A = 9000 -(numTimesPressed*200);
    if (isSw1Up2Dn || isSw2Up2Dn){
      displayBeepPin(beepPin);
    }
  }
  else{
//    noTone(beepPin);
    OCR1A = 0;
  }
  //added code
//  digitalWrite(QTR2_PIN,LOW);  
//  elapsedMicroseconds=micros()-startMicroseconds; // to measure execution time      
//  Serial.print("loop execution time was "); 
//  Serial.print(elapsedMicroseconds); 
//  Serial.println(" microseconds."); 
  //added code ends
  delay(10);   //remove delay to see switch bounce glitch
} // Arduino loop()

//***********************************************************************************
void displayBeepPin(int beepPin)
{ // for spam reduction use static variable

  // declare variable here
  static int lastbeep = 0;
  
  // add anti-spam code here
  
  // Report speaker drive configuration (SPKR1, SPKR2, DISABLED) to console.
 if(lastbeep != beepPin){ 
  switch (beepPin) {
    case (SPKR1_PIN): Serial.println(F("Speaker drive from SPKR1 pin.")); break;
    // add case for SPKR2_PIN
    case (SPKR2_PIN): Serial.println(F("Speaker drive from SPKR2 pin.")); break;
    default:     Serial.println(F("Speaker drive DISABLED at jumper block."));
    
  }
  lastbeep = beepPin;
  } 
}

//***********************************************************************************
int getActiveBeepPin(void)
{
  // Determine switchblock signal routing. Speaker/resistor will pull down
  // soft pullup of digital I/O.
  //
  // add:
  //    Configure SPKR1 and SPKR2 drive pins as pulled up inputs.
  //    Read pin levels.
  //    If a pin is high, it is not connected: leave as input.
  //    If a pin is low it is connected. tone() will automatically configure it for output.
  //    Return value of beepPin as SPKR1, SPKR2 or -1, depending on discovery
   //Serial.println("in beep");
  static int tempbeepPin;
  //int beepPin = SPKR1_PIN;\
  //beepPin = 0;
  //pinMode(SPKR1_PIN,INPUT_PULLUP);
  //pinMode(SPKR2_PIN,INPUT_PULLUP);
   DDRC &= 0b11011111;
  PORTC |= 0b00100000;
  //pinMode(SPKR2_PIN, INPUT_PULLUP);
  DDRB &= 0b11111101;
  PORTB |= 0b00000010;
  //if (SPKR1_PIN == LOW){
  if ((PINC & 0b00100000) == 0b00000000){
//    pinMode(SPKR1_PIN,OUTPUT);
    //DDRC |= 0b00100000;
    //Serial.println("SPKR 1 IS OUTPUT");
//    pinMode(SPKR2_PIN,INPUT_PULLUP);
    tempbeepPin = SPKR1_PIN;
  }
  //else if (digitalRead(SPKR2_PIN) == LOW){
    else if ((PINB & 0b00000010) == 0b00000000){
    //    pinMode(SPKR1_PIN,INPUT_PULLUP);
//    pinMode(SPKR2_PIN,OUTPUT);
    //Serial.println("SPKR 2 IS OUTPUT");
    DDRB |= 0b00000010;
    tempbeepPin = SPKR2_PIN;
  }
  else{
    tempbeepPin = -1;
    Serial.println("no spkr is out");
//    pinMode(SPKR1_PIN,INPUT_PULLUP);
//    pinMode(SPKR2_PIN,INPUT_PULLUP);
  }
  return tempbeepPin;
}

//*******************************************************************************************
void configureBoardPins(void)
{   
  // Use pin names per schematic.
  // Schematic inputs are uC outputs.
  // Initialize outputs to benign levels (usually LOW)
  // Schematic outputs are uC inputs.
  // Assign pullups (INPUT_PULLUP) to indeterminate or unattached inputs.
  
  //pinMode(SW1_PIN, INPUT_PULLUP);  // SPST active low pushbutton
  DDRD &= 0b11011111;
  PORTD |= 0b00100000;
//  pinMode(SW2_PIN, INPUT_PULLUP);
//add pinmode for pin 2
  DDRD &= 0b11101111;
  PORTD |= 0b00010000;
  //pinMode(SPKR1_PIN, INPUT_PULLUP); // I/O pin speaker drive connection sense
  DDRC &= 0b11011111;
  PORTC |= 0b00100000;
  //pinMode(SPKR2_PIN, INPUT_PULLUP);
  DDRB &= 0b11111101;
  PORTB |= 0b00000010;
//add pinmode for SPKR2
  //pinMode(CLOCK, OUTPUT);
  DDRB |= 0b00100000;
  //pinMode(DATA, OUTPUT);
  DDRB |= 0b00010000;
  //pinMode(QTR2_PIN, OUTPUT);  // add for timing measurement using oscilloscope
  //PIN 4
  //DDRC |= 0b11101111;
 
}

//*******************************************************************************************
void updateSwitchStates (void) 
{ // Signal conditioning: Log switch states and transitions
  //switch 1
  prevIsSw1Pressed = isSw1Pressed;
  //isSw1Pressed = !digitalRead(SW1_PIN); // convert switch active low to active high
  isSw1Pressed = ((PIND & 0b00100000) == 0b00000000);
  isSw1Up2Dn = (isSw1Pressed && !prevIsSw1Pressed); // switch just pressed
  isSw1Dn2Up = (!isSw1Pressed && prevIsSw1Pressed);   // switch just released
  isSw1Change = (isSw1Up2Dn || isSw1Dn2Up);             // switch just changed state
  
  //switch 2
  prevIsSw2Pressed = isSw2Pressed;
  //isSw2Pressed = !digitalRead(SW2_PIN); // convert switch active low to active high
  isSw2Pressed = ((PIND & 0b00010000) == 0b00000000);
  isSw2Up2Dn = (isSw2Pressed && !prevIsSw2Pressed); // switch just pressed
  isSw1Dn2Up = (!isSw2Pressed && prevIsSw2Pressed);   // switch just released
  isSw2Change = (isSw2Up2Dn || isSw2Dn2Up);             // switch just changed state
  //Serial.println(isSw1Pressed);
}

//*******************************************************************************************
void countSwitchPresses(void)
{ // if SW1 just pressed down, count up by one,     
  // if SW2 just pressed down, count down by one
  // if  numTimesPressed<0, force numTimesPressed to be zero
  // if  numTimesPressed>10, force numTimesPressed to be 10.
  // only if the value of numTimesPressed has changed, print the new value of numTimesPressed
  
  if (isSw1Up2Dn){
    numTimesPressed ++;
  }
  else if (isSw2Up2Dn){
    //Serial.println("Switch 2 has been pressed;");
    numTimesPressed --;
  }
  else{
    numTimesPressed += 0;
  }
  if (numTimesPressed < 0){
    numTimesPressed = 0;
  }
  else if (numTimesPressed > 10){
    numTimesPressed = 10;
  }
  if(isSw1Up2Dn || isSw2Up2Dn){
  Serial.print(" Switch 1 has been pressed ");
  Serial.print(numTimesPressed);
  Serial.println(" times.");
  }
  
};

//***********************************************************************************
void pulseClk(void)
//to digital write just and it with a 1 in the spot you want to be high
{
  // Pulse clock line: LOW, HIGH to get guaranteed rising edge
  // and leave function with LED on i.e. clock high.
  //digitalWrite(CLOCK, LOW);
  PORTB &= 0b11011111;
  //digitalWrite(CLOCK, HIGH);
  PORTB |= 0b00100000;
}

//***********************************************************************************
void lightUpBarGraph(int barNum)
{ // start by calling clearShiftRegisterToZero()
  // then clock out a 1 (HIGH) then follow it by a for loop that clocks
  // out a HIGH value barNum of times
  // use the pulseClk() function to perform clocking
  // if the barNum>=9 turn on the CLK_FF_PIN LED or if not, turn off the LED
  // if the barNum>=10 turn on the D_FF_PIN LED or if not, turn off the LED
  
  clearShiftRegisterToZero();
  int counter = barNum;
  //digitalWrite(CLOCK, HIGH);
  while (counter > 0){
    lightLED();
    counter --;
  }
  if (barNum >= 9){
    //digitalWrite(DATA, HIGH);
    PORTB |= 0b00010000;
  }
  else{
//    digitalWrite(DATA, LOW);
    PORTB &= 0b11101111;
  }
  if (barNum == 10){
    //lightLED();
    //digitalWrite(CLOCK, HIGH);
    PORTB |= 0b00100000;
  }
  else{
    //digitalWrite(CLOCK, LOW);
    PORTB &= 0b11011111;
  }
  
  
}

//***********************************************************************************
void clearShiftRegisterToZero(void)
{ // clear out the shift register by clocking out 8 zeroes.
  // leave the D_FF and CLK_FF pins LOW when done.
  // call the pulseClk() function to perform clocking.
  int counter = 8;
  while (counter > 0){
    darkLED();
    counter --;
  }
}

//***********************************************************************************
void countSwitchPressesUsingStateMachine (void) 
{
  // Interpret changes in SW1 and SW2 presses
  // This function is complete as is. No modifications required.
  
  if ((isSw1Pressed && !prevIsSw1Pressed) &&  prevIsSw2Pressed ) numTimesPressed--; // falling SW1,  hi SW2 -> CW
  if ((!isSw1Pressed && prevIsSw1Pressed) && !isSw2Pressed ) numTimesPressed--; // rising SW1, low SW2 -> CW
  if ((isSw2Pressed && !prevIsSw2Pressed) && !isSw1Pressed ) numTimesPressed--; // falling SW2, low SW1 -> CW
  if ((!isSw2Pressed && prevIsSw2Pressed) &&  isSw1Pressed ) numTimesPressed--; // rising SW2,  hi SW1 -> CW
  
  if ((isSw1Pressed && !prevIsSw1Pressed) && !isSw2Pressed ) numTimesPressed++; // falling SW1, low SW2 -> CCW
  if ((!isSw1Pressed && prevIsSw1Pressed) &&  isSw2Pressed ) numTimesPressed++; // rising SW1,  hi SW2 -> CCW
  if ((isSw2Pressed && !prevIsSw2Pressed) &&  isSw1Pressed ) numTimesPressed++; // falling SW2,  hi SW1 -> CCW
  if ((!isSw2Pressed && prevIsSw2Pressed) && !isSw1Pressed ) numTimesPressed++; // rising SW2, low SW1 -> CCW}
 
  // check bounds on number, limit to 0 to 10 
  if (numTimesPressed<0) numTimesPressed=0;
  if (numTimesPressed>10) numTimesPressed=10;
 }
//*********************************************************************************** 
void darkLED(){
  //digitalWrite (DATA,LOW);
  PORTB &= 0b11101111;
  pulseClk();
  //digitalWrite(CLOCK, LOW);
  PORTB &= 0b11011111;
  //delay(delaysample);
}
//*********************************************************************************** 
void lightLED(){
  //digitalWrite (DATA,HIGH);
  PORTB |= 0b00010000;
  pulseClk();
  //digitalWrite (DATA,LOW);
  PORTB &= 0b11101111;
  //digitalWrite(CLOCK, LOW);
  PORTB &= 0b11011111;
}
