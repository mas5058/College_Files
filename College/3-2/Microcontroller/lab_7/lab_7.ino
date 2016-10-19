// Lab 7 DEMO  Atmel C
// Written by: JTSchueckler
// Date: 1Nov14
// Desc: ++ PLEASE READ ALL COMMENTS ++
//       This program demonstrates a simple use of the INTO functionality.     
//       Review the initialization of the interrupt system.
//       Review the setup of the ISR.
    
// Define volatile global variables for ISR system interface.
volatile int pulseCount = 0, prevpulseCount = -1;

//***********************************************************************************
void setup()
{    
  Serial.begin(9600);
  Serial.println("Lab 7 ISR INT0 counter");
  delay(100);
  configurePins();

  delay(500); // during this delay, press the switch a few times.
  Serial.println(" ");   
  Serial.println(" ");
  Serial.println("REMINDER +++++++++++++++++++++++++++++++++++++++++++++ ");
  Serial.print("Leading zeros (0) are blanked out by the Arduino IDE.");
  Serial.println(" ");   
  Serial.println(" ");  
  
  // REMIND users how to interpret the read back of the control registers
  
  // Display the bootup values of EICRA, EIFR and EIMSK
  Serial.print("EIFR before clearing any pending flags ");
  Serial.println(EIFR,BIN);
  Serial.print("EICRA before clearing any pending flags ");
  Serial.println(EICRA,BIN);
  Serial.print("EIMSK before clearing any pending flags ");
  Serial.println(EIMSK,BIN);
  Serial.println();
  delay(500);
  initInterrupts();
  
// Display the programmed values of EICRA, EIFR and EIMSK
  Serial.print("EIFR after clearing any pending flags ");
  Serial.println(EIFR,BIN);
  Serial.print("EICRA after clearing any pending flags ");
  Serial.println(EICRA,BIN);
  Serial.print("EIMSK after clearing any pending flags ");
  Serial.println(EIMSK,BIN);
  Serial.println();
  
}

//***********************************************************************************
void loop()
{ 
  // only print the pulse count if it has changed
  if (pulseCount != prevpulseCount)  {
    prevpulseCount = pulseCount;
    Serial.print("SW2 was pressed ");
    Serial.print(pulseCount);
    Serial.println(" times.");
  }
  
} // Arduino loop()

//***********************************************************************************
void configurePins(void) 
{
  DDRD |= 0x00;
  PORTD |= 0x04;
           //Set up PD2 (INT0) as an INPUT w/Pullup;
  DDRD |= 0x01;
  //set PD0 as an output to measure time
}

//***********************************************************************************
void initInterrupts(void)  
{
/* Since we are forced into the Arduino IDE. We cannot disable interrupts the
   same way programmers would in a real microcontroller application. In this course
   we will use the Arduino function pair of cli(); and sei();. 
   
   Typical Atmel C code would use:
                        __disable_interrupt(); 
   to clear the global interrupt bit in the SREG. 
   
   And:
                        __enable_interrupt();
   to set the global interrupt enable in the SREG.
   OR by direct manipulation of the "I" bit in the SREG.
   
   NOTE: The Serial Monitor and other Arduino functions will be directly affected
   if you try to manipulate the SREG in the Arduino operation.
         
*/
         
  cli();      
         // Clear the Global INT bit to disable ALL interrrupts
           
  EICRA &= 0xFE;
   // Configure EICRA to detect falling edge for INT0
         // ISC0 = 0b10 refers to Interrupt Sense Control for INT0
         // the two bits {1 and 0} program the hardware to repond to a falling edge
         // at the input pin INT0 (PD2)
        
  EIMSK |= 0x01; 
         // Unmask INT0 in EIMSK so that it is enabled
       
  EIFR  |= 0x01; 
         // Clear any pending interrupt flags for INTO
         // Writing a 1 to b0 will clear any pending INTO request

  sei();
         // Sets the Global INT bit to enable ALL interrrupts
}

//*********************************************************************************** 
ISR(INT0_vect) // the ISR name must match the interrupt (e.g. INT0_vect)
{
  pulseCount++;
  
  
  // NOTE: NO Extraneous instructions in the ISR
}
ISR(INT1_vect) // the ISR name must match the interrupt (e.g. INT0_vect)
{
  pulseCount--;
  
  
  // NOTE: NO Extraneous instructions in the ISR
}
