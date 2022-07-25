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

RUN npm i --save esbuild

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

RUN apt list --installed > installed_packages.txt

# Env vars
USER neuroglancer_user
ENV HOME /home/neuroglancer_user
ENV SHELL /bin/bash
ENV USER neuroglancer_user
ENV PATH $CONDA_DIR/bin:$PATH
WORKDIR $HOME

RUN conda install -c conda-forge --repodata-fn=repodata.json nodejs

RUN conda install --yes aiosignal \
anaconda-client \
anaconda-navigator \
anaconda-project \
asgiref \
asn1crypto \
astroid \
astropy \
Babel \
beautifulsoup4 \
bitarray \
bleach \
bokeh \
boto \
Bottleneck \
cachetools \
cffi \
chardet \
click \
cloudpickle \
clyent \
colorama \
conda \
conda-build \
cryptography \
cycler \
Cython \
cytoolz \
dask \
dask-image \
datashape \
debugpy \
decorator \
dill \
distlib \
distributed \
Django \
docutils \
entrypoints \
fastcache \
fasteners \
filelock \
Flask \
freetype-py \
frozenlist \
fsspec \
gevent \
gmpy2 \
google-auth \
greenlet \
grpcio \
hsluv \
idna \
imageio \
imagesize \
importlib-metadata \
incremental \
ipykernel \
ipython \
isort \
itsdangerous \
jedi \
jeepney \
Jinja2 \
jsonschema \
jupyter \
jupyterlab \
keyring \
kiwisolver \
lazy-object-proxy \
llvmlite \
locket \
lxml \
MarkupSafe \
matplotlib \
matplotlib-inline \
mccabe \
mistune \
mkl-service \
more-itertools \
mpmath \
multipledispatch \
natsort \
navigator-updater \
nbclient \
nbconvert \
nbformat \
nest-asyncio \
nltk \
nose \
notebook \
numexpr \
numpy \
numpydoc \
openpyxl \
packaging \
pandas \
pandocfilters \
parso \
partd \
path.py \
pathlib2 \
patsy \
pep8 \
pickleshare \
Pillow \
PIMS \
pkginfo \
platformdirs \
plotly \
pluggy \
ply \
prompt-toolkit \
protobuf \
psutil \
py \
pycodestyle \
pycosat \
pycparser \
pycrypto \
pycurl \
pydantic \
Pygments \
pylint \
pyodbc \
PyOpenGL \
pyOpenSSL \
pyparsing \
PySocks \
pytest \
pytest-arraydiff \
pytest-astropy \
pytest-doctestplus \
pytest-openfiles \
pytest-remotedata \
pytz \
PyWavelets \
PyYAML \
pyzmq \
QtAwesome \
qtconsole \
QtPy \
requests \
rope \
ruamel_yaml \
scikit-image \
scikit-learn \
scipy \
seaborn \
SecretStorage \
simplegeneric \
slicerator \
snowballstemmer \
sortedcontainers \
Sphinx \
sphinxcontrib-applehelp \
sphinxcontrib-devhelp \
sphinxcontrib-htmlhelp \
sphinxcontrib-jsmath \
sphinxcontrib-qthelp \
sphinxcontrib-serializinghtml \
spyder \
spyder-kernels \
SQLAlchemy \
statsmodels \
sympy \
terminado \
testpath \
tifffile \
toolz \
tornado \
tqdm \
traitlets \
Twisted \
typer \
typing_extensions \
unicodecsv \
urllib3 \
virtualenv \
webencodings \
Werkzeug \
widgetsnbextension \
wrapt \
XlsxWriter \
xlwt \
zict \
zipp \
zope.interface 
# Install Jupyter notebook to allow for more interactive neuroglancing
RUN conda install --yes -c conda-forge notebook \
    && conda clean -a
    
RUN pip install jupyterlab-pygments \
    docstring-parser \
    nibabel \
    webcolors \
    napari-plugin-engine \
    antspyx \
    napari-console \
    tables \
    pytomlpp \
    Pint \
    jupyter-console \
    psygnal \
    importlib-resources \
    msgpack \
    magicgui \
    et-xmlfile \
    ray \
    httplib2 \
    prometheus-client \
    mkl-fft \
    cachey \
    chart-studio \
    npe2 \
    jupyter-client \
    tinycss2 \
    oauth2client \
    service-identity \
    napari-svg \
    backports.shutil-get-terminal-size \
    jupyterlab-launcher \
    mkl-random \
    napari \
    google-apitools \
    jupyter-core \
    fastjsonschema 

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
