#!/usr/bin/env bash
set -euo pipefail

URL="https://github.com/annkoxx/annkoxx_old/raw/refs/heads/main/win/docker-compose.yml"
DEST_DIR="/home/ubuntu"
DEST_FILE="${DEST_DIR}/docker-compose.yml"

# 1) 下载文件到 /home/ubuntu
mkdir -p "$DEST_DIR"

if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$URL" -o "$DEST_FILE"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "$DEST_FILE" "$URL"
else
  echo "错误：系统里没有 curl 或 wget，无法下载文件。" >&2
  exit 1
fi

echo "已下载到：$DEST_FILE"

# 2) 询问并修改 CPU_CORES
while true; do
  read -r -p '请输入 CPU_CORES（例如 6）：' CPU
  CPU="${CPU//[[:space:]]/}"
  if [[ "$CPU" =~ ^[0-9]+$ ]]; then
    break
  fi
  echo "输入无效：只能输入数字，例如 6、8、12。"
done

# 3) 询问并修改 RAM_SIZE（要求带 G；你不带也行，会自动补）
while true; do
  read -r -p '请输入 RAM_SIZE（例如 12 或 12G）：' RAM
  RAM="${RAM//[[:space:]]/}"
  if [[ "$RAM" =~ ^[0-9]+([Gg])?$ ]]; then
    # 如果没带 G，就补上
    if [[ ! "$RAM" =~ [Gg]$ ]]; then
      RAM="${RAM}G"
    else
      # 统一成大写 G
      RAM="${RAM%[Gg]}G"
    fi
    break
  fi
  echo "输入无效：请输入类似 12 或 12G 这样的格式。"
done

# 4) 用 sed 定位替换对应行（保留缩进与格式）
# -E：扩展正则；兼容 GNU sed / BSD sed
# Linux 上是 GNU sed，直接 -i 即可
sed -i -E "s/^([[:space:]]*CPU_CORES:[[:space:]]*\")([0-9]+)(\"[[:space:]]*)$/\1${CPU}\3/" "$DEST_FILE"
sed -i -E "s/^([[:space:]]*RAM_SIZE:[[:space:]]*\")([0-9]+)(G)(\"[[:space:]]*)$/\1${RAM%G}G\4/" "$DEST_FILE"

echo "修改完成："
echo "  CPU_CORES -> \"$CPU\""
echo "  RAM_SIZE  -> \"$RAM\""
echo
echo "已更新文件：$DEST_FILE"
