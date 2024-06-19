# medical_linac Apptainer file to create a container

This README assumes that exists a directory on the host where the container will find (and in case write) the Geant4 datasets, this directory will be identified with  <PATH TO GEANT4 DATA DIR> in the following.
The macro file to run the code should be in the folder where the container is executed and the output will be stored in the same directury.

## Pull the image
You can pull (download) the apptainer image of this application produced by CI with:
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
To keep the size of the container images limited, the Geant4 datasets are not installed. They are expect to be found in
`/opt/geant4/data`
I suggest you to map a folder in the host to use always the same dataset with the option:
`--bind <PATH TO GEANT4 DATA DIR>:/opt/geant4/data`

To check the installed datasets:
```bash
apptainer exec --bind <PATH TO GEANT4 DATA DIR>:/opt/geant4/data medical_linac.sif /opt/geant4/bin/geant4-config --check-datasets
```

If some, or all, are missing it is possible to install the datasets using the container with:
```bash
apptainer exec --bind <PATH TO GEANT4 DATA DIR>:/opt/geant4/data medical_linac.sif /opt/geant4/bin/geant4-config --install-datasets
```

## Run in interactive mode:

```bash
apptainer shell --bind <PATH TO GEANT4 DATA DIR>:/opt/geant4/data medical_linac.sif
```

## Run in batch

```bash
apptainer exec --bind <PATH TO GEANT4 DATA DIR>:/opt/geant4/data medical_linac.sif run <MACRO FILE>
```
