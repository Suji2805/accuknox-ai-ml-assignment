# Most Complex Python Code

## AI-Based Smart Energy Meter for Power Theft Detection

This is my final-year project. The main purpose of this project is to monitor electricity usage and identify possible power theft or unusual energy consumption.

I worked mainly on the Python part of the project. The system receives energy-related readings from the NodeMCU setup and processes them using Python. I also used the NodeMCU app for monitoring the energy readings.

## Technologies Used

* Python
* Flask
* NumPy
* Scikit-learn
* NodeMCU ESP8266
* ACS712 Current Sensor
* ZMPT101B Voltage Sensor
* CSV
* HTML, CSS and JavaScript
* Telegram
* Voice Alert

## How the Project Works

The NodeMCU collects readings from the sensors connected to the energy meter. These readings are used for monitoring voltage, current and power.

The Python program processes the readings and checks whether the values are normal or unusual.

The basic flow is:

1. NodeMCU collects the sensor readings.
2. The readings are monitored using the NodeMCU app.
3. The data is sent to the Python monitoring system.
4. Python calculates the required electrical values.
5. The readings are stored in a CSV file.
6. The system checks for abnormal readings.
7. Machine learning and statistical methods are used for anomaly detection.
8. The result is shown on a web dashboard.
9. Voice and Telegram alerts are generated when abnormal activity is detected.

## Anomaly Detection

One of the main parts of my Python code is the `TheftDetector` class.

I used a combination of statistical analysis and machine learning to identify unusual readings.

The system first collects normal readings and uses them as a baseline. After that, new readings are compared with the normal behaviour.

I used:

* Z-score based detection
* Isolation Forest from Scikit-learn

The Z-score checks how much a reading differs from the normal values. Isolation Forest is used to identify readings that look unusual.

This was used as an additional detection method along with the energy monitoring system.

## Energy Monitoring

The system calculates values related to electricity usage using the voltage and current readings.

The project monitors values such as:

* Voltage
* Current
* Power
* Energy consumption

The readings are also logged so that they can be checked later.

## NodeMCU Monitoring

For the hardware part, I used a NodeMCU ESP8266 with sensors for measuring electrical parameters.

The main hardware components were:

* NodeMCU ESP8266
* ACS712 current sensor
* ZMPT101B voltage sensor
* LCD display
* Relay
* Buzzer
* LEDs

I also used the NodeMCU app to monitor the energy readings from the setup.

## Flask Dashboard

I used Flask in Python to create a simple monitoring dashboard.

The dashboard is used to display the current readings and the detection status.

The Python program provides API endpoints to get the monitoring data and system status.

## Alerts

The project has two types of alerts.

### Voice Alert

When an abnormal condition is detected, the Python program can generate a voice alert.

### Telegram Alert

The system can also send notifications through Telegram when an abnormal condition is detected.

## Data Logging

The readings are stored in a CSV file. This helped me keep a record of the energy readings and use the data for monitoring and analysis.

## My Contribution

My main work in the Python part of the project included:

* Processing the sensor data
* Calculating energy-related values
* Implementing anomaly detection
* Using Isolation Forest
* Storing readings in CSV
* Creating Flask APIs
* Creating the monitoring dashboard
* Adding voice alerts
* Adding Telegram notifications

I also worked with the NodeMCU-based energy monitoring setup.

## How to Run

Install the required Python packages:

```bash
pip install -r requirements.txt
```

Then run:

```bash
python agent.py
```

The program starts the Flask server and displays the local address for accessing the dashboard.

## What I Learned

This project helped me understand how Python can be used together with hardware and machine learning.

I learned about sensor data processing, anomaly detection, Flask, data logging and sending alerts.

It also gave me experience in connecting the hardware monitoring part with a Python-based application.
