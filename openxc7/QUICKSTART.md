
Environnement and build variables :
--build-arg TZ=...  Timezone e.g. Europe/Paris
--build-arg base=...  Base mage e.g ubuntu:20.4 ; default ubuntu:20.4

```
docker buildx build --build-arg TZ=Europe/Paris --build-arg base=ubuntu:20.4 -f Dockerfile.openxc7 -t tests-openxc7:git . 
```


planned : CHIPDB path to chipdb database (must be writeable for new chips). 


```
#create place for chipdb
mkdir chipdb

#build bitfile
docker run --rm -v .:/work -e USER_ID=`id -u` -e GROUP_ID=`id -g`   -it tests-openxc7:git  make -C /work/demo/ CHIPDB=/work/chipdb

#list product file
ls -la demo/*

#clean
docker run --rm -v .:/work -e USER_ID=`id -u` -e GROUP_ID=`id -g`   -it tests-openxc7:git  make -C /work/demo/ CHIPDB=/work/chipdb clean
```
