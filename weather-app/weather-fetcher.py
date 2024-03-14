import requests
from datetime import datetime
import json
from store_to_cloud import upload_file_to_s3
import os

bucket_name = 'lijos-test-bucket'
html_file = 'docs/index.html' 
data_file = 'weather_data.json'

def fetch_weather_data(api_key, city):
    """
    Fetch weather forecast data from OpenWeatherMap API for a given city.

    Parameters:
    - api_key (str): API key for the OpenWeatherMap API.
    - city (str): City name for which to fetch the weather data.

    Returns:
    - dict: The JSON response from the API containing the weather forecast data.
    """
    url = f"http://api.openweathermap.org/data/2.5/forecast?q={city}&appid={api_key}"
    response = requests.get(url)
    data = response.json()
    return data

def extract_relevant_data(data):
    """
    Extract relevant weather information from the API response.

    Parameters:
    - data (dict): The JSON response from the OpenWeatherMap API.

    Returns:
    - list of tuples: A list where each tuple contains weather information 
                      (date_time, temperature, feels_like, description, wind_speed, humidity).
    """
    weather_data = []
    for item in data['list']:
        timestamp = datetime.utcfromtimestamp(item['dt'])
        date_time = timestamp.strftime('%Y-%m-%d %H:%M:%S')
        temperature = item['main']['temp']
        feels_like = item['main']['feels_like']
        description = item['weather'][0]['description']
        wind_speed = item['wind']['speed']
        humidity = item['main']['humidity']
        weather_data.append((date_time, temperature, feels_like, description, wind_speed, humidity))
    return weather_data

def generate_html_table(weather_data):
    """
    Generate an HTML table from extracted weather data.

    Parameters:
    - weather_data (list of tuples): Extracted weather data.

    Returns:
    - str: HTML content as a string.
    """
    html_table = """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Weather Forecast</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }
            th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>
    <table>
        <thead>
            <tr>
                <th>Date/Time</th>
                <th>Temperature (K)</th>
                <th>Feels Like (K)</th>
                <th>Description</th>
                <th>Wind Speed (m/s)</th>
                <th>Humidity (%)</th>
            </tr>
        </thead>
        <tbody>
    """

    for data in weather_data:
        html_table += f"""
            <tr>
                <td>{data[0]}</td>
                <td>{data[1]}</td>
                <td>{data[2]}</td>
                <td>{data[3]}</td>
                <td>{data[4]}</td>
                <td>{data[5]}</td>
            </tr>
        """

    html_table += """
        </tbody>
    </table>
    </body>
    </html>
    """
    return html_table


def save_html_to_file(html_content, file_name):
    """
    Save HTML content to a file.

    Parameters:
    - html_content (str): HTML content to be saved.
    - file_name (str): Name of the file to save the HTML content.

    Prints:
    - Confirmation message with the file name where the HTML table is saved.
    """
    with open(file_name, 'w') as file:
        file.write(html_content)
    print(f"HTML table saved to '{file_name}'")

def save_json_to_file(json_content, file_name):
    """
    Save HTML content to a file.

    Parameters:
    - html_content (str): HTML content to be saved.
    - file_name (str): Name of the file to save the HTML content.

    Prints:
    - Confirmation message with the file name where the HTML table is saved.
    """
    with open(file_name, "w") as f:
        json.dump(json_content, f)
    print(f"JSON saved to '{file_name}'")

    f.close()
    
# Main execution
API_KEY = os.getenv("API_KEY")
CITY = os.getenv("CITY")


if __name__ == "__main__":
    weather_data = fetch_weather_data(API_KEY, CITY)
    print(weather_data)
    save_json_to_file(weather_data, data_file)
    extracted_data = extract_relevant_data(weather_data)
    html_content = generate_html_table(extracted_data)
    save_html_to_file(html_content, html_file)
    # Upload files
    upload_file_to_s3(html_file, bucket_name, 'text/html', html_file)
    upload_file_to_s3(data_file, bucket_name, 'application/json', data_file)
