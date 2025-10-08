# Step 1: Use official JDK base image
FROM openjdk:17-jdk-slim

# Step 2: Set working directory inside container
WORKDIR /app

# Step 3: Copy all files from project folder to container
COPY . /app

# Step 4: Compile the Java file
RUN javac App.java

# Step 5: Define the command to run the program
CMD ["java", "App"]
