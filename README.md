# Description

The aim of this project was mainly to learn about infrastructure, CI-CD, AWS, and Terraform

I created a very simple CRUD application in Typescritpt + Node.js to have a minimal backend to deploy

## Why not just simply use a service like Vercel?

Point of this project was to specifically learn about concepts about infrastructure.

To the degree that some concepts are still exposed like needing to demand for a Domain, these concepts are for the most abstracted away.

This is not an attack on Vercel, it's a good thing that all these concepts are abstracted away when you're trying to ship as fast as possible for personal projects and early stage startups.

The fact that I have to go on AWS to learn more deeply is a win on Vercel's part.

## AWS

### Running the servers

First question I had to ask myself was what AWS service I was going to use to run the servers that handle incoming client requests

My main choices were

- Lambda
- EC2
- ECS
- EKS

Given that it was the first time I tried to seriously learn about infra, I didn't quite want to dive head first in a serverless paradigm like Lambda.

EC2 would have been the classic option, it was the first service AWS ever released, and therefore would've been an excellent option but I was scared it wouldn't give enough learning surface area.

EKS had the inverse problem, I'd have to learn about Kubernetes from scratch.

As much I would've loved to do that, I evaluated that I'd have to cover too many grounds at once, notably Kubernetes, and wouldn't be able to get a strong grasp of the material I'd learn about.

This is ultimately led to give ECS a shot. Ironically I ended using Fargate  (the serveless version of the service), but it gave sufficient learning material and eased the work of container orchestration. 

### VPC, networks, and routing


