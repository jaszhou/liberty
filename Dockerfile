
FROM websphere-liberty:latest

ADD *.jar /
ADD config.properties /
ADD ssl /ssl


#CMD mongoimport --db ABN --collection users --file /data/db/users.json

#CMD mongod

#docker run --name mongodb -p 27018:27017 -d jaszhou/mongo

CMD java -Dfile.encoding=UTF-8 -jar blog-1.0-SNAPSHOT.jar 9444  $MONGODB_SERVICE_SERVICE_HOST 2>&1 

EXPOSE 9444

