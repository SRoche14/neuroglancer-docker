FROM debian:bullseye
LABEL author="Steven Roche"
ENV DEBIAN_FRONTEND noninteractive
ENV CONDA_DIR /opt/conda

# Core installs
RUN apt-get update && \
    apt-get upgrade && \
    apt-get install -y git vim wget build-essential python3 ca-certificates bzip2 libsm6 npm nodejs curl build-essential libssl-dev && \
    apt-get clean

RUN npm install -g npm@latest

RUN mkdir -p ~/miniconda3

# Install miniconda 
RUN echo 'export PATH=$CONDA_DIR/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh && \
    /bin/bash ~/miniconda3/miniconda.sh -b -p $CONDA_DIR && \
    rm -rf ~/miniconda3/miniconda3.sh && \
    $CONDA_DIR/bin/conda install --yes conda


# Create a user
RUN useradd -m -s /bin/bash neuroglancer_user
RUN chown -R neuroglancer_user:neuroglancer_user $CONDA_DIR

# Env vars
USER neuroglancer_user
ENV HOME /home/neuroglancer_user
ENV SHELL /bin/bash
ENV USER neuroglancer_user
ENV PATH $CONDA_DIR/bin:$PATH
WORKDIR $HOME


RUN conda install --yes nose numpy pandas matplotlib scipy seaborn numba bokeh pillow ipython \
astroid \
Babel \
boto \
cachetools \
conda-build \
dask \
dask-image \
datashape \
debugpy \
dill \
docutils \
imageio \
imagesize \
mpmath \
natsort \
nltk \
numpydoc \
pathlib2 \
pkginfo \
plotly \
ply \
pylint \
pyodbc \
PyOpenGL \
PySocks \
scikit-image \
scikit-learn \
sortedcontainers \
spyder \
spyder-kernels \
statsmodels \
sympy \
testpath \
tifffile \
toolz \
virtualenv 

# Install Jupyter notebook to allow for more interactive neuroglancing
RUN conda install --yes -c conda-forge notebook \
    && conda clean -a
    
RUN pip install napari-plugin-engine \
    antspyx \
    napari-console \
    tables \
    psygnal \
    ray \
    npe2 \
    tinycss2 \
    napari-svg \
    mkl-random \
    napari 

# install neuroglancer from github
RUN git clone https://github.com/google/neuroglancer.git
WORKDIR neuroglancer
RUN ls 
RUN python3 setup.py install

ADD docker_demo.py $HOME/docker_demo.py
ADD notebooks $HOME/notebooks
ADD test_data $HOME/test_data
USER root
RUN chown -R neuroglancer_user:neuroglancer_user $HOME/notebooks
RUN chown -R neuroglancer_user:neuroglancer_user $HOME/docker_demo.py

# Open ports for the notebook and the server
EXPOSE 8888
EXPOSE 8989

# run the notebook as a user
USER neuroglancer_user
WORKDIR $HOME
CMD jupyter notebook --ip='0.0.0.0'
