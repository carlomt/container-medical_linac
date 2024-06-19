# medical_linac Apptainer file to create a container

This README assumes that exists a directory on the host where the container will find (and in case write) the Geant4 datasets, this directory will be identified with  <PATH TO GEANT4 DATA DIR> in the following.
The macro file to run the code should be in the folder where the container is executed and the output will be stored in the same directury.

## Pull the image
You can download (pull) the apptainer image of this application direclty with:
```bash
apptainer pull oras://ghcr.io/carlomt/container-medical_linac:latest
```
to run it you need anyway to install the Geant4 datasets, see later.

## Compile

To compile the container:
```bash
apptainer build medical_linac.sif medical_linac.def
```

## Check and download Geant4 datasets

To check the installed datasets:
```bash
apptainer exec --bind <PATH TO GEANT4 DATA DIR>:/opt/geant4/data medical_linac.sif /opt/geant4/bin/geant4-config --check-datasets
```

To install missing datasets:
```bash
apptainer exec --bind <PATH TO GEANT4 DATA DIR>:/opt/geant4/data medical_linac.sif /opt/geant4/bin/geant4-config --install-datasets
```

## Run in interactive mode:

```bash
apptainer shell --bind <PATH TO GEANT4 DATA DIR>:/opt/geant4/data medical_linac.sif
```

## Run

```
apptainer exec --bind <PATH TO GEANT4 DATA DIR>:/opt/geant4/data medical_linac.sif run <MACRO FILE>
```
