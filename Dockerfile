FROM openjdk:17-slim

WORKDIR /app
# We need to tell the container to render the GUI on your host machine's X server
# On windows you need to run an X server like VcXsrv or Xming. These allows the GUI from inside the Linuc container to apper on your windows desktop
# Install GUI libraries required by JavaFX to render graphics
#Mesa-utils for OpenGL support
#wget and unzip are used to download and extract the JavaFX SDK
RUN apt-get update && apt-get install -y \
    libx11-6 libxext6 libxrender1 libxtst6 libxi6 libgtk-3-0 mesa-utils wget unzip \
    && rm -rf /var/lib/apt/lists/*

# Download and unzip JavaFX Linux SDK
RUN mkdir -p /javafx-sdk \
    && wget -O javafx.zip https://download2.gluonhq.com/openjfx/21.0.2/openjfx-21.0.2_linux-x64_bin-sdk.zip \
    && unzip javafx.zip -d /javafx-sdk \
    && mv /javafx-sdk/javafx-sdk-21.0.2/lib /javafx-sdk/lib \
    && rm -rf /javafx-sdk/javafx-sdk-21.0.2 javafx.zip

# Copy your fat JAR
  COPY target/javafx_with_mariadb-1.0-SNAPSHOT.jar app.jar
 #COPY target/*.jar app.jar
# Set X11 display (Windows host with Xming/X11)
ENV DISPLAY=host.docker.internal:0.0

# Run JavaFX app
CMD ["java", "--module-path", "/javafx-sdk/lib", "--add-modules", "javafx.controls,javafx.fxml", "-jar", "app.jar"]