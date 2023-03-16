#!/usr/bin/env sh

case `uname -m` in
    x86_64)
        archive_url="https://repo-feed.flightradar24.com/linux_x86_64_binaries/fr24feed_1.0.34-0_amd64.tgz"
        archive_md5="9a407411846eaf104946dac1355c723d"
        ;;

    i386|i686)
        archive_url="https://repo-feed.flightradar24.com/linux_x86_binaries/fr24feed_1.0.34-0_i386.tgz"
        archive_md5="68f74f624ec60d63016df554682aeb8e"
        ;;

    armv6l|armv7l|aarch64)
        archive_url="https://repo-feed.flightradar24.com/rpi_binaries/fr24feed_1.0.34-0_armhf.tgz"
        archive_md5="08dd87fca7eeede316932dbacc22a417"
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

# Check md5
calculated_md5=$(md5sum /tmp/fr24feed.tar.gz | cut -d " " -f1)
if [ "$archive_md5" != "$calculated_md5" ]
then
    >&2 echo "Verification failed ($archive_md5 != $calculated_md5)"
    exit 1
fi

echo "Verification successful ($archive_md5 == $calculated_md5)"

# Extract
tar -xvzf /tmp/fr24feed.tar.gz --strip 1 -C /app
exit $?
