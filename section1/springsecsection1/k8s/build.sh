
#export JAVA_HOME=/usr/lib/jvm/jdk-19-oracle-x64
tag=$1
pull(){
 cd ../
 git pull
 cd k8s/
}


build(){
 cd ../
 mvn clean install -Dcheckstyle.skip=true -Dmaven.test.skip=true
# mvn dependency:copy-dependencies -DoutputDirectory=k8s/jars/lib/
 namespace="ndl"
 appname="spsec"
 release="3.5"
 repo="rtx-swtl-nexus.fnc.net.local/ndl"
 image="${repo}/${namespace}-${appname}:${tag}"

 sudo docker login rtx-swtl-nexus.fnc.net.local

 sudo docker image build --network host -t ndl-spsec .
 sudo docker tag ndl-spsec rtx-swtl-nexus.fnc.net.local/ndl/ndl-spsec:${tag}
 sudo docker image push rtx-swtl-nexus.fnc.net.local/ndl/ndl-spsec:${tag}
 sudo docker image rm rtx-swtl-nexus.fnc.net.local/ndl/ndl-spsec:${tag}
 sudo docker logout rtx-swtl-nexus.fnc.net.local

}

deploy(){
 
 kubectl set image -n ndl deployment/ndl-${appname} ${appname}=${image}
# kubectl apply -f configmap.yaml
# kubectl apply -f deployment.yaml
}

all(){
 pull
 build
 deploy
}

build
deploy
exit
