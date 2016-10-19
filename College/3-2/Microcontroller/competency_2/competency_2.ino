//Michael Sarlo
//competency 2
//11-18-15
boolean first = true;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.println(F("Lab 5: Configuration Detection"));
//  DDRB |= 0b00010010;
//  TCCR1A = 0b11110010;
//  TCCR1B = 0b00010001;
//  ICR1 = 3999;
//  OCR1A = 1199;
//  PORTB |= 0b00010000;
  TCCR1A = 0x00;
  TCCR1B = 0x04;
  //OCR1A |= 5000;
  DDRB |= 0b00100000;
  Serial.println("Red Led on!");
  PORTB |= 0x20;

  }
  


void loop() {
  static int count = 0;
  if((TIFR1 & 0b00000001) == 0b00000001){
    count += 1;
    TIFR1 |= 0b00000001;
  }  
  if (count == 5){
    PORTB &= 0x00; 
    Serial.println("Red Led off!");
    count += 1;
  }
  if (count == 6){
    green();
    count = 6;
  }
  //Serial.println(count);
}
  

void green(){
  //if(first == true){
    //static int count = 0;
  DDRB &= 0x00;
  TCCR1A &= 0x00;
  TCCR1B &= 0x00; 
  DDRB |= 0b00000010;
  TCCR1A |= 0b10000010;
  TCCR1B |= 0b00011001;    //move tccr1 and 2 to setu
  ICR1 = 3999;
  OCR1A = 2799;
  //count += 1;
//  if(OCR1A == 1199){
//    PORTB |= 0b00000010;
//  }
  //Serial.println(count);
  //count ++;
  if (first == true){
    Serial.println("Green Led 70% DC @ 4khz");
    first = false;
  }

}
