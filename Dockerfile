FROM alpine:3 

RUN ["/bin/sh", "-c", "apk add --update --no-cache bash ca-certificates curl git jq openssh"]

WORKDIR /tmp

# Install Azure Kubelogin
RUN wget https://github.com/Azure/kubelogin/releases/download/v0.0.26/kubelogin-linux-amd64.zip
RUN unzip kubelogin-linux-amd64.zip
RUN cp bin/linux_amd64/kubelogin /usr/local/bin/
RUN rm -rf bin

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod 755 kubectl
RUN mv kubectl /usr/local/bin/

WORKDIR /

COPY ["src", "/src/"]

ENTRYPOINT ["/src/main.sh"]

