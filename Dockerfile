FROM ubuntu

RUN apt-get update

WORKDIR /app
RUN apt-get install -y python3-pip # Example package installation

COPY . /app/ 

#RUN cd /home/ubuntu

RUN pip3 install flask
     
CMD [ "python3","app.py" ]
