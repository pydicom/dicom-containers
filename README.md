# Singularity Dicom

This is a quick Singularity (container) for getting started with dicom. Currently, we just install the dcmtk tools, and soon we will be adding the python bases as well. First you should install Singularity, and this is for the development branch:

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
singularity create --size 2000 dcm.img
sudo singularity bootstrap dcm.img Singularity
```


## Shell into the container
If you want to interactively shell into the container, you can do it in read or writable mode (writable requires sudo):

```
singularity shell dcm.img
sudo singularity shell --writable dcm.img 
```

## Run Things
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


### Singularity Hub
This image will be built on Singularity Hub soon, so you don't need to build locally (it takes a bit of time to compile everything!). I will also be adding other python-based dicom tools soon.


# Docker
I've added an equivalent Docker image too - hey why not! You can either build locally first,

```
docker build -t vanessa/dicom .
```

or just skip and run as follows from Docker Hub

```
docker run vanessa/dicom
```

and then the equivalent command would be:

```
docker run --volume /path/on/host:/data vanessa/dicom storescu --help
```
