This is a Dockerfile setup for sickbeard - http://sickbeard.com/

To run:

docker run -d --name="sickbeard" -v /path/to/sickbeard/data:/config -v /path/to/downloads:/downloads -v /path/to/tv:/tv -v /etc/localtime:/etc/localtime:ro -p 8081:8081 needo/sickbeard
