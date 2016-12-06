import processing.serial.*;
import java.io.*;

Serial myPort; // create object from Serial class
String val = "";    // data from Serial port
String FILENAME = "iotData.txt";
FileWriter output = null;

void setup() {
  String portName = Serial.list()[1]; // might need to change this 
  //println(Serial.list());
  println(portName);
  println(sketchPath());
  myPort = new Serial(this, portName, 9600);

  try {
    output = new FileWriter(FILENAME, true); //the true will append the new data
    output.write("time,temperature\n");
    println("Working!");
  }
  catch (IOException e) {
    println("It Broke");
    e.printStackTrace();
  }
  finally {
    if (output != null) {
      try {
        output.close();
      } catch (IOException e) {
        println("Error while closing the writer");
      }
    }
  }
}

void draw() {
  if (myPort.available() > 0)
  {
    val = myPort.readStringUntil('\n');
  }
  //println(val);

  String[] valueArray = split(val, ',');
  
  try {
    output = new FileWriter(FILENAME, true); //the true will append the new data
    output.write(val);
    //println("Working!");
  }
  catch (IOException e) {
    println("It Broke");
    e.printStackTrace();
  }
  finally {
    if (output != null) {
      try {
        output.close();
      } catch (IOException e) {
        println("Error while closing the writer");
      }
    }
  }
}