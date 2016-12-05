# Internet of Things Networking Session:

## Part 1: Build a Simple Sensor App!
So you've probably all heard of the "Internet of Things." It's a big trending industry and especially as healthcare professionals, it's important to understand the main concepts behind it. 

# Step 0: Download Necessary Software and Know Hardware

1. Arduino: https://www.arduino.cc/en/Main/Software
2. Thermistor: 

<img src="./images/Check Arduino Board.png" width="300" height="300">


Hardware List:

1. Arduino Uno Chip
2. Circuit Board
3. 3 Wires
4. Sensor (temperature, distance, etc.)
In our case: Ocr TM 5 Pcs NTC 10K 3950 Ohm Waterproof Digital Thermal Temperature Sensor Probe 1M

# Step 1 Setup:
Open up Arduino and setup the necessary libraries. 
Your file should look like this:

```
void setup() {
  // put your setup code here, to run once:  
}

void loop() {
  // main code goes here: runs in a loop
}
```
You will need to do some initialization to make Arduino work. Think of Arduino like a mini computer that can perform some computation/processing work. You just need to tell it what to do.

Here you will initialize:
- the serial port for communication
- variable for keeping track of voltage reading from temperature sensor
- the pin the thermistor is using

```
// initialize global variables here
#define THERMISTORPIN A0    // the pin that will read in the voltage at thermistor
float tempReading = 0;      // variable to keep track of temperature

void setup() {
  // put your setup code here, to run once: 
  Serial.begin(9600);
}

void loop() {
  // main code goes here: runs in a loop
}
```



# Step 2 Read In Voltages:
Read in the voltage values and utilize the following equation to convert into resistance. From resistance we can convert to temperature.

*INSERT IMAGE HERE*
<img src="./images/steinhardeqns.png" width="300" height="300">


We also want to add some print statements to understand what is going on.

```
// initialize global variables here
#define THERMISTORPIN A0    // the pin that will read in the voltage at thermistor
float tempVoltReading = 0;      // variable to keep track of temperature

// themistor settings
BETA = 3950;
R0 = 10000;

void setup() {
  // put your setup code here, to run once: 
  Serial.begin(9600);
}

void loop() {
  // main code goes here: runs in a loop

  // read in analog value at the thermistor pin
  tempVoltReading = analogRead(THERMISTORPIN);

  // print some messages
  Serial.print("Analog reading is: ");
  Serial.println(tempVoltReading);

  // convert voltage reading to resistance
  RTherm = R0 / (1023 / tempVoltReading-1);
  Serial.print("Thermistor resistance is ");
  Serial.println(RTherm);

  delay(1000); // delay 1 second 
}
```


# Step 3 Improving Solution:
Getting better readings.

When doing analog readings, especially with a 'noisy' board like the arduino, we suggest two tricks to improve results. One is to use the 3.3V voltage pin as an analog reference and the other is to take a bunch of readings in a row and average them.
The first trick relies on the fact that the 5V power supply that comes straight from your computer's USB does a lot of stuff on the Arduino, and is almost always much noisier than the 3.3V line (which goes through a secondary filter/regulator stage!)

Taking multiple readings to average out the result helps get slightly better results as well, since you may have noise or fluctuations, we suggest about 5 samples.

