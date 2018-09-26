# Create Docker network
docker network create --driver bridge --subnet 172.0.0.0/29 jenkins-network &>/dev/null || :

# Run Jenkins Docker Container
docker run -d \
	--name jenkins-cto \
	--volume jenkins_home:/var/jenkins_home \
	--network="jenkins-network" \
	--publish 8080:8080 \
	--publish 50000:50000 \
	jenkins.docker.cto:latest

# docker logs -f jenkins-cto



