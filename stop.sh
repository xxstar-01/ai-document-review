#!/bin/bash
# ============================================================
# 🛑 AI Document Review - 停止服务脚本 (Linux/Mac)
# ============================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║        🛑 AI Document Review - 停止所有服务              ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${YELLOW}🔍 正在查找运行中的服务...${NC}"
echo ""

# 从 PID 文件停止进程
STOPPED=0

# 停止后端
echo -e "${CYAN}🔧 停止后端服务...${NC}"
if [ -f ".backend.pid" ]; then
    BACKEND_PID=$(cat .backend.pid)
    if kill -0 $BACKEND_PID 2>/dev/null; then
        kill $BACKEND_PID 2>/dev/null
        echo -e "${GREEN}   ✅ 后端服务已停止 (PID: $BACKEND_PID)${NC}"
        STOPPED=1
    else
        echo -e "${WHITE}   ⚪ 后端服务未运行${NC}"
    fi
    rm -f .backend.pid
else
    # 尝试通过端口查找
    BACKEND_PID=$(lsof -ti:8000 2>/dev/null)
    if [ -n "$BACKEND_PID" ]; then
        kill $BACKEND_PID 2>/dev/null
        echo -e "${GREEN}   ✅ 后端服务已停止 (PID: $BACKEND_PID)${NC}"
        STOPPED=1
    else
        echo -e "${WHITE}   ⚪ 后端服务未运行${NC}"
    fi
fi

# 停止前端
echo -e "${CYAN}🎨 停止前端服务...${NC}"
if [ -f ".frontend.pid" ]; then
    FRONTEND_PID=$(cat .frontend.pid)
    if kill -0 $FRONTEND_PID 2>/dev/null; then
        kill $FRONTEND_PID 2>/dev/null
        echo -e "${GREEN}   ✅ 前端服务已停止 (PID: $FRONTEND_PID)${NC}"
        STOPPED=1
    else
        echo -e "${WHITE}   ⚪ 前端服务未运行${NC}"
    fi
    rm -f .frontend.pid
else
    # 尝试通过端口查找
    FRONTEND_PID=$(lsof -ti:5173 2>/dev/null)
    if [ -n "$FRONTEND_PID" ]; then
        kill $FRONTEND_PID 2>/dev/null
        echo -e "${GREEN}   ✅ 前端服务已停止 (PID: $FRONTEND_PID)${NC}"
        STOPPED=1
    else
        echo -e "${WHITE}   ⚪ 前端服务未运行${NC}"
    fi
fi

# 清理可能残留的 uvicorn 进程
echo -e "${CYAN}🐍 清理残留进程...${NC}"
pkill -f "uvicorn main:app" 2>/dev/null && echo -e "${GREEN}   ✅ 清理 uvicorn 进程${NC}" || echo -e "${WHITE}   ⚪ 无残留 uvicorn 进程${NC}"

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ 所有服务已停止${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo ""

