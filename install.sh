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

# --- Script Setup ---
# Load OpenWrt release info
. /etc/openwrt_release

# --- Check for Snapshot Version ---
if grep -q "SNAPSHOT" /etc/openwrt_release; then
  SNAPSHOT="true"
else
  SNAPSHOT="false"
fi

# --- Welcome Message ---
echo -e "${YELLOW}
 _____ _____ _____ _____ _ _ _ _____ __    __
|  _  |  _  |   __|   __| | | |  _  |  |  |  |
|   __|     |__   |__   | | | |     |  |__|  |__
|__|  |__|__|_____|_____|_____|__|__|_____|_____|

${NC}"

echo " - Model : $(cat /tmp/sysinfo/model)"
echo " - System Ver : $DISTRIB_RELEASE"
echo " - System Arch : $DISTRIB_ARCH"

echo ""

# --- Passwall Status Checks ---
echo -e " ${YELLOW}1.${NC} ${CYAN}Install Passwall 1${NC}"
echo -e " ${YELLOW}2.${NC} ${CYAN}Install Passwall 2 (Requires +256 MB RAM)${NC}"

if [ -e /etc/init.d/passwall ]; then
  echo -e " ${YELLOW}3.${NC} ${GREEN}Update Your Passwall${NC}"
fi

if [ -e /etc/init.d/passwall2 ]; then
  echo -e " ${YELLOW}4.${NC} ${GREEN}Update Your Passwall2${NC}"
fi

echo -e " ${YELLOW}5.${NC} ${RED}EXIT${NC}"
echo ""

# --- User Input and Actions ---
read -p " - Select Passwall Option : " choice

case "$choice" in
  1)
    echo "Installing Passwall 1 ..."
    if [[ "$SNAPSHOT" = "true" ]]; then
      rm -f passwall-snapshots.sh
      wget https://raw.githubusercontent.com/FarelRA/passwall-script/main/passwall-snapshots.sh
      chmod +x passwall-snapshots.sh
      sh passwall-snapshots.sh
    else
      rm -f passwall1.sh
      wget https://raw.githubusercontent.com/FarelRA/passwall-script/main/passwall1.sh
      chmod +x passwall1.sh
      sh passwall1.sh
    fi
    ;;

  2)
    echo "Installing Passwall 2 ..."
    if [[ "$SNAPSHOT" = "true" ]]; then
      rm -f passwall-snapshots.sh
      wget https://raw.githubusercontent.com/FarelRA/passwall-script/main/passwall-snapshots.sh
      chmod +x passwall-snapshots.sh
      sh passwall-snapshots.sh
    else
      rm -f passwall2.sh
      wget https://raw.githubusercontent.com/FarelRA/passwall-script/main/passwall2.sh
      chmod +x passwall2.sh
      sh passwall2.sh
    fi
    ;;

  3)
    echo "Updating Passwall 1"
    opkg update
    opkg install luci-app-passwall
    ;;

  4)
    echo "Updating Passwall 2"
    opkg update
    opkg install luci-app-passwall2
    ;;

  5)
    echo ""
    echo -e "${GREEN}Exiting...${NC}"
    ;;

  *)
    echo "Invalid option Selected !"
    echo ""
    echo -e "Press ${RED}ENTER${NC} to exit"
    ;;
esac

# -- Cleanup --
rm install.sh 2> /dev/null