// Oscilliascope EEG Reader Version 1
// By Alexander Pope

import processing.serial.*;

Serial port;  // Create object from Serial class
int val;      // Data received from the serial port
int[] values;

void setup() 
{
  size(920, 1280);
  // Open the port that the board is connected to and use the same speed (9600 bps)
  port = new Serial(this, Serial.list()[15], 9200);
  values = new int[width];
}

int getY(int val) {
  return (int)(val / 1023.0f * height);
}

void draw()
{
  while (port.available() >= 3) {
    if (port.read() == 0xff) {
      val = (port.read() << 8) | (port.read());
    }
  }
  // Make an array of values and delete old values that run off screen
  for (int i=0; i<width-1; i++) {
    values[i] = values[i+1];
  }
  values[width-1] = val;
  background(0);
  stroke(255);
  
  // Draw the waves
  for (int x=1; x<width; x++) {
    line(width-x,   height-1-getY(values[x-1]), 
         width-1-x, height-1-getY(values[x]));
  }
}