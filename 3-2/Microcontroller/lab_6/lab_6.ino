  // Lab6_Timer_p1
// Written By: C. Hochgraf
// Date: OCT2013


// declare variables
  enum {TC1_PCFC_DC90_D10};
  int state;
//***********************************************************************************
void setup()
{  
  Serial.begin(9600);
  Serial.println(F("Lab 6: Hardware Timer Blink and Dim"));
}
//***********************************************************************************
void loop()
{
  // loop() is only executed once because each state contains an infinite loop.
  state = TC1_PCFC_DC90_D10;
 
  switch(state)
  {
    //-------------------------------------------------------------------------------
    case TC1_PCFC_DC90_D10:
      // Create 90% duty cycle square wave using Timer 1.
      
      Serial.println(F("Print out all the default Timer1 settings"));
      delay(1000);
      Serial.println(F("The settings are all stored in registers"));
      delay(1000);
      Serial.println(F("Later, you will change the values in the registers"));
      delay(1000);
      Serial.println();
      Serial.println(F("First, what is in the Timer 1 Control Registers?"));
      delay(1000);
      
      printTimer1Registers();
      //delay(10000);
     
      // you can comment out the printWGM function below when you are ready
      Serial.println(F("you can comment out the printing of WGM values to save time"));
      //printWGMCOMCS1Values();
     
      Serial.println();
      delay(1000);
      Serial.println(F("Initializing Timer1 in PCFC mode, toggling OC1B on d10"));
      TCCR1A = 0; // set to defaults as good practice
      TCCR1B = 0; // set to defaults as good practice
      TCCR1A  = (1 << WGM11)|(0 << WGM10);    // first part of setup for FPFC PWM (mode 8)
      TCCR1B  = (1 << WGM13)|(0 << WGM12);    // second part of setup for FPFC PWM (mode 8)
      TCCR1A |= (1 << COM1B1)|(1 << COM1B0);  // non-inverting PWM on channel B: PORTB2, UNOd10 
      TCCR1A |= (1 << COM1A1)|(1 << COM1A0);  // non-inverting PWM on channel A: PORTB1, UNOd9 
    
      //This setup COM1A (10) COM1B (11), gives d9 to be inverted from d10 if OCR1A=OCR1B. 
      // WGM mode 8 (1000) has ICR1 as top.
   
      //TCCR1B |= (1 << CS12)|(0 << CS11)|(1 << CS10); // clock prescale = 1024 -> 15.625 kHz
      //TCCR1B |= (1 << CS12)|(0 << CS11)|(0 << CS10); // clock prescale = 256 -> 62.5 kHz
      //TCCR1B |= (0 << CS12)|(1 << CS11)|(1 << CS10); // clock prescale = 64 -> 250 kHz
      TCCR1B |= (0 << CS12)|(0 << CS11)|(1 << CS10); 
      ICR1 = 399;  // period   ICR1=10000 gives visible blips at 100000 12.5 hz
      OCR1A = 199;  //  =10000/16 = 625
      OCR1B = 199;  //  =10000/16 = 625 
      
      //did it work right? check by printing registers
      printTimer1Registers();
      //delay(10000);
      //this timer is set to go to OC2B which is digital pin 3
      pinMode(9,OUTPUT);  
      pinMode(10,OUTPUT); 
      pinMode(13,INPUT); 
      Serial.println();
      Serial.println("I'm ready to blink now");
      while(true) {; // dwell forever 
         }
      break;     
  } // switch(state)
} // Arduino loop()

//*********************************************************************
void printWGMCOMCS1Values(void) {
    Serial.println();
    Serial.println(F("Second, what are these WGM values? Try printing as decimals"));
    Serial.println();
 
    Serial.print(F("WGM10    DECIMAL: "));
    Serial.println(WGM10, DEC);
 
    Serial.print(F("WGM11    DECIMAL: "));
    Serial.println(WGM11, DEC);
    
    Serial.print(F("WGM12    DECIMAL: "));
    Serial.println(WGM12, DEC);
    Serial.print(F("WGM13    DECIMAL: "));
    Serial.println(WGM13, DEC);
 
    delay(10000);
    Serial.println();
    Serial.println(F("The WGM values are #defines that tell you how far"));
    delay(1000);
    Serial.println(F("to shift a bit value to have it land at the right place "));
    delay(1000);
    Serial.println(F("in the register. "));
    Serial.println();
   
    delay(2000);
    Serial.println(F("Now print the COM1B values."));
    Serial.println();
    Serial.print(F("COM1B0    DECIMAL: "));
    Serial.println(COM1B0, DEC);
 
    Serial.print(F("COM1B1    DECIMAL: "));
    Serial.println(COM1B1, DEC);
    Serial.println();
    delay(10000);
    Serial.println(F("Now print the CS values that help with setting the "));
    Serial.println(F("clock prescaler value (clock divider). "));
    Serial.println();
    delay(2000);
    
    Serial.print(F("CS10    DECIMAL: "));
    Serial.println(CS10, DEC);
 
    Serial.print(F("CS11    DECIMAL: "));
    Serial.println(CS11, DEC);
    
    Serial.print(F("CS12    DECIMAL: "));
    Serial.println(CS12, DEC);
    Serial.println();
    delay(10000);
  };
//*************************************************************************
void printTimer1Registers(void) {
    Serial.println();
    Serial.print(F("TCCR1A   BINARY: "));
    Serial.print(TCCR1A, BIN);
    Serial.print("\t");
    Serial.print(F("  HEX:  "));
    Serial.println(TCCR1A, HEX);
    Serial.print(F("TCCR1B   BINARY: "));
    Serial.print(TCCR1B, BIN);
    Serial.print("\t");
    Serial.print(F("  HEX:  ")); 
    Serial.println(TCCR1B, HEX);
 
    Serial.print(F("OCR1A    BINARY: "));
    Serial.print(OCR1A, BIN);
    Serial.print("\t");
    Serial.print(F("  HEX:  "));
    Serial.print(OCR1A, HEX);
    Serial.print("\t");
    Serial.print(F("  DEC:  "));
    Serial.print(OCR1A, DEC);
    Serial.println();
    Serial.print(F("OCR1B    BINARY: "));
    Serial.print(OCR1B, BIN);
    Serial.print("\t");
    Serial.print(F("  HEX:  "));
    Serial.print(OCR1B, HEX);
    Serial.print("\t");
    Serial.print(F("  DEC:  "));
    Serial.print(OCR1B, DEC);
    Serial.println();
};
