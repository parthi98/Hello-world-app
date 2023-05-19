# Architecture and Deployment Document

1. Overview

This document outlines the architecture and deployment steps for creating a private
CloudSQL DB (MySQL), a private GCE instance on a dedicated VPC, deploying a sample application on the GCE instance,
establishing GCE and Private SQL connecting with SQL Auth Proxy, setting up a CI/CD pipeline,
and exposing the sample application via a Jenkins.

2. Architecture

The architecture consists of the following components:

Private CloudSQL DB (MySQL): A private database instance for storing application data securely.
Private GCE Instance       : A Google Compute Engine instance running the sample application ad a SQL Auth Proxy.
SQL Auth Proxy             : It Will running alongside the GCE instance, providing secure communication between the GCE instance and the CloudSQL DB.
Load Balancer              : Exposes the sample application to the external world, distributing traffic to the GCE instance.
CI/CD Pipeline             : Automates the build and deployment process of the sample application using Jenkins.

Step 1: Set up the Infrastructure  

  I created a VPC network to house the GCE instance and CloudSQL DB.
  I configure a subnet within the VPC network.
  I created a private CloudSQL DB instance (MySQL) within the VPC network, disabling public IP access and enabling private network access.
  Provision a GCE instance in the VPC network, specifying the desired machine type and image. The instance will host the sample application and the SQL Auth Proxy.

Step 2: Configure the SQL Auth Proxy

  Installed the necessary software on the GCE instance, such as Jenkins.
  Start the SQL Auth Proxy using the appropriate Build. Ensure it is configured to connect to the CloudSQL DB instance securely.

Step 3: Set up the CI/CD Pipeline

  I choosed a CI/CD tool Jenkins.
  Defined a pipeline configuration file (e.g.,Jenkins file) specifying the necessary build and deployment steps.
  Configured the pipeline to trigger on changes to the application code in a specific branch (e.g., main.tf).
  Include necessary substitution variables, such as the GCE instance name and CloudSQL DB instance connection name, in the pipeline configuration file.
  
Step 4: Expose the Sample Application via a Load Balancer and Jenkins

  Created a Cloud Load Balancer configuration.
  Defined a forwarding rule to direct traffic to the load balancer's target proxy.
  Configure a health check for the load balancer to ensure the GCE instance is healthy.
  Created a backend service that references the GCE instance group and the health check.
  Defined a URL map that associates the default service with the backend service.
  Created a target HTTP proxy that uses the URL map.
  Optionally, I configure firewall rules to allow incoming traffic on the desired ports (e.g., 80 and 443 and 22).
 
 4. Conclusion
In this document I provides an overview of our architecture and deployment steps for creating a private CloudSQL DB, a private GCE instance with SQL Auth Proxy, establishing a CI/CD pipeline, and exposing the sample application via a load balancer, Jenjins. By following these steps, I can set up a secure and scalable environment for Our application deployment.

PLEASE REFER THE SCREENSHOTS ON THE IMAGE FOLDER!!!

THANK YOU FOR GAVE ME THIS OPPORTUNITY..

