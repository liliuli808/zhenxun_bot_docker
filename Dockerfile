FROM python:3.9.12-slim

ENV TZ=Asia/Shanghai
ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8
ENV TZ Asia/Shanghai
ENV DEBIAN_FRONTEND noninteractive

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
	&& pip install -r requirements.txt --no-cache-dir

RUN apt update && apt install -y libzbar0 locales locales-all fonts-noto

RUN apt-get install -y libnss3-dev libxss1 libasound2 libxrandr2\
  libatk1.0-0 libgtk-3-0 libgbm-dev libxshmfence1

RUN pip3 install Jinja2

RUN pip3 install markdown

CMD ["./zx-cli","-mode","docker"]
