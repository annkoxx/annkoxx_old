#!/bin/bash

#================================================================
# 文件名: setup_python_env.sh
# 描述: 自動檢測 Debian/Ubuntu 系統並安裝 Python 3 環境
# 作者: Gemini
#================================================================

# 設置顏色變量，讓輸出更美觀
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 腳本核心設定：如果任何命令執行失敗，則立即退出
set -e

#--- 函數定義 ---

# 適用於 Debian 和 Ubuntu 的 Python 安裝函數
install_python_on_debian_family() {
    echo -e "\n${GREEN}---> 步驟 1/3: 更新並升級系統套件...${NC}"
    sudo apt update
    sudo apt upgrade -y

    echo -e "\n${GREEN}---> 步驟 2/3: 安裝 python3, python3-pip, 和 python3-venv...${NC}"
    sudo apt install -y python3 python3-pip python3-venv

    echo -e "\n${GREEN}---> 步驟 3/3: 驗證安裝版本...${NC}"
    # 將版本信息保存到變量中，以備後用
    PY_VERSION=$(python3 --version)
    PIP_VERSION=$(pip3 --version)
}

#--- 主邏輯開始 ---

echo -e "${GREEN}--- 通用 Python 3 環境安裝腳本 (適用於 Debian/Ubuntu) ---${NC}"

# 檢查 /etc/os-release 文件是否存在，這是確定 Linux 發行版的標準方法
if [ -f /etc/os-release ]; then
    # . (點) 命令等同於 source，它會讀取文件並將其變量導入到當前 shell 環境
    . /etc/os-release
else
    echo -e "${RED}錯誤: 無法找到 /etc/os-release 文件，無法確定作業系統。${NC}"
    exit 1
fi

echo -e "\n正在檢測作業系統..."

# 使用 case 語句判斷 ID 變量的值
case "$ID" in
    ubuntu|debian)
        # 如果 ID 是 "ubuntu" 或 "debian"，則執行安裝
        echo -e "檢測到兼容的系統: ${GREEN}${PRETTY_NAME}${NC}"
        echo "準備開始安裝流程..."
        install_python_on_debian_family
        ;;
    *)
        # 如果是任何其他系統，則顯示錯誤信息並退出
        echo -e "${RED}錯誤: 此腳本僅為 Debian 和 Ubuntu 系列系統設計。${NC}"
        echo "檢測到的系統是: $PRETTY_NAME"
        exit 1
        ;;
esac

#--- 成功信息 ---
echo -e "\n========================================================="
echo -e "${GREEN}✅ 在 ${PRETTY_NAME} 上成功安裝 Python 環境！${NC}"
echo "---------------------------------------------------------"
echo -e "Python 版本: ${GREEN}$PY_VERSION${NC}"
echo -e "pip 版本:    ${GREEN}$PIP_VERSION${NC}"
echo "========================================================="
echo -e "\n下一步建議:"
echo "1. 建立一個專案目錄: mkdir my_project && cd my_project"
echo "2. 在目錄中建立虛擬環境: python3 -m venv venv"
echo "3. 啟用虛擬環境: source venv/bin/activate"
echo "4. 在虛擬環境中安裝套件: pip install <package_name>"
echo -e "\n--- 腳本執行完畢 ---"
