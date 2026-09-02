import requests
from bs4 import BeautifulSoup

url = 'https://www.bilibili.com/'
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')

# Trouve le titre de la page
title = soup.title.string if soup.title else "Pas de titre"
print(f"Titre de la page : {title}")

# Trouve tous les liens
links = soup.find_all('a')
print(f"Nombre de liens : {len(links)}")
