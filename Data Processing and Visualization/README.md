# Data Processing and Visualization

## About the Project

In this exercise, I used Python to get student test scores from an API. I calculated the average score for each student and created a bar chart to visualize the results.

## API Used

I used the following student scores API:

`https://api.slingacademy.com/v1/sample-data/files/student-scores.json`

The API contains 2,000 student records. Each record has scores for subjects such as Math, History, Physics, Chemistry, Biology, English, and Geography.

## Tools Used

* Python
* Requests
* Matplotlib

## What I Did

The program follows these steps:

1. Connects to the API and retrieves the student data.
2. Checks whether the API request was successful.
3. Takes the scores of each student.
4. Calculates the average of the available subject scores.
5. Calculates the overall class average.
6. Displays the first five student averages in the terminal.
7. Creates a bar chart using the first 20 students.
8. Shows the class average as a horizontal line on the chart.
9. Saves the chart as `student_average_scores.png`.

## Handling Missing Scores

If a student's score for a subject is missing or is not a number, I don't include that score in the calculation.

If a student has no valid scores, that student is skipped.

## Class Average

I calculated the class average by taking the average of the individual student averages.

The program processes all the students, but the chart displays only the first 20 students because displaying all 2,000 students would make the chart difficult to read.

The class average line on the chart represents all the students with valid averages, not just the 20 students shown in the chart.

## Chart

The bar chart shows the average score of each of the first 20 students.

I kept the y-axis starting from 0 so that the differences between the scores are not exaggerated.

The average value is also displayed above each bar.

## Error Handling

I added error handling for problems such as:

* Network or API request errors
* API response in an unexpected format
* Missing scores
* Non-numeric scores
* No valid student scores

A 10-second timeout is also used for the API request.

## How to Run

First install the required libraries:

```bash
pip install -r requirements.txt
```

Then run:

```bash
python student_scores.py
```

The program will display the results and generate:

`student_average_scores.png`

## Files

* `student_scores.py` – Python code for the exercise
* `requirements.txt` – Required Python libraries
* `student_average_scores.png` – Generated chart
* `README.md` – Project details
