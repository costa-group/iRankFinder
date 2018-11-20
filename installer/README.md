# iRankFinder Installation

Run `install.sh --help` to get more information.
This script will call `install_externals.sh` and `install_modules.sh`


## Docker

### Optional Arguments
This docker has some arguments that you can set.

- how and where to install iRankFinder
- - Binary
- - Clonning repos
- - direct from pip

- install EasyInterface
- - Where?


### Build Docker

Set some variables:
```
docker_image_name=irankfinder
docker_container_name=irankfinder
out_port=8081
```

To build and run the docker. Just run:
(if you want an especial installation: Remember to add ` ????? ` at the
end of the first line)

```
docker build -t $docker_image_name .
docker run -d -p $out_port:80 --name $docker_container_name $docker_image_name
docker exec -it $docker_container_name bash
```
