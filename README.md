# medical_linac Apptainer file to create a container

## Compile

To compile the container:
```
apptainer build medical_linac.sif medical_linac.def
```

## Check and download Geant4 datasets

To check the installed datasets:
```
apptainer exec --bind <PATH TO GEANT4 DATA DIR>:/opt/geant4/data medical_linac.sif /opt/geant4/bin/geant4-config --check-datasets
```

To install missing datasets:
```
apptainer exec --bind <PATH TO GEANT4 DATA DIR>:/opt/geant4/data medical_linac.sif /opt/geant4/bin/geant4-config --install-datasets
```

## Run in interactive mode:

```
apptainer shell --bind <PATH TO GEANT4 DATA DIR>:/opt/geant4/data medical_linac.sif
```

## Run

```
apptainer exec --bind <PATH TO GEANT4 DATA DIR>:/opt/geant4/data medical_linac.sif run <MACRO FILE>
```