FROM python:3.9.12-slim

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Asia/Shanghai
ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8
ENV TZ Asia/Shanghai

WORKDIR /app

COPY ["requirements.txt","zx-cli","bot.tar.gz","/app/"]

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo 'Asia/Shanghai' >/etc/timezone \
	&& apt-get update --fix-missing -o Acquire::http::No-Cache=True \
	&& apt-get install -y --assume-yes apt-utils --no-install-recommends \
	build-essential \
	libgl1 \
	libglib2.0-0 \
	libnss3 \
	libatk1.0-0 \
	libatk-bridge2.0-0 \
	libcups2 \
	libxkbcommon0 \
	libxcomposite1 \
	libxrandr2 \
	libgbm1 \
	libgtk-3-0 \
	libasound2 \
	locales \
	locales-all \
	fonts-noto \
	libnss3-dev \
	libxss1 \
	libasound2 \
	libxrandr2 \
	libatk1.0-0 \
	libgtk-3-0 \
	libgbm-dev \
	libxshmfence1 \
    libenchant1c2a \
    libjpeg-turbo8 \
    ttf-ubuntu-font-family \
    libjpeg-turbo8 \
    && pip install -r requirements.txt --no-cache-dir

CMD ["./zx-cli","-mode","docker"]
