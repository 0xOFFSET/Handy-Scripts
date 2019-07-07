import os
from sys import exit
import requests
from requests import exceptions
from bs4 import BeautifulSoup



#######################################################
#  Extracting Playlists
#######################################################

def ExtractPlaylists(channel_url):

	channel_url = channel_url.strip("/") + "/playlists"

	print("connecting to youtube.com ...")

	try: 
		page = requests.get(channel_url, timeout=10)
		
	except exceptions.ConnectionError:
		print("[-] can't reach host youtube.com! ")
		exit(1)


	soup = BeautifulSoup(page.content, 'lxml')
	filtered = soup.findAll('a', {'dir': 'ltr', 'rel':'nofollow'})

	print("The available playlists in channel : \n")

	playlists = []

	for n, item in enumerate(filtered):
		playlists.append(
			{
				'title': item.attrs['title'],
				'url': 'https://www.youtube.com' + item.attrs['href'] 
			})

		print('[{}] {}:  {}'.format(n, playlists[n]['title'], playlists[n]['url']))

	return playlists
### END of: Extracting Playlists



#######################################################
# Interfacing with "youtube-dl" script, using it as API
#
# https://github.com/ytdl-org/youtube-dl
#
# 
######################################################

"""

def formCommand(url, quality, playlist_index=1):

	command = "youtube-dl -f {0} --yes-playlist --playlist-start {1} {2}".format(quality, playlist_index, url)
	return command

"""

"""

def check_available_quality(url):
	# takes video/playlist url and returns desired quality code
	# that farther will be passed to start downloading 

	quality_output = os.system( "youtube-dl -F " + url.strip(" "))
	quality = int(input("Enter desired quality code : "))

	return quality

"""

def main():
	### parameters, options
	try:
		channel_url = input("Enter the channel url: ")

	except SyntaxError:
		print("[-] put the link between two double quotes \"\" ")
		exit(1)

	### END of: parameters, options

	
	playlists = ExtractPlaylists(channel_url)

	# desired_playlists_index = list(map(int, input("Choose the playlists you want to download: ").split()))

	# for i in desired_playlists_index:

	# 	url = playlists[i]['url']
	# 	command = formCommand( url, quality)

	# 	try:
	# 		command_output = os.system(command)
	# 	except Exception as e:
	# 		print(e)



if __name__ == "__main__":
	main()

