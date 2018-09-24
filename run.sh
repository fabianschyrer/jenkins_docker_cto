# Ruin Jenkins Docker Container
docker run -d \
	--name Jenkins-CTO \
	--volume jenkins_home:/var/jenkins_home \
	--publish 8080:8080 \
	--publish 50000:50000 \
	jenkins.docker.cto:latest

docker logs -f Jenkins-CTO



