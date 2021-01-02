ARG VERSION=${VERSION:-3.8.0}

FROM hillliu/django-slim as builder

ARG VERSION

RUN echo Pre Python Version: ${VERSION}

FROM python:${VERSION}-slim as app

COPY --from=builder /root/site /root/site

