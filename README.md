# **Apache drill**

## What?

This is an attempt to create an Docker image of Apache Drill for running Drill in distributed mode as StatefulSet in Kubernetes.

## Why?

If you use official Apache drill docker image then please note that -- In [Official docs](https://drill.apache.org/docs/runaning-drill-on-docker), of apache drill, it's clearly mentioned:

> Currently, you can only run Drill in embedded mode in a Docker container. Embedded mode is when a single instance of Drill runs on a node or in a container.


## **Getting started**

1. Build image 

    `$ docker build -t apache-drill:1.15.0 .`

    OR, pull it from DockerHub

    `$ docker pull olishubham/apache-drill:1.15.0`

2. Run a container

    `$ docker run -it --name apache-drill olishubham/apache-drill:1.15.0 `

    OR

    Refernce the image in K8s deployments


### **Environment Variables to be passed at runtime**

| Name        | default          | description                                       |
| ----------- | ---------------- | ------------------------------------------------- |
| CLUSTER_ID  | "my-drillbits"   | (Unique) Cluster ID for your Apache Drill cluster |
| ZK_SERVERS  | "locahost:2181"  | Comma delimited string of DNS/CNAME of ZK cluster |



## **Assumptions and defaults**
Following defaults and assumtions are made:
- DRILL_DIR - /opt/drill
- Owner - drill (uid 1000)
- Group - drill (gid 1000)
- Logs - STDOUT



## **TODOs**

[ ] Multi-stage build to reduce image size (~900 MB current)

[ ] Add support for more configuration at runtime using ENV variables (like modifying logging behaviour)

[ ] Remove copying of `drill-override.conf` and modify `CLUSTER_ID` and `ZK_SERVERS` directly

[ ] Add user auth configuration

