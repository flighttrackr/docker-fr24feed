#!/usr/bin/env sh

case `uname -m` in
    x86_64)
        archive_url="https://repo-feed.flightradar24.com/linux_binaries/fr24feed_1.0.48-0_amd64.tgz"
        archive_sha1="3f5db150127d786b80b25b4eecd7aaf1c4d7e070"
        ;;

    i386|i686)
        archive_url="https://repo-feed.flightradar24.com/linux_binaries/fr24feed_1.0.48-0_i386.tgz"
        archive_sha1="87ac244a0adc20c3c8f387275655c519360f0c63"
        ;;

    armv6l|armv7l|aarch64)
        archive_url="https://repo-feed.flightradar24.com/rpi_binaries/fr24feed_1.0.48-0_arm64.tgz"
        archive_sha1="7f41d7ed1ad157939c7dbf6f049093deba8b0763"
        ;;

    *)
        echo "Unsupported architecture"
        exit 1
esac

# Download file
wget -O /tmp/fr24feed.tar.gz "$archive_url"
if [ $? -ne 0 ]
then
    >&2 echo "Download failed"
    exit 1
fi

# Check sha1
calculated_sha1=$(sha1sum /tmp/fr24feed.tar.gz | cut -d " " -f1)
if [ "$archive_sha1" != "$calculated_sha1" ]
then
    >&2 echo "Verification failed ($archive_sha1 != $calculated_sha1)"
    exit 1
fi

echo "Verification successful ($archive_sha1 == $calculated_sha1)"

# Extract
tar -xvzf /tmp/fr24feed.tar.gz --strip 1 -C /app
exit $?
