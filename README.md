# WAUdeployGPO
GPO script to install Winget auto update on users PC. Works even if powershell script are desactivated by Policy.

The script execute everything in SYSTEM context, it check if the app is not already install with the regedit and it check if winget is installed before installing WAU.

To make the thing works:
Change your log path in the WAUbat.bat file and drag the files into your GPO Sysvol folder and its all done.

<img width="753" height="739" alt="image" src="https://github.com/user-attachments/assets/ac667d0d-384b-419d-8927-1d7c645a1c14" />

<img width="893" height="345" alt="image" src="https://github.com/user-attachments/assets/fce25b62-c20e-4534-8ad7-770023b008ca" />

