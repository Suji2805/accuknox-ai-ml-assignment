import requests
import matplotlib.pyplot as plt

API_URL = "https://api.slingacademy.com/v1/sample-data/files/student-scores.json"

SUBJECTS = [
    "math_score",
    "history_score",
    "physics_score",
    "chemistry_score",
    "biology_score",
    "english_score",
    "geography_score"
]
CHART_STUDENT_COUNT = 20

def fetch_students():
    """Retrieve student data from the API."""
    try:
        response = requests.get(API_URL, timeout=10)
        response.raise_for_status()
        students = response.json()

        if not isinstance(students, list):
            print("Unexpected API response format.")
            return []
        return students

    except requests.RequestException as error:
        print("Could not retrieve student data:", error)
        return []


def calculate_averages(students):
    """Calculate the average score for each student."""
    student_names = []
    average_scores = []

    for student in students:
        scores = []
        for subject in SUBJECTS:
            score = student.get(subject)

            if isinstance(score, (int, float)):
                scores.append(score)
        if not scores:
            continue

        average = sum(scores) / len(scores)
        student_id = student.get("id", "Unknown")
        first_name = student.get("first_name", "")
        last_name = student.get("last_name", "")
        
        name = (first_name + " " + last_name).strip()
        if not name:
            name = "Unknown Student"
        label = str(student_id) + " - " + name
        student_names.append(label)
        average_scores.append(average)
    return student_names, average_scores

def check_score_range(students):
    """Check the minimum and maximum subject scores."""
    all_scores = []
    for student in students:
        for subject in SUBJECTS:
            score = student.get(subject)

            if isinstance(score, (int, float)):
                all_scores.append(score)

    if all_scores:
        print("Minimum score:", min(all_scores))
        print("Maximum score:", max(all_scores))

def plot_scores(student_names, average_scores, class_average):
    """Create and save a bar chart of student average scores."""
    chart_names = student_names[:CHART_STUDENT_COUNT]
    chart_scores = average_scores[:CHART_STUDENT_COUNT]
    plt.figure(figsize=(12, 6))
    bars = plt.bar(chart_names, chart_scores)
    plt.axhline(
        class_average,
        linestyle="--",
        label=f"Class Average ({len(average_scores)} students)"
    )
    plt.xlabel("Students")
    plt.ylabel("Average Score")
    plt.title(
        f"Student Average Test Scores - First {len(chart_scores)} Students"
    )
    plt.ylim(0, 105)
    plt.xticks(rotation=45, ha="right")

    for bar, score in zip(bars, chart_scores):
        plt.text(
            bar.get_x() + bar.get_width() / 2,
            bar.get_height() + 1,
            f"{score:.1f}",
            ha="center",
            va="bottom"
        )

    plt.legend(loc="lower right")
    plt.tight_layout()
    plt.savefig("student_average_scores.png")
    plt.show()
    plt.close()


def main():
    """Run the student score analysis."""
    students = fetch_students()
    if not students:
        print("No student data was retrieved.")
        return
    print("Data retrieved successfully")
    print("Number of records:", len(students))

    check_score_range(students)
    student_names, average_scores = calculate_averages(students)
    if not average_scores:
        print("No valid scores were found.")
        return

    class_average = sum(average_scores) / len(average_scores)
    print("\nFirst 5 student averages:")
    for name, average in zip(student_names[:5], average_scores[:5]):
        print(name, "Average:", round(average, 2))
    print("\nClass average:", round(class_average, 2))
    plot_scores(
        student_names,
        average_scores,
        class_average
    )

if __name__ == "__main__":
    main()