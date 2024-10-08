# Starting from the base image with Geant4 installed
FROM carlomt/geant4:11.2.1-centos7

# Set the build environment
SHELL ["/bin/bash", "-c"]

# Post-installation steps
RUN \
    # Remove the package cache file to prevent CMake issues
    rm -f /opt/geant4/lib64/cmake/Geant4/Geant4PackageCache.cmake && \
    \
    # Enable devtoolset-9 to use gcc9
    source /opt/rh/devtoolset-9/enable && \
    \
    # Create a workspace directory
    mkdir -p /workspace && \
    \
    # Download the medical_linac example from the Geant4 repository
    curl -L https://gitlab.cern.ch/geant4/geant4/-/archive/geant4-11.2-release/geant4-master.tar.gz?path=examples/advanced/medical_linac \
    --output /workspace/medical_linac.tar.gz && \
    \
    # Prepare source directory
    mkdir -p /workspace/source && \
    \
    # Extract the medical_linac example from the tar.gz
    tar xf /workspace/medical_linac.tar.gz --strip-components=4 -C /workspace/source && \
    \
    # Change directory to workspace and configure the project
    cd /workspace && \
    cmake /workspace/source && \
    \
    # Compile the project using all available processors
    make -j$(nproc) && \
    \
    # Create a simple run script
    echo '#!/bin/bash' > /usr/local/bin/run && \
    echo 'if [ -z "$1" ]; then' >> /usr/local/bin/run && \
    echo "    echo 'Usage: run <input_file>'" >> /usr/local/bin/run && \
    echo '    exit 1' >> /usr/local/bin/run && \
    echo '/workspace/medical_linac "$1"' >> /usr/local/bin/run && \
    \
    # Make the run script executable
    chmod +x /usr/local/bin/run

# Set environment variables for Geant4
ENV G4WORKDIR=/workspace

# Define the default command for the container
CMD ["/usr/local/bin/run"]
