#define aout 3
#define writeback 12
uint8_t intnum=0;

void setup() {
  Serial.begin(9600);
  Serial.println("Connected");
  Serial.flush();
  pinMode(aout,OUTPUT);
  pinMode(writeback,INPUT);
}

void loop() {

  Serial.flush();
  while (Serial.available() > 0) 
  {
    char intbuf = 0;
    intbuf = Serial.read();     // Read 8 bits
    intnum=(uint8_t)intbuf;     // Convert Char into uint8
    if (digitalRead(writeback))
      Serial.print(intnum);     // Write data back to Host, HIGH to Enable
    analogWrite(aout, intnum); 
  }
  

}
