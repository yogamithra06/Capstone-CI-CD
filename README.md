# Capstone-project

To connect to a remote server (EC2 Server) via Jenkins using a SSH Agent and execute docker commands to create a container that runs an application.

**Steps Involved:**
-	Automating Builds
-	Automating Docker image creation
-	Automating Docker image upload
-	Automating Docker container provisioning

**Build Step:**

As part of build step – a jenkins CI/CD pipeline is created with the below stages.
1.	Checkout the react project from GitHub
2.	Build docker image using docker build
3.	Login to docker hub
4.	Push the image to docker hub
5.	Deploy the application to EC2 server

Refer to the Capstone_Project_Design Document.docx
This is the detailed Design document for this capstone project.
It contains all the steps and screenshots required for each and every stage of the project.
