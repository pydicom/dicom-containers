FROM ubuntu:14.04
MAINTAINER vsochat@stanford.edu

ENV DCMTK_PREFIX=/opt/dcmtk361
ENV PATH=$PATH:/opt/dcmtk361/bin

RUN mkdir /code
ADD run.sh /code




RUN apt-get update && apt-get install -y build-essential \
                                         cmake  \
                                         wget \
                                         vim \
                                         libpng12-dev \
                                         libtiff5-dev \
                                         libxml2-dev  \
                                         libjpeg8-dev \
                                         zlib1g-dev  \
                                         libwrap0-dev \ 
                                         libssl-dev 

RUN mkdir /data

RUN DCMTK_PREFIX=/opt/dcmtk361
RUN export DCMTK_PREFIX

# Releases are here http://dicom.offis.de/download/dcmtk/
# wget http://dicom.offis.de/download/dcmtk/release/dcmtk-3.6.0.tar.gz

# Latest development release are here http://dicom.offis.de/download/dcmtk/snapshot/
RUN wget http://dicom.offis.de/download/dcmtk/snapshot/dcmtk-3.6.1_20170228.tar.gz

# unpack the archive
RUN tar xzvf dcmtk-3.6.1_20170228.tar.gz && cd dcmtk-3.6.1_20170228 && cmake -DCMAKE_INSTALL_PREFIX=$DCMTK_PREFIX && make all && make install

CMD ["/bin/bash","/code/run.sh"]
