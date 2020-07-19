FROM ubuntu:18.04

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y build-essential curl g++ gettext-base git libfreetype6-dev libpng-dev libsnappy-dev \
                       libssl-dev pkg-config python3-dev python3-pip software-properties-common supervisor nginx \
                       unzip zip zlib1g-dev openjdk-8-jdk tmux wget bzip2 libpcre3 libpcre3-dev vim systemd ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8

COPY ./requirements.txt /tmp/
RUN pip3 install -r /tmp/requirements.txt && \
    rm -rf /root/.cache /tmp/*

RUN pip3 install torch==1.4.0+cpu torchvision==0.5.0+cpu -f https://download.pytorch.org/whl/torch_stable.html && \
    rm -rf /root/.cache /tmp/*

COPY . /app

RUN /app/install_fairseq.sh && \
    rm -rf /root/.cache /tmp/*

COPY nginx.conf /etc/nginx/
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /var/log/uwsgi

# ========= setup uwsgi
RUN touch /app/wsgi.sock
RUN chmod 666 /app/wsgi.sock

WORKDIR /app

CMD ["bash", "entrypoint.sh"]

EXPOSE 8002
