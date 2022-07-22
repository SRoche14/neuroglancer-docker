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
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py37_4.12.0-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh && \
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

RUN conda install --yes aiosignal=1.2.0 \
alabaster=0.7.11 \
anaconda=5.3.1 \
anaconda-client=1.7.2 \
anaconda-navigator=1.9.2 \
anaconda-project=0.8.2 \
antspyx=0.3.3 \
appdirs=1.4.4 \
appdirs=1.4.3 \
asgiref=3.5.2 \
asn1crypto=0.24.0 \
astroid=2.0.4 \
astropy=3.0.4 \
atomicwrites=1.2.1 \
attrs=18.2.0 \
automat=0.7.0 \
babel=2.6.0 \
backcall=0.1.0 \
backcall=0.2.0 \
backports=1.0 \
beautifulsoup4=4.6.3 \
bitarray=0.8.3 \
bkcharts=0.2 \
blas=1.0 \
blaze=0.11.3 \
bleach=2.1.4 \
blosc=1.14.4 \
bokeh=0.13.0 \
boto=2.49.0 \
bottleneck=1.2.1 \
bzip2=1.0.6 \
cachetools=5.2.0 \
cachey=0.2.1 \
cairo=1.14.12 \
cffi=1.11.5 \
chardet=3.0.4 \
chart-studio=1.1.0 \
click=8.0.4 \
click=6.7 \
cloudpickle=2.1.0 \
cloudpickle=0.5.5 \
clyent=1.2.2 \
colorama=0.3.9 \
conda=4.5.11 \
conda-build=3.15.1 \
conda-env=2.6.0 \
constantly=15.1.0 \
contextlib2=0.5.5 \
cryptography=2.3.1 \
curl=7.61.0 \
cycler=0.10.0 \
cython=0.28.5 \
cytoolz=0.9.0.1 \
dask=2022.2.0 \
dask=0.19.1 \
dask-core=0.19.1 \
dask-image=2021.12.0 \
datashape=0.5.4 \
dbus=1.13.2 \
debugpy=1.6.0 \
decorator=5.1.1 \
decorator=4.3.0 \
defusedxml=0.5.0 \
dill=0.3.5.1 \
distlib=0.3.4 \
distributed=1.23.1 \
Django=3.2.13 \
docstring-parser=0.14.1 \
docutils=0.14 \
entrypoints=0.4 \
entrypoints=0.2.3 \
et_xmlfile=1.0.1 \
expat=2.2.6 \
fastcache=1.0.2 \
fasteners=0.17.3 \
fastjsonschema=2.15.3 \
filelock=3.0.8 \
filelock=3.7.1 \
flask=1.0.2 \
flask-cors=3.0.6 \
fontconfig=2.13.0 \
freetype=2.9.1 \
freetype-py=2.3.0 \
fribidi=1.0.5 \
frozenlist=1.3.0 \
fsspec=2022.5.0 \
get_terminal_size=1.0.0 \
gevent=1.3.6 \
glib=2.56.2 \
glob2=0.6 \
gmp=6.1.2 \
gmpy2=2.0.8 \
google-apitools=0.5.32 \
google-auth=2.9.0 \
graphite2=1.3.12 \
greenlet=0.4.15 \
grpcio=1.43.0 \
gst-plugins-base=1.14.0 \
gstreamer=1.14.0 \
h5py=2.8.0 \
harfbuzz=1.8.8 \
hdf5=1.10.2 \
heapdict=1.0.0 \
hsluv=5.0.3 \
html5lib=1.0.1 \
httplib2=0.20.4 \
hyperlink=18.0.0 \
icu=58.2 \
idna=2.7 \
imageio=2.19.3 \
imageio=2.4.1 \
imagesize=1.1.0 \
importlib-metadata=4.11.4 \
importlib-resources=5.8.0 \
incremental=17.5.0 \
intel-openmp=2019.0 \
ipykernel=6.15.0 \
ipykernel=4.9.0 \
ipython=6.5.0 \
ipython=7.34.0 \
ipython-genutils=0.2.0 \
ipython_genutils=0.2.0 \
ipywidgets=7.4.1 \
isort=4.3.4 \
itsdangerous=0.24 \
jbig=2.1 \
jdcal=1.4 \
jedi=0.18.1 \
jedi=0.12.1 \
jeepney=0.3.1 \
jinja2=2.10 \
Jinja2=3.1.2 \
jpeg=9b \
jsonschema=4.6.0 \
jsonschema=2.6.0 \
jupyter=1.0.0 \
jupyter-client=7.3.4 \
jupyter-core=4.10.0 \
jupyter_client=5.2.3 \
jupyter_console=5.2.0 \
jupyter_core=4.4.0 \
jupyterlab=0.34.9 \
jupyterlab-pygments=0.2.2 \
jupyterlab_launcher=0.13.1 \
keyring=13.2.1 \
kiwisolver=1.0.1 \
lazy-object-proxy=1.3.1 \
ld_impl_linux-64=2.38 \
libcurl=7.61.0 \
libedit=3.1.20170329 \
libffi=3.3 \
libgcc-ng=11.2.0 \
libgfortran-ng=7.3.0 \
libpng=1.6.34 \
libsodium=1.0.16 \
libssh2=1.8.0 \
libstdcxx-ng=8.2.0 \
libtiff=4.0.9 \
libtool=2.4.6 \
libuuid=1.0.3 \
libxcb=1.13 \
libxml2=2.9.8 \
libxslt=1.1.32 \
llvmlite=0.24.0 \
locket=0.2.0 \
lxml=4.2.5 \
lzo=2.10 \
magicgui=0.5.1 \
markupsafe=1.0 \
MarkupSafe=2.1.1 \
matplotlib=2.2.3 \
matplotlib-inline=0.1.3 \
mccabe=0.6.1 \
mistune=0.8.3 \
mkl=2020.2 \
mkl-service=2.3.0 \
mkl_fft=1.3.0 \
mkl_random=1.1.1 \
more-itertools=4.3.0 \
mpc=1.1.0 \
mpfr=4.0.1 \
mpmath=1.0.0 \
msgpack=1.0.4 \
msgpack-python=0.5.6 \
multipledispatch=0.6.0 \
napari=0.4.14 \
napari-console=0.0.4 \
napari-plugin-engine=0.2.0 \
napari-svg=0.1.6 \
natsort=8.1.0 \
navigator-updater=0.2.1 \
nbclient=0.6.4 \
nbconvert=5.4.0 \
nbconvert=6.5.0 \
nbformat=5.4.0 \
nbformat=4.4.0 \
ncurses=6.3 \
nest-asyncio=1.5.5 \
networkx=2.6.3 \
networkx=2.1 \
neuroglancer=2.28 \
nibabel=4.0.1 \
nltk=3.3.0 \
nose=1.3.7 \
notebook=5.6.0 \
npe2=0.2.1 \
numba=0.39.0 \
numexpr=2.6.8 \
numpy=1.21.6 \
numpy=1.19.2 \
numpy-base=1.19.2 \
numpydoc=1.4.0 \
numpydoc=0.8.0 \
oauth2client=4.1.3 \
odo=0.5.1 \
olefile=0.46 \
openpyxl=2.5.6 \
openssl=1.1.1o \
packaging=17.1 \
packaging=21.3 \
pandas=1.1.5 \
pandas=0.23.4 \
pandoc=1.19.2.1 \
pandocfilters=1.4.2 \
pango=1.42.4 \
parso=0.8.3 \
parso=0.3.1 \
partd=0.3.8 \
partd=1.2.0 \
patchelf=0.9 \
path.py=11.1.0 \
pathlib2=2.3.2 \
patsy=0.5.0 \
pcre=8.42 \
pep8=1.7.1 \
pexpect=4.8.0 \
pexpect=4.6.0 \
pickleshare=0.7.4 \
pickleshare=0.7.5 \
Pillow=9.1.1 \
pillow=5.2.0 \
PIMS=0.6.1 \
Pint=0.18 \
pip=22.1.2 \
pip=21.2.2 \
pixman=0.34.0 \
pkginfo=1.4.2 \
platformdirs=2.5.2 \
plotly=5.9.0 \
pluggy=0.7.1 \
ply=3.11 \
prometheus_client=0.3.1 \
prompt-toolkit=3.0.29 \
prompt_toolkit=1.0.15 \
protobuf=3.20.1 \
psutil=5.9.1 \
psutil=5.4.7 \
psygnal=0.3.5 \
ptyprocess=0.6.0 \
ptyprocess=0.7.0 \
py=1.6.0 \
pyasn1=0.4.4 \
pyasn1-modules=0.2.2 \
pycodestyle=2.4.0 \
pycosat=0.6.3 \
pycparser=2.18 \
pycrypto=2.6.1 \
pycurl=7.43.0.2 \
pydantic=1.9.1 \
pyflakes=2.0.0 \
pygments=2.2.0 \
Pygments=2.12.0 \
pylint=2.1.1 \
pyodbc=4.0.24 \
PyOpenGL=3.1.6 \
pyopenssl=18.0.0 \
pyparsing=2.2.0 \
pyparsing=3.0.9 \
pyqt=5.9.2 \
pyrsistent=0.18.1 \
pysocks=1.6.8 \
pytables=3.4.4 \
pytest=3.8.0 \
pytest-arraydiff=0.2 \
pytest-astropy=0.4.0 \
pytest-doctestplus=0.1.3 \
pytest-openfiles=0.3.0 \
pytest-remotedata=0.3.0 \
python=3.7.13 \
python-dateutil=2.8.2 \
python-dateutil=2.7.3 \
pytomlpp=1.0.11 \
pytz=2018.5 \
pywavelets=1.0.0 \
PyWavelets=1.3.0 \
pyyaml=3.13 \
PyYAML=6.0 \
pyzmq=23.2.0 \
pyzmq=17.1.2 \
qt=5.9.6 \
qtawesome=0.4.4 \
qtconsole=5.3.1 \
qtconsole=4.4.1 \
QtPy=2.1.0 \
qtpy=1.5.0 \
ray=1.13.0 \
readline=8.1.2 \
requests=2.19.1 \
retrying=1.3.3 \
rope=0.11.0 \
rsa=4.8 \
ruamel_yaml=0.15.46 \
scikit-image=0.19.3 \
scikit-image=0.14.0 \
scikit-learn=0.19.2 \
scipy=1.2.0 \
scipy=1.7.3 \
seaborn=0.9.0 \
secretstorage=3.1.0 \
send2trash=1.5.0 \
service_identity=17.0.0 \
setuptools=62.6.0 \
setuptools=61.2.0 \
simplegeneric=0.8.1 \
singledispatch=3.4.0.3 \
sip=4.19.8 \
six=1.16.0 \
slicerator=1.1.0 \
snappy=1.1.7 \
snowballstemmer=1.2.1 \
sortedcollections=1.0.1 \
sortedcontainers=2.0.5 \
sphinx=1.7.9 \
Sphinx=5.0.2 \
sphinxcontrib=1.0 \
sphinxcontrib-applehelp=1.0.2 \
sphinxcontrib-devhelp=1.0.2 \
sphinxcontrib-htmlhelp=2.0.0 \
sphinxcontrib-jsmath=1.0.1 \
sphinxcontrib-qthelp=1.0.3 \
sphinxcontrib-serializinghtml=1.1.5 \
sphinxcontrib-websupport=1.1.0 \
spyder=3.3.1 \
spyder-kernels=0.2.6 \
sqlalchemy=1.2.11 \
sqlite=3.38.5 \
sqlparse=0.4.2 \
statsmodels=0.9.0 \
superqt=0.3.2 \
sympy=1.2 \
tblib=1.3.2 \
tenacity=8.0.1 \
terminado=0.8.1 \
testpath=0.3.1 \
tifffile=2021.11.2 \
tinycss2=1.1.1 \
tk=8.6.12 \
toolz=0.11.2 \
toolz=0.9.0 \
tornado=5.1 \
tornado=5.1.1 \
tqdm=4.64.0 \
tqdm=4.26.0 \
traitlets=5.3.0 \
traitlets=4.3.2 \
twisted=18.7.0 \
typer=0.4.1 \
typing_extensions=4.2.0 \
unicodecsv=0.14.1 \
unixodbc=2.3.7 \
urllib3=1.23 \
virtualenv=20.14.1 \
vispy=0.10.0 \
wcwidth=0.1.7 \
wcwidth=0.2.5 \
webcolors=1.12 \
webencodings=0.5.1 \
werkzeug=0.14.1 \
wheel=0.37.1 \
widgetsnbextension=3.4.1 \
wrapt=1.14.1 \
wrapt=1.10.11 \
xlrd=1.1.0 \
xlsxwriter=1.1.0 \
xlwt=1.3.0 \
xz=5.2.5 \
yaml=0.1.7 \
zeromq=4.2.5 \
zict=0.1.3 \
zipp=3.8.0 \
zlib=1.2.12 \
zope=1.0 \
zope.interface=4.5.0 

# RUN conda install --yes aiosignal \
# alabaster \
# anaconda-client \
# anaconda-navigator \
# anaconda-project \
# appdirs \
# asgiref \
# asn1crypto \
# astroid \
# astropy \
# atomicwrites \
# attrs \
# Automat \
# Babel \
# backcall \
# beautifulsoup4 \
# bitarray \
# bkcharts \
# blaze \
# bleach \
# bokeh \
# boto \
# Bottleneck \
# cachetools \
# cffi \
# chardet \
# click \
# cloudpickle \
# clyent \
# colorama \
# conda \
# conda-build \
# constantly \
# contextlib2 \
# cryptography \
# cycler \
# Cython \
# cytoolz \
# dask \
# dask-image \
# datashape \
# debugpy \
# decorator \
# defusedxml \
# dill \
# distlib \
# distributed \
# Django \
# docutils \
# entrypoints \
# fastcache \
# fasteners \
# filelock \
# Flask \
# Flask-Cors \
# freetype-py \
# frozenlist \
# fsspec \
# gevent \
# glob2 \
# gmpy2 \
# google-auth \
# greenlet \
# grpcio \
# h5py \
# heapdict \
# hsluv \
# html5lib \
# hyperlink \
# idna \
# imageio \
# imagesize \
# importlib-metadata \
# incremental \
# ipykernel \
# ipython \
# ipython_genutils \
# ipywidgets \
# isort \
# itsdangerous \
# jdcal \
# jedi \
# jeepney \
# Jinja2 \
# jsonschema \
# jupyter \
# jupyterlab \
# keyring \
# kiwisolver \
# lazy-object-proxy \
# llvmlite \
# locket \
# lxml \
# MarkupSafe \
# matplotlib \
# matplotlib-inline \
# mccabe \
# mistune \
# mkl-service \
# more-itertools \
# mpmath \
# multipledispatch \
# natsort \
# navigator-updater \
# nbclient \
# nbconvert \
# nbformat \
# nest-asyncio \
# networkx \
# nltk \
# nose \
# notebook \
# numba \
# numexpr \
# numpy \
# numpydoc \
# odo \
# olefile \
# openpyxl \
# packaging \
# pandas \
# pandocfilters \
# parso \
# partd \
# path.py \
# pathlib2 \
# patsy \
# pep8 \
# pexpect \
# pickleshare \
# Pillow \
# PIMS \
# pkginfo \
# platformdirs \
# plotly \
# pluggy \
# ply \
# prompt-toolkit \
# protobuf \
# psutil \
# ptyprocess \
# py \
# pyasn1 \
# pyasn1-modules \
# pycodestyle \
# pycosat \
# pycparser \
# pycrypto \
# pycurl \
# pydantic \
# pyflakes \
# Pygments \
# pylint \
# pyodbc \
# PyOpenGL \
# pyOpenSSL \
# pyparsing \
# pyrsistent \
# PySocks \
# pytest \
# pytest-arraydiff \
# pytest-astropy \
# pytest-doctestplus \
# pytest-openfiles \
# pytest-remotedata \
# python-dateutil \
# pytz \
# PyWavelets \
# PyYAML \
# pyzmq \
# QtAwesome \
# qtconsole \
# QtPy \
# requests \
# retrying \
# rope \
# rsa \
# ruamel_yaml \
# scikit-image \
# scikit-learn \
# scipy \
# seaborn \
# SecretStorage \
# Send2Trash \
# simplegeneric \
# singledispatch \
# slicerator \
# snowballstemmer \
# sortedcollections \
# sortedcontainers \
# Sphinx \
# sphinxcontrib-applehelp \
# sphinxcontrib-devhelp \
# sphinxcontrib-htmlhelp \
# sphinxcontrib-jsmath \
# sphinxcontrib-qthelp \
# sphinxcontrib-serializinghtml \
# sphinxcontrib-websupport \
# spyder \
# spyder-kernels \
# SQLAlchemy \
# sqlparse \
# statsmodels \
# sympy \
# tblib \
# tenacity \
# terminado \
# testpath \
# tifffile \
# toolz \
# tornado \
# tqdm \
# traitlets \
# Twisted \
# typer \
# typing_extensions \
# unicodecsv \
# urllib3 \
# virtualenv \
# vispy \
# wcwidth \
# webencodings \
# Werkzeug \
# widgetsnbextension \
# wrapt \
# xlrd \
# XlsxWriter \
# xlwt \
# zict \
# zipp \
# zope.interface 
# Install Jupyter notebook to allow for more interactive neuroglancing
RUN conda install --yes -c conda-forge notebook \
    && conda clean -a
    
# RUN pip install jupyterlab-pygments \
#     docstring-parser \
#     nibabel \
#     webcolors \
#     napari-plugin-engine \
#     antspyx \
#     napari-console \
#     tables \
#     pytomlpp \
#     Pint \
#     jupyter-console \
#     psygnal \
#     importlib-resources \
#     msgpack \
#     magicgui \
#     et-xmlfile \
#     ray \
#     httplib2 \
#     prometheus-client \
#     mkl-fft \
#     cachey \
#     chart-studio \
#     npe2 \
#     jupyter-client \
#     tinycss2 \
#     oauth2client \
#     service-identity \
#     napari-svg \
#     backports.shutil-get-terminal-size \
#     jupyterlab-launcher \
#     mkl-random \
#     napari \
#     google-apitools \
#     jupyter-core \
#     fastjsonschema 

# install neuroglancer from github
RUN git clone https://github.com/google/neuroglancer.git
WORKDIR neuroglancer
RUN git reset --hard 342d1bb
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
