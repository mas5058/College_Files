// CPET-202 RIT Lab 4 starting code

#define CLK_FF_PIN       13    
#define D_FF_PIN         12  
#define SPKR1_PIN        A5
#define SPKR2_PIN        9
#define SW1_PIN          5   
#define SW2_PIN          6  

#define QTR1_PIN         A3 
#define QTR2_PIN         A4 

boolean isSw1Pressed, prevIsSw1Pressed = false, isSw1Up2Dn, isSw1Dn2Up, isSw1Change;
boolean isSw2Pressed, prevIsSw2Pressed = false, isSw2Up2Dn, isSw2Dn2Up, isSw2Change;
int beepPin; // a variable since it is not known yet which pin has the speaker attached
int numTimesPressed=0;
long startMicroseconds=0, elapsedMicroseconds=0;

   
//***********************************************************************************
void setup()
{
  configureBoardPins();
 
  Serial.begin(9600);
  Serial.println(F("Lab 4: Configuration Detection"));
}

//***********************************************************************************
void loop()
{ 
  updateSwitchStates(); // function call to update state of switches (pressed/not pressed)
  countSwitchPresses(); // increment or decrement counter of switch presses
//  countSwitchPressesUsingStateMachine(); // avoids any risk of switch bounce
  lightUpBarGraph(numTimesPressed); // light all LEDs from bottom up to numTimesPressed level
  

  //beepPin = SPKR1_PIN;
  beepPin = getActiveBeepPin();  // will affect beeper sound when in main loop

  if (isSw1Pressed || isSw2Pressed) {
    tone(beepPin,880+numTimesPressed*20);  //change tone
    displayBeepPin(beepPin);
  }
  else{
    noTone(beepPin);
  }

  // to stop the speaker tone, call the function noTone e.g. ---> noTone(beepPin);
 
  delay(10);   //remove delay to see switch bounce glitch
    
} // Arduino loop()

//***********************************************************************************
void displayBeepPin(int beepPin)
{ // for spam reduction use static variable

  // declare variable here
  static int lastbeep;
  lastbeep = beepPin;
  // add anti-spam code here

  // Report speaker drive configuration (SPKR1, SPKR2, DISABLED) to console. 
  switch (beepPin) {
    case (SPKR1_PIN): Serial.println(F("Speaker drive from SPKR1 pin.")); break;
    // add case for SPKR2_PIN
    default:     Serial.println(F("Speaker drive DISABLED at jumper block."));
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
  
  int beepPin = SPKR1_PIN;
  
  return beepPin;
}

//*******************************************************************************************
void configureBoardPins(void)
{   
  // Use pin names per schematic.
  // Schematic inputs are uC outputs.
  // Initialize outputs to benign levels (usually LOW)
  // Schematic outputs are uC inputs.
  // Assign pullups (INPUT_PULLUP) to indeterminate or unattached inputs.
  
  pinMode(SW1_PIN, INPUT_PULLUP);  // SPST active low pushbutton

  pinMode(SW2_PIN, INPUT_PULLUP);

  pinMode(SPKR1_PIN, INPUT_PULLUP); // I/O pin speaker drive connection sense


  pinMode(SPKR2_PIN, INPUT_PULLUP);
  
  pinMode(QTR2_PIN, OUTPUT);  // add for timing measurement using oscilloscope
}

//*******************************************************************************************
void updateSwitchStates (void) 
{ // Signal conditioning: Log switch states and transitions
  prevIsSw1Pressed = isSw1Pressed;
  isSw1Pressed = !digitalRead(SW1_PIN); // convert switch active low to active high
  isSw1Up2Dn = (isSw1Pressed && !prevIsSw1Pressed); // switch just pressed
  isSw1Dn2Up = (!isSw1Pressed && prevIsSw1Pressed);   // switch just released
  isSw1Change = (isSw1Up2Dn || isSw1Dn2Up);             // switch just changed state
  
  // add code here to read switch 2

}

//*******************************************************************************************
void countSwitchPresses(void) 
{ // if SW1 just pressed down, count up by one,     
  // if SW2 just pressed down, count down by one
  // if  numTimesPressed<0, force numTimesPressed to be zero
  // if  numTimesPressed>10, force numTimesPressed to be 10.
  // only if the value of numTimesPressed has changed, print the new value of numTimesPressed
  
//    Serial.print("Switch 1 has been pressed ");
//    Serial.print(numTimesPressed);
//    Serial.println(" times.");
  
};

//***********************************************************************************
void pulseClk(void)
{
  // Pulse clock line: LOW, HIGH to get guaranteed rising edge
  // and leave function with LED on i.e. clock high.

}

//***********************************************************************************
void lightUpBarGraph(int barNum)
{ // start by calling clearShiftRegisterToZero()
  // then clock out a 1 (HIGH) then follow it by a for loop that clocks
  // out a HIGH value barNum of times
  // use the pulseClk() function to perform clocking
  // if the barNum>=9 turn on the CLK_FF_PIN LED or if not, turn off the LED
  // if the barNum>=10 turn on the D_FF_PIN LED or if not, turn off the LED
  
  //clearShiftRegisterToZero();


}

//***********************************************************************************
void clearShiftRegisterToZero(void)
{ // clear out the shift register by clocking out 8 zeroes.
  // leave the D_FF and CLK_FF pins LOW when done.
  // call the pulseClk() function to perform clocking.
  
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
