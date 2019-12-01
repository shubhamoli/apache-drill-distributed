# **Apache drill**

## What?

This is an attempt to create an image of Apache Drill for running Drill in distributed mode.

## Why?

In [Official docs](https://drill.apache.org/docs/runaning-drill-on-docker), of apache drill, it is mentioned 
> Currently, you can only run Drill in embedded mode in a Docker container. Embedded mode is when a single instance of Drill runs on a node or in a container. You do not have to perform any configuration tasks when Drill runs in embedded mode.


## **Getting started**

1. Build image 

    `$ docker build -t drill:1.15.0 .`

2. Run a container

    `$ docker run -it --name apache-drill drill:1.15.0 `

    OR
    
    Pull it directly from my DockerHub Repo
    
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

[ ] Add support for more configuration at runtime using ENV variables (like modifying logging behaviour)

[ ] Remove copying of `drill-override.conf` and modify `CLUSTER_ID` and `ZK_SERVERS` directly

[ ] Add user auth configuration

