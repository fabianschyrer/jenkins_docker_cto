# Defining base image / official Jenkins Docker Hub Image
FROM jenkins/jenkins

# Defining Variables
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG http_port=8080
ARG https_port=443
ARG agent_port=50000
ARG JENKINS_HOME=/var/jenkins_home

# Setting Enrivonment Variables
ENV JENKINS_HOME $JENKINS_HOME
ENV JENKINS_SLAVE_AGENT_PORT ${agent_port}

# Creating Jenkins Home Docker Volume
VOLUME $JENKINS_HOME

# Switch user to root
USER root

# Install Python, Git, Curl and Telnet Client
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils && \
	apt-get install -y python python-pip python3 python3-pip && \
	apt-get install -y git curl && \
	apt-get install -y inetutils-telnet

# Clean up Software Packages
RUN apt-get clean && \
	apt autoremove && \
	deborphan | xargs apt-get -y remove --purge && \
	rm -rf /var/lib/apt/lists/*

# Install AWS CLI (SDK)
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
	unzip awscli-bundle.zip && \
	./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

# Switch user back to jenkins
USER jenkins

# Install Python Packages
RUN pip install aws-sam-cli aws-sam-translator boto boto3 botocore mock pipenv rdk virtualenv virtualenv-clone virtualenvwrapper

# Expose Ports
EXPOSE ${http_port}
EXPOSE ${https_port}
EXPOSE ${agent_port}

# Install Jenkins Plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
