# Getting Started With Dicom

These are Singularity and Docker images that will provide you with installations of pydicom and The Dicom Toolkit. You can use this environment if you don't want to install the dependencies for both on your system.

 - [Docker Hub](https://hub.docker.com/r/pydicom/dicom/)

# Singularity
First you should install Singularity. The complete instructions can be
found in the [user docs](https://sylabs.io/guides/latest/user-guide/).

## Build the image

We can build the Singularity container from the [Singularity](Singularity) recipe file.

```bash
$ git clone https://www.github.com/pydicom/singularity-dicom
$ cd singularity-dicom
$ sudo singularity build dcm.sif Singularity
```

## Shell into the container
If you want to interactively shell into the container, you can do it like this:

```bash
$ singularity shell dcm.sif
```

## Dicom Toolkit
If you run the container without any input arguments, it will spit out the various `dcm2k` tools it provides:

```bash
$ singularity run dcm2k.sif
cda2dcm        dcmdrle	     dcmnet_tests  dcmqrti	 drttest   ofstd_tests
dcm2json       dcmdspfn      dcmodify	   dcmquant	 dsr2html  pdf2dcm
dcm2pdf        dcmdump	     dcmp2pgm	   dcmrecv	 dsr2xml   stl2dcm
dcm2pnm        dcmftest      dcmprscp	   dcmrt_tests	 dsrdump   storescp
dcm2xml        dcmgpdir      dcmprscu	   dcmscale	 dump2dcm  storescu
dcmcjpeg       dcmicmp	     dcmpschk	   dcmseg_tests  echoscu   termscu
dcmcjpls       dcmiod_tests  dcmpsmk	   dcmsend	 findscu   wlmscpfs
dcmconv        dcmj2pnm      dcmpsprt	   dcmsign	 getscu    wltest
dcmcrle        dcml2pnm      dcmpsrcv	   dcmsr_tests	 img2dcm   xml2dcm
dcmdata_tests  dcmmkcrv      dcmpssnd	   dcod2lum	 mkreport  xml2dsr
dcmdjpeg       dcmmkdir      dcmqridx	   dconvlum	 movescu
dcmdjpls       dcmmklut      dcmqrscp	   drtdump	 msgserv
You can issue any of the above commands to the container.
explore ipython to find pynetdicom and pydicom as well.
```

You can then run a specific command (in the example below, `dcm2json`), and we just ask for help.

```bash
singularity run dcm.sif dcm2json --help
$dcmtk: dcm2json v3.6.4 2018-11-29 $

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
    +fc  --formatted-code      enable whitespace formatting (default)
    -fc  --compact-code        print only required characters
    +m   --write-meta          write data set with meta information
                               (warning: not conforming to the DICOM standard)
```

By default, your `$HOME` and temporary file locations are mounted. If you need to mount additional data folders, you can do that with `-B` or `--bind`. A `/data` folder has been created in the container for you to do this easily. Eg:

```bash
$ singularity run --bind /path/on/host:/data dcm.sif [COMMANDS] --output=/data
```

Notice that I am outputting to `/data` in the container, which is mounted at `/path/to/host` on my local machine. 

## Pydicom Tools

Python is installed at `/opt/conda` and added to the path, so if you shell into the image and run python, you should be able to easily import both and get started with pydicom. The minimal installation has been done for both [pydicom](https://www.github.com/pydicom/pydicom) and [pynetdicom3](https://www.github.com/pydicom/pynetdicom3) and if there is a library or other dependency missing, please [post an issue](https://www.github.com/pydicom/pydicom-container/issues).

# Docker

You can also use the same container via Docker. You can either build locally first,

```bash
$ docker build -t pydicom/dicom .
```

or just skip and run as follows from Docker Hub (see [Docker Hub](https://hub.docker.com/r/pydicom/dicom/tags) for tags associated with dcmtk versions that are available).

```bash
$ docker run pydicom/dicom
```

and then the equivalent command to bind a volume would be:

```
docker run --volume /path/on/host:/data pydicom/dicom storescu --help
```

## Pull to Singularity

You can also pull the Docker container down to a Singularity image.

```bash
$ singularity pull docker://pydicom/dicom:v3.6.4
```

Need help? [![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://badges.gitter.im/pydicom.png)
