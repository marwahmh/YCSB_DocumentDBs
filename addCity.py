import json
import random

def get_random_city():
    cities = ["London", "Paris", "Berlin", "Rome", "Madrid", "Amsterdam", "Vienna", "Prague", "Lisbon", "Stockholm", "Copenhagen", "Dublin", "Brussels", "Warsaw", "Budapest", "Athens", "Helsinki", "Oslo", "Zurich", "Barcelona"]
    return random.choice(cities)

def transform_jsonlines(input_file, output_file):
    with open(input_file, "r") as infile, open(output_file, "w") as outfile:
        for line in infile:
            page = json.loads(line.strip())
            page["record"]["city"] = get_random_city()
            json.dump(page, outfile)
            outfile.write("\n")

# Example usage
transform_jsonlines("booking.json", "booking_final.json")