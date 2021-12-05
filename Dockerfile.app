ARG VERSION=${VERSION:-[VERSION]}

FROM hillliu/django-slim as builder

ARG VERSION

FROM python:${VERSION}-slim as app

RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
      sqlite3 \
  && apt-get clean \
  && apt-get autoremove --yes \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/
    
COPY --from=builder /root/site /root/site
ENV PATH=/root/site/bin:$PATH
