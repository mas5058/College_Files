#define SW1_PIN 5
#define SW2_PIN 4
#define LED1_PIN 12
#define LED2_PIN 13
boolean isSw1Pressed;
boolean isSw2Pressed;
//#define delaysample 9600

void setup() {
pinMode(LED1_PIN, OUTPUT);
pinMode(LED2_PIN, OUTPUT);
pinMode (SW1_PIN, INPUT_PULLUP);
pinMode (SW2_PIN, INPUT_PULLUP);

Serial.begin(9600);

Serial.println(F("Lab 3: single LED in motion"));

} // setup()

void loop() {
  isSw1Pressed = !digitalRead(SW1_PIN);
  digitalWrite (LED1_PIN, isSw1Pressed);
  isSw2Pressed = !digitalRead(SW2_PIN);
  digitalWrite (LED2_PIN, isSw2Pressed);
  //delay(delaysample);
    
} // loop()

//****************************************************************************

void functionCall(void) {
}
