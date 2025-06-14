FROM opensuse/tumbleweed:latest AS base

ARG KUBECTL_VERSION
RUN zypper install --no-confirm gawk && \
    curl -L https://dl.k8s.io/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl -o /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl && \
    rpm -e --allmatches $(rpm -qa --qf "%{NAME}\n" | grep -v -E "bash|coreutils|filesystem|glibc$|libacl1|libattr1|libcap2|libgcc_s1|libgmp|libncurses|libpcre|libreadline|libselinux|libstdc\+\+|openSUSE-release|system-user-root|terminfo-base|gawk|libmpfr|grep") && \
    rm -Rf /etc/zypp && \
    rm -Rf /usr/lib/zypp* && \
    rm -Rf /var/{cache,log,run}/* && \
    rm -Rf /var/lib/zypp && \
    rm -Rf /usr/lib/rpm && \
    rm -Rf /usr/lib/sysimage/rpm && \
    rm -Rf /usr/share/man && \
    rm -Rf /usr/local && \
    rm -Rf /srv/www && \
    rm -Rf /tmp/*

FROM scratch

COPY --from=base / /

CMD ["/bin/bash"]
