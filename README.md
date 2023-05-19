# Architecture and Deployment Document
1. Overview

This document outlines the architecture and deployment steps for creating a private
CloudSQL DB (MySQL), a private GCE instance on a dedicated VPC, deploying a sample application on the GCE instance,
establishing GCE and Private SQL connecting with SQL Auth Proxy, setting up a CI/CD pipeline,
and exposing the sample application via a Jenkins.

2. Architecture

The architecture consists of the following components:

Private CloudSQL DB (MySQL): A private database instance for storing application data securely.

Private GCE Instance: A Google Compute Engine instance running the sample application and a SQL Auth Proxy.

SQL Auth Proxy : It Will running alongside the GCE instance, providing secure communication between the GCE instance and the CloudSQL DB.

Load Balancer: Exposes the sample application to the external world, distributing traffic to the GCE instance.

CI/CD Pipeline: Automates the build and deployment process of the sample application using Jenkins.

