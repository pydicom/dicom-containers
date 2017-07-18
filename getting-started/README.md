# Getting Started With Dicom

These are Singularity and Docker images that will provide you with installations of pydicom and The Dicom Toolkit. You can use this environment if you don't want to install the dependencies for both on your system.

 - [Docker Hub](https://hub.docker.com/r/pydicom/dicom/)
 - [Singularity Hub](https://singularity-hub.org/collections/pydicom/singularity-dicom)


# Singularity
First you should install Singularity (note this is for the development branch):

```
git clone -b development https://www.github.com/singularityware/singularity.git
cd singularity
./autogen.sh
./configure --prefix=/usr/local
make
sudo make install
```

## Create the image
The image is created with a bootstrap, meaning we create the image, then use a build specification file called [Singularity](Singularity) to build it easily with one command.

```
git clone https://www.github.com/pydicom/singularity-dicom
cd singularity-dicom
singularity create --size 3000 dcm.img
sudo singularity bootstrap dcm.img Singularity
```


## Shell into the container
If you want to interactively shell into the container, you can do it in read or writable mode (writable requires sudo):

```
singularity shell dcm.img
sudo singularity shell --writable dcm.img 
```

## Dicom Toolkit
If you run the container without any input arguments, it will spit out the various `dcm2k` tools it provides:

```
$ singularity run dcm2k.img
dcm2json       dcmdrle	     dcmnet_tests  dcmqrscp	 dconvlum  mkreport
dcm2pdf        dcmdspfn      dcmodify	   dcmqrti	 drtdump   movescu
dcm2pnm        dcmdump	     dcmp2pgm	   dcmquant	 drttest   ofstd_tests
dcm2xml        dcmftest      dcmprscp	   dcmrecv	 dsr2html  pdf2dcm
dcmcjpeg       dcmgpdir      dcmprscu	   dcmrt_tests	 dsr2xml   storescp
dcmcjpls       dcmiod_tests  dcmpschk	   dcmscale	 dsrdump   storescu
dcmconv        dcmj2pnm      dcmpsmk	   dcmseg_tests  dump2dcm  termscu
dcmcrle        dcml2pnm      dcmpsprt	   dcmsend	 echoscu   wlmscpfs
dcmdata_tests  dcmmkcrv      dcmpsrcv	   dcmsign	 findscu   xml2dcm
dcmdjpeg       dcmmkdir      dcmpssnd	   dcmsr_tests	 getscu    xml2dsr
dcmdjpls       dcmmklut      dcmqridx	   dcod2lum	 img2dcm
You can issue any of the above commands to the container.
singularity shell [image] and run python for pydicom.
```

You can then run a specific command (in the example below, `dcm2json`), and we just ask for help.

```
singularity run dcm.img dcm2json --help
$dcmtk: dcm2json v3.6.1 2017-02-28 $

dcm2json: Convert DICOM file and data set to JSON
usage: dcm2json [options] dcmfile-in [jsonfile-out]

parameters:
  dcmfile-in                   DICOM input filename to be converted
  jsonfile-out                 JSON output filename (default: stdout)

general options:
  -h     --help                print this help text and exit
         --version             print version information and exit
         --arguments           print expanded command line arguments
  -q     --quiet               quiet mode, print no warnings and errors
  -v     --verbose             verbose mode, print processing details
  -d     --debug               debug mode, print debug information
  -ll    --log-level           [l]evel: string constant
                               (fatal, error, warn, info, debug, trace)
                               use level l for the logger
  -lc    --log-config          [f]ilename: string
                               use config file f for the logger
input options:
  input file format:
    +f   --read-file           read file format or data set (default)
    +fo  --read-file-only      read file format only
    -f   --read-dataset        read data set without file meta information
  input transfer syntax:
    -t=  --read-xfer-auto      use TS recognition (default)
    -td  --read-xfer-detect    ignore TS specified in the file meta header
    -te  --read-xfer-little    read with explicit VR little endian TS
    -tb  --read-xfer-big       read with explicit VR big endian TS
    -ti  --read-xfer-implicit  read with implicit VR little endian TS
output options:
  output format:
    +fc  --formatted-code      output file with human readable formatting (def.)
    -fc  --compact-code        output without formatting (single line of code)
    +m   --write-meta          write data set with meta information
```

By default, your `$HOME` and temporary file locations are mounted. If you need to mount additional data folders, you can do that with `-B` or `--bind`. A `/data` folder has been created in the container for you to do this easily. Eg:

```
singularity run --bind /path/on/host:/data dcm.img [COMMANDS] --output=/data
```

Notice that I am outputting to `/data` in the container, which is mounted at `/path/to/host` on my local machine. 

## Pydicom Tools
Python is installed at `/opt/conda` and added to the path, so if you shell into the image and run python, you should be able to easily import both and get started with pydicom. The minimal installation has been done for both [pydicom](https://www.github.com/pydicom/pydicom) and [pynetdicom3](https://www.github.com/pydicom/pynetdicom3) and if there is a library or other dependency missing, please [post an issue](https://www.github.com/pydicom/pydicom-container/issues).


### Singularity Hub
We also provide this image for you to use on <a href="https://singularity-hub.org/collections/pydicom/singularity-dicom" target="_blank">Singularity Hub</a> (I'm hiding this down here so you might have tried building it yourself first! We provide the image on , so you can just pull it from there:

```
singularity pull --name dcm.img shub://pydicom/singularity-dicom
```

If you don't specify a `--name` it will pull as `pydicom-singularity-dicom-master.img`.  


# Docker
I've added an equivalent Docker image too - hey why not! You can either build locally first,

```
docker build -t pydicom/dicom .
```

or just skip and run as follows from Docker Hub

```
docker run pydicom/dicom
```

and then the equivalent command would be:

```
docker run --volume /path/on/host:/data pydicom/dicom storescu --help
```

Need help? [![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://badges.gitter.im/pydicom.png)
