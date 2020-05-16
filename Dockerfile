ARG image_tag
FROM ${image_tag}

ARG SMB_SHARE
ARG SMB_USERNAME
ARG SMB_PASSWORD

WORKDIR /app

COPY . .

RUN .profile.bat