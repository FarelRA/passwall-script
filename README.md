# OpenWrt Passwall Installer

This repository contains a set of bash scripts designed to simplify the installation and management of the Passwall firewall application on OpenWrt routers. Passwall provides advanced firewalling and traffic control features, and these scripts aim to make it more accessible to users.

## Features

-   **Automated Installation:**  Scripts to quickly install Passwall and related components.
-   **Passwall v1 & v2 Support:** Options to install either the original Passwall or Passwall2.
-   **Custom Feed Integration:** Automatically adds the necessary custom feeds for Passwall installation.
-   **Xray Installation:** Automatically installs the Xray core application.
-   **Simplified Updates:** Options to update existing Passwall installations.

## Scripts

This repository contains the following scripts:

-   `installer.sh`:  A menu-driven script for installing and managing Passwall.
-   `passwall1.sh`: A script that installs Passwall2, `xray` and `passwall1`.
-   `passwall2.sh`: A script that installs Passwall2, `xray` and `passwall2`.
-   `passwall-snapshots.sh`: A script that installs Passwall2 on snapshots OpenWrt router, `xray` and `passwall2`.

## Usage

### Download and Run the Scripts

Download the specific scripts you need or just run the installer in your OpenWrt router:

```bash
wget https://raw.githubusercontent.com/FarelRA/passwall-script/main/install.sh && chmod +x install.sh && sh install.sh
```

### `installer.sh` Options
This script will display a menu with the following options:
* Install Passwall 1
* Install Passwall 2
* Update Passwall v1
* Update Passwall v2
* Exit

Follow the on-screen prompts.

## Important Notes
*   **Root Access:** You must run the scripts with root privileges.
*   **Internet Connection:** An active internet connection is required to download packages and scripts.
*   **OpenWrt Version:** These scripts are primarily tested on recent versions of OpenWrt.
*   **Customizations:** These scripts can be a starting point for more advanced configurations, but be aware that manual changes might be overwritten by future runs of the script.
*   **Disk Space:** Ensure you have adequate free space to download and install packages.

## Contributing

Contributions are welcome! If you find a bug or have a suggestion for improvement, feel free to open an issue or submit a pull request.

## Disclaimer

Use these scripts at your own risk. The author is not responsible for any damage or issues caused by using these scripts. Make sure to back up your OpenWrt configuration before using any installation script.

## License

This project is licensed under the GPL-3.0 License - see the LICENSE file for details.

## Credits

Made with love by FarelRA