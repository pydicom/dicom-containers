FROM continuumio/miniconda3
MAINTAINER vsochat@stanford.edu

# VERSION=$(cat VERSION)
# docker build -t pydicom/dicom:v${VERSION} .

ENV DCMTK_VERSION=dcmtk-3.6.3
ENV DCMTK_PREFIX=/opt/dcmtk363
ENV PATH=$PATH:/opt/dcmtk363/bin:/opt/conda/bin

RUN mkdir /code
ADD run.sh /code

RUN apt-get update && apt-get install -y build-essential \
                                         cmake  \
                                         wget \
                                         vim \
                                         libpng-dev \
                                         libtiff5-dev \
                                         libxml2-dev  \
                                         libjpeg62-turbo-dev \
                                         zlib1g-dev  \
                                         libwrap0-dev \ 
                                         libssl-dev 

RUN mkdir /data

# Install pydicom
WORKDIR /tmp
RUN git clone https://www.github.com/pydicom/pydicom.git
WORKDIR /tmp/pydicom
RUN /opt/conda/bin/python setup.py install

# Install pynetdicom
WORKDIR /tmp 
RUN git clone https://www.github.com/pydicom/pynetdicom3.git
WORKDIR pynetdicom3
RUN /opt/conda/bin/python setup.py install
RUN export DCMTK_PREFIX

# Releases are here http://dicom.offis.de/download/dcmtk/
# wget http://dicom.offis.de/download/dcmtk/release/dcmtk-3.6.0.tar.gz

RUN wget https://dicom.offis.de/download/dcmtk/release/dcmtk-3.6.3.tar.gz

# unpack the archive
RUN tar xzvf ${DCMTK_VERSION}.tar.gz && \
    cd ${DCMTK_VERSION} && \
    cmake -DCMAKE_INSTALL_PREFIX=${DCMTK_PREFIX} && \
    make all && \
    make install

CMD ["/bin/bash","/code/run.sh"]
