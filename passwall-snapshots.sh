#!/bin/bash

# --- Color Codes ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m'  # No Color

# --- Update Packages ---
echo -e "${GREEN}Updating packages...${NC}"
opkg update
opkg install luci wget-ssl

# --- Add Custom Feed ---
wget -O passwall.pub https://master.dl.sourceforge.net/project/openwrt-passwall-build/passwall.pub
opkg-key add passwall.pub

# Determine architecture
arch=$(. /etc/openwrt_release; echo "$DISTRIB_ARCH")

# Construct the custom feed file
cat << EOF > /etc/opkg/customfeeds.conf
src/gz passwall_luci https://master.dl.sourceforge.net/project/openwrt-passwall-build/snapshots/packages/$arch/passwall_luci
src/gz passwall_packages https://master.dl.sourceforge.net/project/openwrt-passwall-build/snapshots/packages/$arch/passwall_packages
src/gz passwall2 https://master.dl.sourceforge.net/project/openwrt-passwall-build/snapshots/packages/$arch/passwall2
EOF

# --- Install Passwall2 and dependencies ---
echo -e "${GREEN}Installing Passwall 2 for snapshots.${NC}"
opkg update
opkg remove dnsmasq
opkg install dnsmasq-full unzip luci-app-passwall2 ipset ipt2socks iptables iptables-legacy iptables-mod-conntrack-extra iptables-mod-iprange iptables-mod-socket iptables-mod-tproxy kmod-ipt-nat ca-bundle kmod-inet-diag kernel kmod-netlink-diag kmod-tun kmod-nft-tproxy kmod-nft-socket

# --- Verify Passwall Installation ---
if [ -e /etc/init.d/passwall2 ]; then
  echo -e "${GREEN}Passwall 2 installed successfully!${NC}"
else
  echo -e "${RED}Can't download packages.${NC}"
  echo -e "${RED}Check your internet Connection.${NC}"
  exit 1
fi

# --- Verify dnsmasq-full Installation ---
if [ -e /usr/lib/opkg/info/dnsmasq-full.control ]; then
  echo -e "${GREEN}Package dnsmaq-full installed successfully!${NC}"
else
  echo -e "${RED}Package dnsmasq-full not installed! (Bad internet connection.)${NC}"
  exit 1
fi

# --- Copy overide to root ---
cp overide/* /

# --- Install Xray ---
opkg install xray-core

# --- Verify Xray Installation ---
if [ -e /usr/bin/xray ]; then
  echo -e "${GREEN}Xray installed successfully!${NC}"
else
  echo -e "${RED}Xray Installation failed!${NC}"
fi

# --- Completion ---
echo -e "${YELLOW}**Installation Completed!**${NC}"

# Reload configs
/sbin/reload_config

# Cleanup: remove self
rm passwall-snapshots.sh 2> /dev/null