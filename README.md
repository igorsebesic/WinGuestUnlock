# WinGuestUnlock

WinGuestUnlock is a powerful Windows batch script that enables **anonymous guest access**, **file and printer sharing**, and **SMB1 protocol support** — essential for working with legacy NAS devices, media servers, or file sharing between old and new systems.

---

## 🖥️ Compatibility

- ✅ Windows 10 Pro / Enterprise
- ✅ Windows 11 Pro / Enterprise

> ⚠️ Some settings may not work on **Windows Home** editions due to Group Policy restrictions.

---

## ⚙️ What the Script Does

This script automates the following system changes:

- 🟢 Enables **insecure guest logins** (required for guest access over SMB).
- 🔓 Disables **password protected sharing** via registry.
- 🧾 Modifies **registry keys** to allow anonymous access to shared folders.
- 🔁 Enables **SMB1 protocol** (needed for legacy devices).
- 🧑‍ Guest account is **activated** if not already enabled.
- 🔥 Enables **File and Printer Sharing** and **Network Discovery** through firewall rules.
- 🔄 Restarts **network services** to apply changes.
- 🧹 Performs **DNS flush and TCP/IP stack reset** to ensure clean network behavior.
- 🛠 Applies **Group Policy updates** (on Pro versions only).

---

## 🚀 How to Use

1. **Download the script**:
   - Clone the repo:
     ```bash
     git clone https://github.com/igorsebesic/WinGuestUnlock.git
     cd WinGuestUnlock
     ```
   - Or download the `.bat` file directly from the repo.

2. **Run the script** as **Administrator**:
   - Right-click `anonymousUserWin11.bat` and select **"Run as administrator"**.
   - Or open an elevated Command Prompt and run it manually:
     ```cmd
     anonymousUserWin11.bat
     ```

3. **Restart your computer** after execution to finalize changes.

---

## ⚠️ Important Notes

- 🔐 This script lowers the security of your system by enabling anonymous access.  
  Use only in **trusted networks** or **testing environments**.
- ⚠️ SMB1 is **deprecated and insecure**, but still required for some old NAS/media devices.
- 🛡 Always create a **System Restore Point** before running registry-editing scripts.

---

## 📂 File List

- `anonymousUserWin11.bat` – main script
- `.gitignore` – ignores Windows/system junk
- `README.md` – this documentation

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).

---

## 🤝 Contributions

Pull requests are welcome!  
If you find bugs, or want to improve compatibility or safety, feel free to contribute:

```bash
git checkout -b feature/my-improvement
git commit -m "Improve XYZ"
git push origin feature/my-improvement

👨‍💻 Author
Igor Šebešic
GitHub: @igorsebesic