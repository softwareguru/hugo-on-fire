FROM alpine

LABEL maintainer="Software Guru"

# Downloading & Installing Hugo & Firebase
RUN apk add --update nodejs npm hugo jq
RUN npm install -g firebase-tools

# Start the building & deploying now
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["sh", "/entrypoint.sh"]
