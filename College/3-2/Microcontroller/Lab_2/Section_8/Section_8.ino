#define SW1_PIN 5
#define LED1_PIN 11
#define LED2_PIN 8
#define QTR_SIG_PIN A3
#define QTR_5V_PIN A4
#define QTR_GND_PIN A5
#define MSEC_SAMPLE 1

enum {LED_OFF, BLINK_G, BLINK_R, BLINK_GR, BLINK_RATE};

boolean isSwPressed, prevIsSwPressed, isSwRise, isSwFall, isSwChange;
int state = LED_OFF, prevState = !state;
int stateTimer, adcQTR;
boolean isNewState;

void setup() {
  pinMode(SW1_PIN, INPUT_PULLUP);//  pinMode(SW1_PIN, INPUT); won't work

  pinMode(LED1_PIN, OUTPUT);  digitalWrite(LED1_PIN, LOW);
  pinMode(LED2_PIN, OUTPUT);  digitalWrite(LED2_PIN, LOW);

  pinMode(QTR_SIG_PIN, INPUT);
  pinMode(QTR_5V_PIN, OUTPUT);   digitalWrite(QTR_5V_PIN, HIGH);
  pinMode(QTR_GND_PIN, OUTPUT);  digitalWrite(QTR_GND_PIN, LOW);
   
  Serial.begin(9600);
  Serial.println(F("Lab 2 Complex State Machine"));
} // setup()


// ADD LOOP() HERE
void loop(){
    prevIsSwPressed = isSwPressed;
  isSwPressed = !digitalRead(SW1_PIN);
  isSwRise = (isSwPressed && !prevIsSwPressed);  // switch edge detection
  isSwFall = (!isSwPressed && prevIsSwPressed);    
  isSwChange = (isSwRise || isSwFall);
  
  isNewState = (state != prevState);
  prevState = state;
  
  switch (state) {
 
    case LED_OFF:
      if (isNewState) Serial.println("LED_OFF");
      allOff();
      if (isSwRise) state = BLINK_G;
    break;
    
    case BLINK_G:
      if (isNewState) {
      stateTimer = 0;
      Serial.println("BLINK_G");
      }
      stateTimer++;
      if (stateTimer < 250) greenOn();
      else allOff();
      if (stateTimer >= 1000) stateTimer = 0;
      if (isSwRise) {
        allOff();
        state = BLINK_R; 
      }
    break;

   case BLINK_R:
   if (isNewState) {
      stateTimer = 0;
      Serial.println("BLINK_R");
      }
      stateTimer++;
      if (stateTimer < 250) redOn();
      else allOff();
      if (stateTimer >= 1000) stateTimer = 0;
      if (isSwRise) {
        allOff();
        state = BLINK_GR; 
      }
      break;
  
    case BLINK_GR:
      if (isNewState) {
        stateTimer = 0;
        Serial.println("BLINK_GR");
      }
      stateTimer++;
      if (stateTimer < 250) redOn();
      else greenOn();
      if (stateTimer >= 500) stateTimer = 0;
      if (isSwRise) {
        allOff();
        state = BLINK_RATE;
      }
    break;

    case BLINK_RATE:
      if (isNewState) {
        stateTimer = 0;
        Serial.println("BLINK_RATE");
      }
      stateTimer++;
      adcQTR = analogRead(QTR_SIG_PIN);
      if (stateTimer < adcQTR/2) redOn();
      else greenOn();
      if (stateTimer >= adcQTR) stateTimer = 0;
      if (isSwRise) {
        allOff();
        state = LED_OFF;
      }
    break; 
      
    default: state = LED_OFF;
  } // switch (state)

  delay(MSEC_SAMPLE);
} // loop()


//****************************************************************************
void redOn(void) {
  //PORTB = PORTB |(1 << 0);  // sets Uno dig_8, PORTB.0, pin to 1 (HIGH)
                            // physical pin 14 (28 pin DIP)
  digitalWrite(LED1_PIN, LOW);  // alternative to PORTB setting
  digitalWrite(LED2_PIN, HIGH);
}

//****************************************************************************
void greenOn(void) {
  digitalWrite(LED1_PIN, HIGH);
  digitalWrite(LED2_PIN, LOW);
}

//****************************************************************************
void allOff(void) {
  digitalWrite(LED1_PIN, LOW);
  digitalWrite(LED2_PIN, LOW);
}

