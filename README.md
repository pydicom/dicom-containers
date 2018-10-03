# Dicom Containers

This is a collection of containers for getting started and working with dicom and pydicom tools. 

**[Getting Started](getting-started)** is a Docker container build that will include the Dicom Toolkit (dcmtk) along with pydicom and pynetdicom3. The [Singularity](Singularity) container in this folder is the same, but to genereate a Singularity container. See the [getting-started README](getting-started/README.md) for instructions.

**[pydicom-docs](pydicom-docs)** is a Docker container for building the docs for the [pydicom codebase](https://www.github.com/pydicom/pydicom) without needing to install dependencies. See the [README](pydicom-docs/README.md) for instructions.

The version of the containers corresponds with dcmtk. Versions for pydicom
and pynetdicom (when applicable) are listed in the table below.

## pydicom/dicom

This [Docker Container]() is available for the following software versions:

|Image                  | dcmtk        | Pydicom | Pynetdicom3 |
|---------------------- |--------------|---------|-------------|
| pydicom/dicom:v3.6.1  | 3.6.1        |         |             |
| pydicom/dicom:v3.6.3  | 3.6.3        |         |             |

