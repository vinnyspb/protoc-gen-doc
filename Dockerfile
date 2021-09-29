FROM debian:stable-slim
LABEL maintainer="pseudomuto <david.muto@gmail.com>" protoc_version="3.18.0"

WORKDIR /

ADD https://github.com/protocolbuffers/protobuf/releases/download/v3.18.0/protoc-3.18.0-linux-x86_64.zip ./
ADD https://github.com/pseudomuto/protoc-gen-doc/releases/download/v1.5.0/protoc-gen-doc-1.5.0.linux-amd64.go1.16.6.tar.gz ./
RUN apt-get -q -y update && \
  apt-get -q -y install unzip && \
  unzip protoc-3.18.0-linux-x86_64.zip -d ./usr/local && \
  tar -xzf protoc-gen-doc-1.5.0.linux-amd64.go1.16.6.tar.gz --directory ./usr/local/bin --strip-components=1 && \
  chmod +x ./usr/local/bin/protoc-gen-doc && \
  rm protoc-3.18.0-linux-x86_64.zip && \
  apt-get remove --purge -y unzip && \
  apt-get autoremove && \
  rm -rf /var/lib/apt/lists/*

ADD script/entrypoint.sh ./

VOLUME ["/out", "/protos"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--doc_opt=html,index.html"]
