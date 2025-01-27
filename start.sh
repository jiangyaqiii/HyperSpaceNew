#!/bin/bash

# 脚本保存路径
SCRIPT_PATH="$HOME/Hyperspace.sh"
echo "正在执行安装命令：curl https://download.hyper.space/api/install | bash"
curl https://download.hyper.space/api/install | bash
# 获取安装后新添加的路径
NEW_PATH=$(bash -c 'source /root/.bashrc && echo $PATH')
# 更新当前shell的PATH
export PATH="$NEW_PATH"
# 验证aios-cli是否可用
if ! command -v aios-cli &> /dev/null; then
    echo "aios-cli 命令未找到，正在重试..."
    sleep 3
    # 再次尝试更新PATH
    export PATH="$PATH:/root/.local/bin"
    if ! command -v aios-cli &> /dev/null; then
        echo "无法找到 aios-cli 命令，请手动运行 'source /root/.bashrc' 后重试"
        read -n 1 -s -r -p "按任意键返回主菜单..."
        return
    fi
fi
