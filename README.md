# 🧹 Windows Cleanup and Optimization Toolkit

A powerful Windows maintenance script that cleans junk files, repairs system, and resets network — all in one click.

---

## ▶️ How to Run This File

1. **Download** the `windows_cleanup_Toolkit.bat` file
2. **Right-Click** on the file
3. Click **"Run as administrator"**
4. If a popup appears, click **"Yes"**
5. The script will automatically run all steps ✅

> ⚠️ **Important:** You MUST run as Administrator otherwise the script will NOT work!

---

## 📋 What This Script Does

### STEP 1 - Temp Files
del %temp%\*
del C:\Windows\Temp\*

### STEP 2 - Prefetch Files
del C:\Windows\Prefetch\*

### STEP 3 - Recent Files
del Recent\*
del AutomaticDestinations\*
del CustomDestinations\*

### STEP 4 - Disk Cleanup
cleanmgr /sagerun:1

### STEP 5 - Browser Cache
del Chrome Cache
del Edge Cache

### STEP 6 - DISM
DISM /Online /Cleanup-Image /RestoreHealth

### STEP 7 - SFC Scan
sfc /scannow

### STEP 8 - Windows Update Cache
net stop wuauserv
net stop bits
ren SoftwareDistribution SoftwareDistribution.old
net start wuauserv
net start bits

### STEP 9 - Disk Check
chkdsk C: /f /r /x

### STEP 10 - Event Logs
wevtutil cl

### STEP 11 - DNS Flush
ipconfig /flushdns
ipconfig /release
ipconfig /renew

### STEP 12 - Network Stack Reset
netsh winsock reset
netsh int ip reset

### STEP 13 - TCP Stack Reset
netsh int tcp reset
netsh int ipv4 reset
netsh int ipv6 reset
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global chimney=disabled
netsh int tcp set global ecncapability=disabled
netsh int tcp set global timestamps=disabled

---

## ⚠️ Important Notes

- Always **Run as Administrator**
- **Restart your PC** after the script finishes
- Some steps like `chkdsk` will run on **next reboot**
- Works on **Windows 10 and Windows 11**

---

## 📄 License
Free to use and share.
