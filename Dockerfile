FROM python:3.8.7-slim-buster
FROM nikolaik/python-nodejs:python3.8-nodejs12-slim
EXPOSE 9997


########### Copy all files and Set working directory #############
WORKDIR /app
ADD assignment /app/assignment
COPY run*.sh   /app/

# Change gcp configuration shell script in order to run
RUN chmod 777 /app/*.sh


