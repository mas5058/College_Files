void setup() {
  // put your setup code here, to run once:
 Serial.begin(9600); 
 delay(100);
 
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.print(" DCin Voltage = " );
  float avg = 0;
  for(int i=0; i<5; i = i+1)
  {
    delay(100);
    avg = avg + analogRead(0); 
    delay(100);
    
  }
  avg = avg/5.0;
  float DCin = (5.0/1023.0) * 2 * avg;
  DCin=DCin + DCin*.03; //Added percent error adjustment
  Serial.println(DCin);
  delay(200);
  exit(1);
}
