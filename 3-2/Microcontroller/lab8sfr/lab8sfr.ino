//Michael Sarlo
//Lab 8-Motor

// Motor A
#define ADIR 8     // PORTB0  // DRV8355 phase set with GPIO
#define APWM 9     // PORTB1  // DRV8355 PWM set by Timer 2 direct pin drive

// Motor B
#define BDIR 11    // PORTB3
#define BPWM 10    // PORTB2

// reference Pot and Motor encoder connections
#define PCHA A1    // PORTC1
#define PCHB A0    // PORTC0
#define MCHA 3     // PORTD3
#define MCHB 2     // PORTD2

// Sensors and switches
#define SW1_PIN 5    // PORTD5
#define SW2_PIN 4     // PORTD4
#define KNOB_SW A2 // PORTC2
#define QTR2_PIN A4   // PORTC4
#define QTR1_PIN A3   // PORTC5

// Test points, indicators
#define LED1 12      // PORTB4
#define LED2 13      // PORTB5
#define TP_PIN 13   // PORTB5

const boolean isClockWise = true;
boolean motorDir;
boolean isDiskWhite, prevIsDiskWhite, isDiskB2W, isDiskW2B;
boolean isDownSw1 = false, prevIsDownSw1 = false, isUp2DnSw1;
boolean isDownSw2 = false, prevIsDownSw2 = false, isUp2DnSw2;

//*******************************************************************************************
void setup()
{
  Serial.begin(9600);
  Serial.println(F("Motor A Pong"));

  configurePins();   // define pin modes and initial states
  configureTimer1(); // setup timer 1  *** MODIIFY THIS FUNCTION 
 
  //isDiskWhite = !digitalRead(QTR2_PIN);
  isDiskWhite = ((PINC & 0b00010000) == 0b00000000);
  motorDir = isClockWise;
  digitalWrite(ADIR, motorDir); //needs to be clocked in
  OCR1A = 150;  // init PWM to 25%
} // setup()

//*******************************************************************************************
void loop()
{ 
  readandconditioninputs();
//  isDownSw1 = !digitalRead(SW1_PIN); 
//  isDownSw2 = !digitalRead(SW2_PIN);
  isDownSw1 = ((PIND & 0b00100000) == 0b00000000);
  isDownSw2 = ((PIND & 0b00010000) == 0b00000000);
//  digitalWrite(LED1, !digitalRead(QTR2_PIN)); // mirror QTR2 sensor to LED1
//  digitalWrite(LED2, isDownSw2);
  PORTD |= 0x30;
  PORTC |= 0x10;
  //OCR1A = 150;  
  Serial.println(isDiskW2B);
  if (isDiskW2B || isDiskB2W){
    motorDir != motorDir;
    digitalWrite(ADIR, motorDir);
    //delay(200);
  }
//  else{
//    OCR1A = 0;
//  }

  
  //if (isDownSw2) OCR1A = 0;     //stops motor, comment out for ping-pong motion
  
  // Pong in white or black based on SW2 state

// ADD YOUR CODE HERE FOR PING-PONG MOTION OF MOTOR
// Partial (incomplete) pseudo code that may help you with ping-pong motion 
//    motorDir = !motorDir;
//    digitalWrite(ADIR, motorDir);
//    delay(200);
//    isDiskWhite = !digitalRead(QTR2_PIN);
//
  
} // loop()

//*******************************************************************************************
void configurePins(void)
{
  // H-bridge Phase-Enable
//  pinMode(ADIR, OUTPUT);  digitalWrite(ADIR, LOW);  // 0: forward, 1: reverse
//  pinMode(APWM, OUTPUT);  digitalWrite(APWM, LOW);  // PWM motor modulation
//  pinMode(BDIR, OUTPUT);  digitalWrite(BDIR, LOW);  // 0: forward, 1: reverse
//  pinMode(BPWM, OUTPUT);  digitalWrite(BPWM, LOW);  // PWM motor modulation
  DDRB |= 0x0F;
  
  // Reference and Motor Encoders
//  pinMode(PCHA, INPUT);
//  pinMode(PCHB, INPUT);
//  pinMode(MCHA, INPUT_PULLUP);
//  pinMode(MCHB, INPUT_PULLUP);
  DDRC |= 0x0F;
  // Pushbuttons
//  pinMode(SW1_PIN, INPUT_PULLUP);      // stand alone push button
//  pinMode(SW2_PIN, INPUT_PULLUP);      // stand alone push button
//  pinMode(KNOB_SW, INPUT_PULLUP);  // pot switch
   DDRD &= 0xCF;
   DDRC &= 0xFB;
   PORTD |= 0x30;
   PORTC |= 0x04;
  // Test point on UNO13 -> PORTB5
//  pinMode(TP_PIN, OUTPUT); digitalWrite(TP_PIN, LOW);
//  pinMode(LED1, OUTPUT);   digitalWrite(LED1, LOW);
//  pinMode(LED2, OUTPUT);   digitalWrite(LED2, LOW);
    DDRB |= 0x30;
  
  // QTR Sensors
//  pinMode(QTR1_PIN, INPUT_PULLUP);
//  pinMode(QTR2_PIN, INPUT_PULLUP);  
    DDRC &= 0xCF;
    PORTC |= 0x18;
} // end configurePins

//*******************************************************************************************
void configureTimer1(void) {
  // Configure Timer 1 (16 bit) for 20 kHz motor driver PWM generation.
  // Prescale the clock by a divisor of 1.
  // Set the mode to FAST PWM mode with ICR1 defined cycle length (TOP value), (Mode 14)
  // and OCR1 defined duty cycle (compare).
  // Set COM1A bits for clear on compare.
  TCCR1A = 0x82;
  TCCR1B = 0x19;
  OCR1A = 199;
  ICR1 = 799;
  
} // end configureTimer1

//*******************************************************************************************
void readandconditioninputs(){
//  isDownSw1 = !digitalRead(SW1_PIN);
//  isDownSw2 = !digitalRead(SW2_PIN);
  isDownSw1 = ((PIND & 0b00100000) == 0b00000000);
  isDownSw2 = ((PIND & 0b00010000) == 0b00000000);
  
  prevIsDiskWhite = !isDiskWhite;
  isDiskWhite = !digitalRead(QTR2_PIN);
  isDiskWhite = ((PINC & 0b00010000) == 0b00000000);
  
  isDiskB2W = (isDiskWhite && !prevIsDiskWhite);
  isDiskW2B = (!isDiskWhite && prevIsDiskWhite);
  if(isDiskWhite){
    PORTB |= 0b00010000;
  }
  else{
    PORTB &= 0xEF;
  }
  if(isDownSw2){
    PORTB |= 0x20;
  }
  else{
    PORTB &= 0xDF;
  }
//  digitalWrite(LED1, isDiskWhite);
//  digitalWrite(LED2, isDownSw2);
}
//*******************************************************************************************
void switchdirectionmotor(){//ask prof about this
  

}


