#!/bin/bash
# 保護対象ファイルのリスト
PROTECTED_FILES="index.html CLAUDE.md"

# stdinからJSON入力を読み取る
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path":"[^"]*"' | head -1 | cut -d'"' -f4)

if [ -z "$FILE_PATH" ]; then
  FILE_PATH=$(echo "$INPUT" | grep -o '"path":"[^"]*"' | head -1 | cut -d'"' -f4)
fi

FILENAME=$(basename "$FILE_PATH" 2>/dev/null)

for PROTECTED in $PROTECTED_FILES; do
  if [ "$FILENAME" = "$PROTECTED" ]; then
    echo "BLOCKED: $FILENAME は保護対象です。別のファイル名で作成してください。" >&2
    exit 2
  fi
done

exit 0
