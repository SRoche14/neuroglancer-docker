FROM debian:bullseye
LABEL author="Steven Roche"
ENV DEBIAN_FRONTEND noninteractive
ENV CONDA_DIR /opt/conda

# Core installs
RUN apt-get update && \
    apt-get upgrade && \
    apt-get install -y git vim wget build-essential python3 ca-certificates bzip2 libsm6 npm nodejs && \
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

# setup the rest of the packages
RUN conda install --yes aiosignal \
alabaster \
anaconda-client \
anaconda-navigator \
anaconda-project \
antspyx \
appdirs \
asgiref \
asn1crypto \
astroid \
astropy \
atomicwrites \
attrs \
Automat \
Babel \
backcall \
backports.shutil-get-terminal-size \
beautifulsoup4 \
bitarray \
bkcharts \
blaze \
bleach \
bokeh \
boto \
Bottleneck \
cachetools \
cachey \
cffi \
chardet \
chart-studio \
click \
cloudpickle \
clyent \
colorama \
conda \
conda-build \
constantly \
contextlib2 \
cryptography \
cycler \
Cython \
cytoolz \
dask \
dask-image \
datashape \
debugpy \
decorator \
defusedxml \
dill \
distlib \
distributed \
Django \
docstring-parser \
docutils \
entrypoints \
et-xmlfile \
fastcache \
fasteners \
fastjsonschema \
filelock \
Flask \
Flask-Cors \
freetype-py \
frozenlist \
fsspec \
gevent \
glob2 \
gmpy2 \
google-apitools \
google-auth \
greenlet \
grpcio \
h5py \
heapdict \
hsluv \
html5lib \
httplib2 \
hyperlink \
idna \
imageio \
imagesize \
importlib-metadata \
importlib-resources \
incremental \
ipykernel \
ipython \
ipython_genutils \
ipywidgets \
isort \
itsdangerous \
jdcal \
jedi \
jeepney \
Jinja2 \
jsonschema \
jupyter \
jupyter-client \
jupyter-console \
jupyter-core \
jupyterlab \
jupyterlab-launcher \
jupyterlab-pygments \
keyring \
kiwisolver \
lazy-object-proxy \
llvmlite \
locket \
lxml \
magicgui \
MarkupSafe \
matplotlib \
matplotlib-inline \
mccabe \
mistune \
mkl-fft \
mkl-random \
mkl-service \
more-itertools \
mpmath \
msgpack \
multipledispatch \
napari \
napari-console \
napari-plugin-engine \
napari-svg \
natsort \
navigator-updater \
nbclient \
nbconvert \
nbformat \
nest-asyncio \
networkx \
neuroglancer \
nibabel \
nltk \
nose \
notebook \
npe2 \
numba \
numexpr \
numpy \
numpydoc \
oauth2client \
odo \
olefile \
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
pexpect \
pickleshare \
Pillow \
PIMS \
Pint \
pkginfo \
platformdirs \
plotly \
pluggy \
ply \
prometheus-client \
prompt-toolkit \
protobuf \
psutil \
psygnal \
ptyprocess \
py \
pyasn1 \
pyasn1-modules \
pycodestyle \
pycosat \
pycparser \
pycrypto \
pycurl \
pydantic \
pyflakes \
Pygments \
pylint \
pyodbc \
PyOpenGL \
pyOpenSSL \
pyparsing \
pyrsistent \
PySocks \
pytest \
pytest-arraydiff \
pytest-astropy \
pytest-doctestplus \
pytest-openfiles \
pytest-remotedata \
python-dateutil \
pytomlpp \
pytz \
PyWavelets \
PyYAML \
pyzmq \
QtAwesome \
qtconsole \
QtPy \
ray \
requests \
retrying \
rope \
rsa \
ruamel_yaml \
scikit-image \
scikit-learn \
scipy \
seaborn \
SecretStorage \
Send2Trash \
service-identity \
simplegeneric \
singledispatch \
slicerator \
snowballstemmer \
sortedcollections \
sortedcontainers \
Sphinx \
sphinxcontrib-applehelp \
sphinxcontrib-devhelp \
sphinxcontrib-htmlhelp \
sphinxcontrib-jsmath \
sphinxcontrib-qthelp \
sphinxcontrib-serializinghtml \
sphinxcontrib-websupport \
spyder \
spyder-kernels \
SQLAlchemy \
sqlparse \
statsmodels \
superqt \
sympy \
tables \
tblib \
tenacity \
terminado \
testpath \
tifffile \
tinycss2 \
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
vispy \
wcwidth \
webcolors \
webencodings \
Werkzeug \
widgetsnbextension \
wrapt \
xlrd \
XlsxWriter \
xlwt \
zict \
zipp \
zope.interface 
# Install Jupyter notebook to allow for more interactive neuroglancing
RUN conda install --yes -c conda-forge notebook \
    && conda clean -a

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
