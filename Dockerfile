FROM alpine:3.8

RUN apk --no-cache add jq curl

COPY /bin/discord /bin/discord
