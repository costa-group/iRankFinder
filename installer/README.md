# iRankFinder Scripts

## Installation

Run `install.sh --help` to get more information.
This script will call `install_externals.sh` and `install_modules.sh`


### Docker

Dockerfile is self-content. You only need to download the file, and run
docker build with the arguments described below.

#### Optional Arguments
This docker has some arguments that you can set using `--build-arg` parameter.

1- Installation mode: *stable*, dev or binary (default: stable)

   `mode=dev`

2- Where to install inside docker: (default: /opt/tools)

   `TOOLS_HOME=/opt/tools`

3- Install `EasyInterface` as interface: (default: true)

   `interface=true`


#### Build Docker

Set some variables:
```
docker_image_name=irankfinder
docker_container_name=irankfinder
out_port=8081
```

To build and run the docker. Just run:
(if you want an especial installation: Remember to add ` --build-arg <name>=<value> ` at the end of the first line)

```
docker build -t $docker_image_name .
docker run -d -p $out_port:80 --name $docker_container_name $docker_image_name
docker exec -it $docker_container_name bash
```

## Update

`update_modules.sh` will detect which installation do you have, and
try to update the main modules of iRankFinder and the minor
dependencies but it won't update other dependencies like ppl.

## Statically-linked binary (Standalone)

`toStaticBinary.sh` will generate a statically linked binary inside
`[PATH]/pyRankFinder/dist/[VERSION]/irankfinder`
and a zip `[PATH]/pyRankFinder/dist/irankfinder_[VERSION]_[PLATFORM]_[ARCH].zip

It requires pyinstaller and zip installed (which are not installed
with the given scripts.


```
apt-get install zip
pip3 install -U pyinstaller
```

you can specify the folder where all the projects are located using the
parameter `--path`. or set the env variable `TOOLS_HOME`

