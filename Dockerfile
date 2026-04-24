FROM ubuntu:26.04
LABEL maintainer="Julian Nonino <noninojulian@gmail.com>"

ENV TZ=Europe/London

# renovate: datasource=ubuntu-package suite=resolute depName=texlive-full
ENV TEXLIVE_VERSION="2025.20260124-1"

# renovate: datasource=ubuntu-package suite=resolute depName=latexmk
ENV LATEXMK_VERSION="1:4.87~ds-1"

# renovate: datasource=ubuntu-package suite=resolute depName=biber
ENV BIBER_VERSION="2.21-2"

# renovate: datasource=ubuntu-package suite=resolute depName=chktex
ENV CHKTEX_VERSION="1.7.9-2"

ENV TEXCOUNT_VERSION="3_2_0_41"

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt update && \
    apt install -y curl wget git make tzdata && \
    curl -1sLf 'https://dl.cloudsmith.io/public/task/task/setup.deb.sh' | bash && \
    apt update && \
    apt install -y task && \
    apt install -y texlive-full=${TEXLIVE_VERSION}* latexmk=${LATEXMK_VERSION}* biber=${BIBER_VERSION}* && \
    apt install -y chktex=${CHKTEX_VERSION} && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -fsSL "https://app.uio.no/ifi/texcount/download.php?file=texcount_$TEXCOUNT_VERSION.zip" -o texcount.zip && \
    unzip texcount.zip && \
    rm texcount.zip Doc -rf && \
    mv texcount.pl /usr/bin/texcount && \
    chmod +x /usr/bin/texcount
