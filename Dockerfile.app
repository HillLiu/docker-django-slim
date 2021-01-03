ARG VERSION=${VERSION:-3.8.0}

FROM hillliu/django-slim as builder

ARG VERSION

RUN echo Pre Python Version: ${VERSION}

FROM python:${VERSION}-slim as app

RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
      sqlite3 && \
    apt-get clean autoclean && \
    apt-get autoremove --yes
    
COPY --from=builder /root/site /root/site
ENV PATH=/root/site/bin:$PATH

RUN rm -rf /var/lib/apt && rm -rf /var/lib/dpkg && rm -rf /var/lib/cache
