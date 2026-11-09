#!/bin/bash

LABEL="ru.freedeepseekapi.npm_start"
PLIST_PATH="$HOME/Library/LaunchAgents/${LABEL}.plist"

echo "plutil check"
plutil "$PLIST_PATH"

echo "Exclude from quarantine"
xattr -d com.apple.quarantine "$PLIST_PATH"
xattr -d com.apple.quarantine npm_start.sh

echo "Stopping & Booting out"
# Убиваем процесс и выгружаем старую конфигурацию
launchctl kickstart -k gui/$(id -u)/$LABEL 2>/dev/null
launchctl bootout gui/$(id -u) "$PLIST_PATH" 2>/dev/null

echo "Fixing permissions & ownership"
# Файл должен принадлежать текущему пользователю и иметь права 644
chown $(whoami) "$PLIST_PATH"
chmod 644 "$PLIST_PATH"

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
NPM_START_SCRIPT_PATH="$SCRIPT_DIR/npm_start.sh"

echo "npm start script path: $NPM_START_SCRIPT_PATH"
chmod +x "$NPM_START_SCRIPT_PATH"

# import to get API_PATH
source "$SCRIPT_DIR/env.sh"

# fix error when running `npm run doctor` - "permissions too open: 644" after export from extension 
# https://github.com/ForgetMeAI/FreeDeepseekAPI/tree/main/chrome-extension
echo "FreeDeepseekAPI path: $API_PATH"
find "$API_PATH" -type f -name "deepseek-auth*.json" -exec chmod 600 {} +

echo "Launching"
# Загружаем заново
launchctl bootstrap gui/$(id -u) "$PLIST_PATH"

echo "Verification"
# Проверяем статус. В выгрузке print имя сервиса будет содержать ваш LABEL
launchctl print gui/$(id -u)/$LABEL >/dev/null Co2>&1 && echo "Status: RUNNING" || echo "Status: NOT RUNNING"
