FROM ubuntu:18.04

RUN sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list \
  && apt-get update && apt-get install -y \
  fontconfig \
  poppler-utils \
  python3 \
  python3-pip \
  unzip \
  wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && mv /etc/apt/sources.list.bak /etc/apt/sources.list

RUN mkdir ~/.fonts && cd ~/.fonts \
  && wget https://ipafont.ipa.go.jp/old/ipafont/IPAfont00303.php \
  && unzip IPAfont00303.php \
  && fc-cache -fv \
  && rm -f IPAfont00303.php

COPY ./.fonts.conf ~/

COPY ./requirements.txt .

RUN pip3 install -r requirements.txt

COPY ./p.py .
