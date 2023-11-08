#!/bin/bash

export CARGO_HTTP_CAINFO="/Users/arthurrodrigues/.proxyman/proxyman-ca.pem"
export CGI_HTTP_PROXY="http://127.0.0.1:9090"
export CURL_CA_BUNDLE="/Users/arthurrodrigues/.proxyman/proxyman-ca.pem"
export GIT_SSL_CAINFO="/Users/arthurrodrigues/.proxyman/proxyman-ca.pem"
export GLOBAL_AGENT_HTTP_PROXY="http://127.0.0.1:9090"
export HTTPS_PROXY="http://127.0.0.1:9090"
export HTTP_PROXY="http://127.0.0.1:9090"
export NODE_EXTRA_CA_CERTS="/Users/arthurrodrigues/.proxyman/proxyman-ca.pem"
export NODE_OPTIONS="--require \"/Applications/Setapp/Proxyman.app/Contents/Frameworks/ProxymanCore.framework/Versions/A/Resources/overrides/js/js.min.js\""
export PATH="/Applications/Setapp/Proxyman.app/Contents/Frameworks/ProxymanCore.framework/Versions/A/Resources/overrides/path:$PATH"
export PERL_LWP_SSL_CA_FILE="/Users/arthurrodrigues/.proxyman/proxyman-ca.pem"
export PROXYMAN_INJECTION_ACTIVE=true
export PROXYMAN_INJECTION_OVERRIDE_PATH="/Applications/Setapp/Proxyman.app/Contents/Frameworks/ProxymanCore.framework/Versions/A/Resources/overrides"
export PYTHONPATH="/Applications/Setapp/Proxyman.app/Contents/Frameworks/ProxymanCore.framework/Versions/A/Resources/overrides/python"
export REQUESTS_CA_BUNDLE="/Users/arthurrodrigues/.proxyman/proxyman-ca.pem"
export RUBYLIB="/Applications/Setapp/Proxyman.app/Contents/Frameworks/ProxymanCore.framework/Versions/A/Resources/overrides/ruby"
export SPACESHIP_PROXY="http://127.0.0.1:9090"
export SPACESHIP_PROXY_SSL_VERIFY_NONE=1
export SSL_CERT_FILE="/Users/arthurrodrigues/.proxyman/proxyman-ca.pem"
export http_proxy="http://127.0.0.1:9090"
export https_proxy="http://127.0.0.1:9090"
export npm_config_https_proxy="http://127.0.0.1:9090"
export npm_config_proxy="http://127.0.0.1:9090"
export npm_config_scripts_prepend_node_path=false
clear

echo "----------------------------------------------"
echo "------PROXYMAN AUTOMATIC SETUP SCRIPTS--------"
echo "----------------------------------------------"
echo "⭐️ Auto capture HTTP/HTTPS traffic from this Terminal app."
echo "Support NodeJS: (axios, fetch, got, request, superagent)"
echo "Support Ruby: (http, net/http, net/https)"
echo "Support Python: (http, httplib, httplib2)"
echo ""
echo "✅ Injected Proxyman variable environments to current shell"
echo ""
echo "👉 Please start your local server or run your script from this Terminal."