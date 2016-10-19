#define LED1_PIN 11   // Port B3
#define LED2_PIN 8    // Port B0

void setup() {
  pinMode(LED1_PIN, OUTPUT);  digitalWrite(LED1_PIN, LOW);
  pinMode(LED2_PIN, OUTPUT);  digitalWrite(LED2_PIN, LOW);
   
  Serial.begin(9600);
  Serial.println(F("Lab 2 Faster I/O"));
}

void loop() {

// Set pin high then low using slow library function

  digitalWrite(LED2_PIN,LOW);
  digitalWrite(LED2_PIN,HIGH);
  digitalWrite(LED2_PIN,LOW);

// Set pin high then low using fast direct setting of using bit manipulation

  // Three ways to do the same thing 
  
  // Binary
  PORTB = PORTB | 0b00000001; // set pin HIGH
  PORTB = PORTB & 0b11111110; // set pin LOW
    
  // Hex
  PORTB |= 0x01; // set pin HIGH
  PORTB &= 0xFE; // set pin LOW
  
  // bit shifting
  PORTB |= (1 << 0); // set pin HIGH
  PORTB &= ~(1 << 0); // set pin LOW
}

