import json
import random

# Define the file paths
input_file_path = 'booking_final.json'  # Replace with the actual input file path
output_file_path = 'booking_final_transformed_data.json'

# Read the original JSON data from the file
with open(input_file_path, 'r') as input_file:
    data = [json.loads(line) for line in input_file]

# Wrap the data inside the "docs" key
transformed_data = {"docs": data}

# Write the transformed JSON data to a new file
with open(output_file_path, 'w') as output_file:
    json.dump(transformed_data, output_file, indent=2)

print(f"Transformed JSON data has been saved to {output_file_path}")


