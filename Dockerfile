# FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm
FROM ghcr.io/linuxserver/chromium:amd64-latest

# 安裝 locales 來支援多國語言
RUN apt-get update && apt-get install -y locales \
    && sed -i '/zh_TW.UTF-8/s/^# //g' /etc/locale.gen \
    && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
    && sed -i '/ja_JP.UTF-8/s/^# //g' /etc/locale.gen \
    && sed -i '/ko_KR.UTF-8/s/^# //g' /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=zh_TW.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# 設定環境變數，預設為繁體中文
ENV LANG=zh_TW.UTF-8 \
    LANGUAGE=zh_TW:zh \
    LC_ALL=zh_TW.UTF-8

# 安裝常見字型來顯示多國語言
RUN apt-get update && apt-get install -y \
    fonts-noto-cjk fonts-noto-color-emoji fonts-noto \
    ttf-wqy-zenhei ttf-wqy-microhei \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://downloads.k8slens.dev/keys/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/lens-archive-keyring.gpg > /dev/null && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/lens-archive-keyring.gpg] https://downloads.k8slens.dev/apt/debian stable main" | sudo tee /etc/apt/sources.list.d/lens.list > /dev/null && \
    sudo apt update && sudo apt install -y lens

COPY /root/defaults/autostart /root/defaults/autostart