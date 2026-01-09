#  Dockerfile ocserv

```
# 调优配置上限：将默认配置条目从 96 增加到 200，以支持更复杂的策略配置。
sed -i 's/#define DEFAULT_CONFIG_ENTRIES 96/#define DEFAULT_CONFIG_ENTRIES 200/' src/vpn.h
# 全防御/引导：在 worker-auth.c 中加入逻辑，当检测到“未知客户端（AGENT_UNKNOWN）”时，强制 302 重定向到特定的说明页面，从而屏蔽非法扫描或引导用户下载正确的客户端。
sed -i 's/login_end = OC_LOGIN_END;/&\n\t\tif (ws->req.user_agent_type == AGENT_UNKNOWN) {\n\t\t\tcstp_cork(ws);\n\t\t\tret = (cstp_printf(ws, "HTTP\/1.%u 302 Found\\r\\nContent-Type: text\/plain\\r\\nContent-Length: 0\\r\\nLocation: https:\/\/www.ixmu.net\/cisco-secure-client.html\\r\\n\\r\\n", http_ver) < 0 || cstp_uncork(ws) < 0);\n\t\t\tstr_clear(\&str);\n\t\t\treturn -1;\n\t\t}/' src/worker-auth.c
```
# 下载文件
```
wget -O /tmp/ocserv.tar.xz https://github.com/ixmu/openconnect-server-static/releases/download/v1.2.4/openconnect-server-linux-amd64.tar.xz
tar -xf /tmp/ocserv.tar.xz -C /usr/local
```
