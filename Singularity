Bootstrap: docker
From: continuumio/miniconda3

%environment
DCMTK_PREFIX=/opt/dcmtk364
export DCMTK_PREFIX
PATH=$PATH:/opt/dcmtk364/bin:/opt/conda/bin
export PATH

%runscript

if [ $# -eq 0 ]; then
    ls /opt/dcmtk364/bin
    echo "You can issue any of the above commands to the container."
    echo "singularity shell [image] and run python for pydicom." 
    exit 1
else
    exec "$@"
fi

%post

apt-get update && apt-get install -y build-essential
apt-get install -y cmake 
apt-get install -y wget
apt-get install -y vim
apt-get install -y libpng-dev
apt-get install -y libtiff5-dev
apt-get install -y libxml2-dev 
apt-get install -y libjpeg62-turbo-dev
apt-get install -y zlib1g-dev  
apt-get install -y libwrap0-dev 
apt-get install -y libssl-dev

mkdir /data

# Install pydicom
git clone https://www.github.com/pydicom/pydicom.git
cd pydicom && /opt/conda/bin/python setup.py install

# Install pynetdicom
cd ../ && git clone https://www.github.com/pydicom/pynetdicom3.git
cd pynetdicom3 && /opt/conda/bin/python setup.py install

DCMTK_PREFIX=/opt/dcmtk364
export DCMTK_PREFIX

# Releases are here http://dicom.offis.de/download/dcmtk/
wget http://dicom.offis.de/download/dcmtk/release/dcmtk-3.6.4.tar.gz

# Latest development release are here http://dicom.offis.de/download/dcmtk/snapshot/
# wget http://dicom.offis.de/download/dcmtk/snapshot/dcmtk-3.6.1_20170228.tar.gz

# unpack the archive
tar xzvf dcmtk-3.6.4.tar.gz

# go into the unpacked archive
cd dcmtk-3.6.4

cmake -DCMAKE_INSTALL_PREFIX=$DCMTK_PREFIX
make all
make install
