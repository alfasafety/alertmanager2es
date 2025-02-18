FROM golang:1.15 as build

WORKDIR /go/src/github.com/alfasafety/alertmanager2es

COPY ./Makefile /go/src/github.com/alfasafety/alertmanager2es@latest

# Compile
COPY ./ /go/src/github.com/alfasafety/alertmanager2es
RUN make test
RUN make build
RUN ./alertmanager2es -help

#############################################
# FINAL IMAGE
#############################################
FROM quay.io/prometheus/busybox:latest
COPY --from=build /go/src/github.com/alfasafety/alertmanager2es/alertmanager2es /

EXPOSE 9097

ENTRYPOINT ["/alertmanager2es"]
