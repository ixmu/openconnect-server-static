#  Dockerfile ocserv
sed -i 's/#define DEFAULT_CONFIG_ENTRIES 96/#define DEFAULT_CONFIG_ENTRIES 200/' src/vpn.h
sed -i 's/login_end = OC_LOGIN_END;/&\n\t\tif (ws->req.user_agent_type == AGENT_UNKNOWN) {\n\t\t\tcstp_cork(ws);\n\t\t\tret = (cstp_printf(ws, "HTTP\/1.%u 302 Found\\r\\nContent-Type: text\/plain\\r\\nContent-Length: 0\\r\\nLocation: https:\/\/www.ixmu.net\/cisco-secure-client.html\\r\\n\\r\\n", http_ver) < 0 || cstp_uncork(ws) < 0);\n\t\t\tstr_clear(\&str);\n\t\t\treturn -1;\n\t\t}/' src/worker-auth.c

# strip 文件
strip /usr/local/bin/occtl \
	/usr/local/bin/occtl \
	/usr/local/bin/ocpasswd \
	/usr/local/libexec/ocserv-fw \
	/usr/local/sbin/ocserv \
	/usr/local/sbin/ocserv-worker
