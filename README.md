BatPortScanner
Windows Batch File Port Scanner by Voltsparx
Contact: voltsparx@gmail.com

Description

BatPortScanner is a lightweight, no-installation-required port scanner written entirely in Windows Batch script. It provides basic port scanning capabilities with colorful terminal output and common protocol detection, using only native Windows tools.

Features

Zero Dependencies - Uses only built-in Windows commands and PowerShell
Colorful Interface - ANSI-colored output with visual formatting
Protocol Detection - Identifies common services (HTTP, HTTPS, FTP, SSH, etc.)
Port Range Scanning - Customizable start and end ports
Progress Indicators - Real-time scanning progress updates
No Installation Required - Runs directly as a batch file
Usage

Basic Scanning

text
BatPortScanner.bat 192.168.1.1
BatPortScanner.bat example.com
Advanced Scanning

text
BatPortScanner.bat 192.168.1.1 1 1000
BatPortScanner.bat target.com 80 443
BatPortScanner.bat 10.0.0.1 20 200
Command Syntax

text
BatPortScanner.bat [target] [start_port] [end_port]
Supported Protocols

Detects common services on standard ports:

Web: HTTP (80), HTTPS (443)
File Transfer: FTP (21), SSH (22)
Email: SMTP (25), POP3 (110), IMAP (143)
Database: MySQL (3306), PostgreSQL (5432)
Remote Access: RDP (3389), VNC (5900)
Network Services: DNS (53)
Requirements

Windows 7 or newer
PowerShell enabled (default on Windows)
Command Prompt with ANSI support (Windows 10+)
Technical Details

Uses PowerShell for TCP connection testing
Native batch scripting - no Python or external tools required
Lightweight and fast execution
Color output using ANSI escape codes
Legal Disclaimer

This tool is for educational purposes and authorized testing only. Always obtain proper permission before scanning any network or system. The author is not responsible for any misuse or damage caused by this program.

License

MIT License - free to use, modify, and distribute.

Notes

Slower than compiled port scanners but requires no installation
Perfect for quick checks and educational purposes
Limited to TCP port scanning only
Includes basic protocol detection for common services
Warning: Always ensure you have proper authorization before scanning any network. Unauthorized port scanning may be illegal in your jurisdiction.