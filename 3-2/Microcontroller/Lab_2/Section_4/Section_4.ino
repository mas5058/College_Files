#define SW1_PIN 5
#define LED1_PIN 11
#define QTR_SIG_PIN A3
#define QTR_5V_PIN A4
#define QTR_GND_PIN A5

#define MSEC_SAMPLE 200

boolean isSwPressed;
unsigned int adcQTR;

void setup(){
  pinMode(SW1_PIN, INPUT_PULLUP);
  
  pinMode(LED1_PIN, OUTPUT);  digitalWrite(LED1_PIN, LOW);
  
  pinMode(QTR_SIG_PIN, INPUT);
  pinMode(QTR_GND_PIN, OUTPUT);  digitalWrite(QTR_GND_PIN, LOW); 
  pinMode(QTR_5V_PIN, OUTPUT); digitalWrite(QTR_5V_PIN, HIGH);
  
  //
  //
  
  Serial.begin(9600);
  Serial.println(F("Lab 2: Analog Sensor Reading\n"));
}

void loop(){ 	
  // scan input and condition it (low to hi true)
  isSwPressed = !digitalRead(SW1_PIN); 
  digitalWrite(LED1_PIN, isSwPressed);

  adcQTR = analogRead(QTR_SIG_PIN);  // 0..1023 output
  Serial.println(adcQTR);
  delay(MSEC_SAMPLE);
} // loop()


