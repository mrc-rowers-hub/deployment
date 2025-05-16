These apps are going to be deployed using EC2 

WIP - notes 

* Access via http://18.201.55.231:8080/ (if not working - likely EC2 instance stopped)

apps persist upon sessions being terminated (I run these using PuTTy)
* `nohup mvn spring-boot:run &`
* check for running ps aux | grep spring-boot:run
* stop using kill <PID>

Using puTTy: login as ec2-user 



```
wget https://github.com/adoptium/temurin22-binaries/releases/download/jdk-22%2B36/OpenJDK22U-jdk_x64_linux_hotspot_22_36.tar.gz && \
tar -xvf OpenJDK22U-jdk_x64_linux_hotspot_22_36.tar.gz && \
sudo mv jdk-22+36 /opt/java-22 && \
echo 'export JAVA_HOME=/opt/java-22' >> ~/.bashrc && \
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc && \
source ~/.bashrc && \
java -version
```