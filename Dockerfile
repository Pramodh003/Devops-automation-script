FROM ubuntu:22.04



ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
     wget sudo curl jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip wget apt-transport-https gnupg unzip

RUN useradd -m docker && \
    mkdir /home/docker/actions-runner && \
    cd /home/docker/actions-runner && \
    wget  https://github.com/actions/runner/releases/download/v2.316.0/actions-runner-linux-x64-2.316.0.tar.gz && \
    tar xzf ./actions-runner-linux-x64-2.316.0.tar.gz -C /home/docker/actions-runner


RUN curl -fsSL https://baltocdn.com/helm/signing.asc | apt-key add - && \
    echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list

RUN wget -O /usr/local/bin/kubectl https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl

RUN wget https://get.helm.sh/helm-v3.7.0-linux-amd64.tar.gz && \
    tar -zxvf helm-v3.7.0-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/ && \
    rm -rf linux-amd64 helm-v3.7.0-linux-amd64.tar.gz

#RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
#    echo "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/vault.list

#RUN apt-get update && \
#    apt-get install -y vault helm gettext-base jq && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/*

#RUN setcap cap_ipc_lock= /usr/bin/vault

RUN curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 && \
    chmod +x /usr/local/bin/argocd

RUN curl https://cli-assets.heroku.com/install.sh | sh

RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && \
    chmod +x /usr/bin/yq

RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip && \
    unzip sonar-scanner-cli-5.0.1.3006-linux.zip -d /opt && \
    rm sonar-scanner-cli-5.0.1.3006-linux.zip && \
    mv /opt/sonar-scanner-5.0.1.3006-linux /opt/sonar-scanner && \
    ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner

RUN wget https://github.com/go-task/task/releases/download/v3.35.1/task_linux_amd64.tar.gz && \
    tar -zxvf task_linux_amd64.tar.gz -C /usr/local/bin/ && \
    rm task_linux_amd64.tar.gz

RUN wget https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip && \
    unzip terraform_1.7.5_linux_amd64.zip -d /usr/local/bin/ && \
    rm terraform_1.7.5_linux_amd64.zip

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

RUN chown -R docker /home/docker && \
    /home/docker/actions-runner/bin/installdependencies.sh

COPY start.sh /home/docker/start.sh

RUN chmod +x /home/docker/start.sh

USER docker

ENTRYPOINT ["/home/docker/start.sh"]
