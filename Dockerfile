FROM tomcat:10.1-jdk21
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY WebContent /usr/local/tomcat/webapps/ranking
COPY src/RankingServlet.java /tmp/
RUN javac -cp /usr/local/tomcat/lib/servlet-api.jar -d /usr/local/tomcat/webapps/ranking/WEB-INF/classes /tmp/RankingServlet.java
EXPOSE 8080
