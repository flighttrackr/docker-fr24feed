# Builder
FROM alpine:3.21.3 AS builder

# Workdir
WORKDIR /app

# Copy downloader
COPY dl-fr24feed.sh /tmp/dl-fr24feed.sh

# Download fr24feed
RUN chmod +x /tmp/dl-fr24feed.sh && \
    /tmp/dl-fr24feed.sh


# Release
FROM alpine:3.21.3 AS release

# Packages
RUN apk add --no-cache bash sed libstdc++

# Workdir
WORKDIR /usr/lib/fr24

# Copy files
COPY --from=builder /app /usr/lib/fr24
COPY entrypoint.sh /entrypoint.sh
COPY fr24feed.ini /etc/fr24feed.ini

RUN chmod +x /entrypoint.sh /usr/lib/fr24/fr24feed
RUN chmod 644 /etc/fr24feed.ini

# ENV
ENV SHARING_KEY="" \
    DUMP1090_HOST="dump1090:30002" \
    RECEIVER="avr-tcp" \
    BS="no" \
    RAW="no" \
    LOGMODE="0" \
    WINDOWMODE="0" \
    MPX="no" \
    MLAT="yes" \
    MLAT_WITHOUT_GPS="yes"

# Expose
EXPOSE 8754

# Entrypoint
ENTRYPOINT [ "/entrypoint.sh" ]

# Command
CMD [ "/usr/lib/fr24/fr24feed" ]
