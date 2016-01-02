// By Alexander Pope
// Hook up the output of the EEG Amplifier to Analog Pin 0 on the Arduino Uno
#define ANALOG_IN 0

void setup() {
  Serial.begin(18200);
}

void loop() {
  int val = analogRead(ANALOG_IN);
  
  //Send 4 bytes of data in total to the Processing program over the serial port
  Serial.write( 0xff); //Send begin transmition code for processing (4 bytes)
  Serial.write( (val >> 8) & 0xff); //Send the value in the first 2 bytes and all 1s in last two bytes (4 bytes)
  Serial.write( val & 0xff); //Send a useless string of 4 bytes, with the 1st two bytes being 0s
}

