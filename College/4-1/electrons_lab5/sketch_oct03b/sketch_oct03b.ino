void setup() {
  // put your setup code here, to run once:
    Serial.begin(9600);
    delay(100);
  }

void loop() {
  // put your main code here, to run repeatedly:
  for (int i = 0; i < 100; i++){
    delay(100);
    int a0 = analogRead(0);
    float vcc = 2.0*a0*5.0 / 1023.0;
    int a1 = analogRead(1);
    float vce = 2.0*a1*5.0/1023.0;
    float ic = vcc-vce;
    Serial.print("vcc = ");
    Serial.print(vcc);
    Serial.print(" vce = ");
    Serial.print(vce);
    Serial.print(" ic = ");
    Serial.println(ic);
  }
  exit(1);
}
