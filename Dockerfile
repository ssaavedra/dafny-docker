FROM alpine AS unzipper

WORKDIR /opt

RUN apk add -U curl unzip
RUN curl -L https://github.com/Microsoft/dafny/releases/download/v2.3.0/dafny-2.3.0.10506-x64-ubuntu-14.04.zip -o /opt/dafny.zip \
&& (cd /opt && unzip dafny.zip && rm dafny.zip)

FROM mono:5

RUN apt update && apt install -qy libgomp1 && rm -rf /var/lib/apt/lists/*

COPY --from=0 /opt/dafny /opt/dafny

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/dafny:/opt/dafny/z3/bin

