//Michael Sarlo Lab 5 part 2
void setup() {
  // put your setup code here, to run once:
  TCCR1A = 0b01010000;
  TCCR1B = 0b00001001;
//  IC1A = 1599;
  OCR1A = 7999;
  DDRB |= 0b00000010;
}

void loop() {
  // put your main code here, to run repeatedly:

}
