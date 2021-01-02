FROM python:3.7-alpine

ARG PIP3="/root/site/bin/pip3"
ARG OPENCV_VERSION=${OPENCV_VERSION:-4.5.1}

# Add Edge repos
RUN echo -e "\n\
http://nl.alpinelinux.org/alpine/edge/testing"\
  >> /etc/apk/repositories

RUN apk update && \
    apk add --virtual .build-deps \
    build-base \
    curl \
    make \
    cmake \
    clang \
    linux-headers \
    musl \
    libtbb \
    autoconf \
    g++ \
    gcc

RUN mkdir -p /tmp/opencv && \
    curl -Lk "https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.tar.gz" | \
    tar -xz -C /tmp/opencv --strip-components=1

RUN mkdir -p /tmp/opencv_contrib && \
    curl -Lk "https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.tar.gz" | \
    tar -xz -C /tmp/opencv_contrib --strip-components=1


RUN apk add \
      postgresql-client \
      postgresql-dev \
      bash \
      gfortran \
      clang-dev \
      libtbb-dev \
      gettext \
      gettext-dev \
      freetype-dev \
      openblas-dev \
      musl-dev \
      clang-dev \
      libffi-dev \
      libpng-dev \
      jpeg-dev \
      zlib-dev

RUN python3.7 -m venv /root/site
RUN ${PIP3} install -U pip
RUN ${PIP3} install \
  django \
  django-webpack-loader \
  django-cors-headers \
  django-environ \
  requests \
  gunicorn \
  whitenoise \
  numpy \
  pandas \
  Pillow \
  grpcio
 
RUN cd /tmp/opencv && mkdir build && cd build && \
  cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_C_COMPILER=/usr/bin/clang \
    -D CMAKE_CXX_COMPILER=/usr/bin/clang++ \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D INSTALL_C_EXAMPLES=OFF \
    -D WITH_FFMPEG=ON \
    -D WITH_TBB=ON \
    -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib/modules \
    -D PYTHON_EXECUTABLE=/usr/local/bin/python \
    .. && \
    make -j$(nproc) && make install

RUN rm /tmp/opencv -rf && \
    rm /tmp/opencv_contrib -rf && \
    apk del .build-deps

