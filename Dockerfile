FROM tomcat:9.0-jdk17
LABEL maintainer="your-email@example.com"

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file to webapps directory
COPY target/CinemaBookingAdminPanel.war /usr/local/tomcat/webapps/ROOT.war

# Copy MySQL Connector to Tomcat lib directory
COPY target/dependency/mysql-connector-java-8.0.33.jar /usr/local/tomcat/lib/

# Expose port 8080
EXPOSE 8080

CMD ["catalina.sh", "run"]
