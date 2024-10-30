import requests
from bs4 import BeautifulSoup

# Send an HTTP request to the webpage
url = 'https://www.examveda.com/sql/practice-mcq-question-on-sql-miscellaneous/'
response = requests.get(url)

# Parse the HTML content of the webpage
soup = BeautifulSoup(response.content, 'html.parser')

# Extract specific data from the webpage
# Example: Extract all the links (anchor tags)
links = soup.find_all('article')

# Print the extracted links
for link in links:
    print(link.get('href'))
