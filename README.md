# Wake Without Wake-On-LAN

# Table of Contents

1. [What is Wake On LAN?](#what-is-wake-on-lan)
2. [Why use WoL?](#why-use-wol)
3. [Why *NOT* use WoL then?](#why-not-use-wol-then)
4. [How can I wake my machine remotely without WOL?!](#how-can-i-wake-my-machine-remotely-without-wol)
5. [How does Wake without WOL work?](#how-dows-wake-without-wol-work)
6. [How to Install and Set Up Wake without WOL](#how-to-install-and-set-up-wake-without-wol)
7. [How to use Wake without WOL to wake a computer remotely](#how-to-use-wake-without-wol-to-wake-a-computer-remotely)


## What is Wake On LAN?<a name="what-is-wake-on-lan"></a>

Wake-on-LAN (WoL) is a protocol for remotely waking computers from a low power mode, such as sleep or hibernate. The protocol also allows for a supplementary Wake-on-Wireless-LAN capability.

## Why use WoL?<a name="why-use-wol"></a>

WoL is useful if you plan to access your computer remotely for any reason: it allows you to retain access to your files and programs, while keeping the PC in a low-power state to save electricity (and of course, money) until you need it. Anyone who uses a program like VNC or TeamViewer, or keeps a file server or game server program available, should probably have the option enabled for the sake of convenience.

## Why *not* use WoL then?<a name="why-not-use-wol-then"></a>

Wake-on-LAN is dependent on two things: your motherboard and your network card. Your motherboard must be hooked up to an ATX-compatible power supply, as most computers in the past decade or so are. Your Ethernet or wireless card must also support this functionality. Because it is set either through the BIOS or through your network card’s firmware, you don’t need specific software to enable it, however you *do* need compatible hardware/firmware.

_**This is not always the case, especially for older machines!**_

## How can I wake my machine remotely without WoL?!<a name="how-can-i-wake-my-machine-remotely-without-wol"></a>

I developed the scripts contained within this repo to act as a work around for machines that don't support WoL. They aren't ideal, but they are useable to achieve somewhat similar functionality.

## How does Wake without WoL work?<a name="how-dows-wake-without-wol-work"></a>

Every x minutes a script wakes your computer and checks an file online (could be on github, could be on pastebin, anywhere that lets you view a raw text file works). If the file is set to 0, the computer will go back to sleep immediately, however if it's set to 1, the PC will stay active/awake, allowing you remote access.

In this way, you can remotely "ask" the computer to stay on, with the maximum wait time for it to occur being x minutes. All you have to do is edit the file online.

## How to install and set up Wake without WoL:<a name="how-to-install-and-set-up-wake-without-wol"></a>

1. Download wakescript.bat and hidescript.vbs from this repository (or just clone the 

 WakeScript.bat - This is the script responsible for checking an online file and deciding whether to keep the computer online or go back to sleep. 

 HideScript.vbs - There's no way to natively run a batch file without the console window popping up, which is very annoying. The workaround for this is to run a vbs file which calls the batch file in hidden mode.

2. Ensure that wake timers are enabled in the power scheme(s) you use by going to:  
Power Options -> change plan settings -> change advanced power settings -> sleep (expand) -> Allow wake timers (expand) -> enable
    1. If you wish to create a custom power plan that you switch to when you're running the wake without wol script, do the following:
        1. create the plan, ensuring that wake timers are enabled as described in step 2.
        2. open command prompt and run "powercfg /L"
        3. right click wakescript.bat -> edit
        4. replace "POWERPLANGUID" on lines 11 and 12 with the GUID corresponding to the power plan you made in (a) as was displayed in (b)
        5. remove "REM" from lines 11, 12 and 13 in wakescript.bat
        6. save and exit.

3. Create a file online (github, pastebin, wherever) that contains either a 1 or a 0. This file should be in a raw form such that when "curl url\_of\_the\_file.com" is run, only the text contained within the file is returned.

4. Right click wakescript.bat -> edit

5. Replace "FLAG.URL" on line 4 with the url of the file created in step 3.

6. From the start menu, open "Task Scheduler"

7. Create a new task with the following options:
    1. General tab - The only thing that matters in this tab is that "Run with highest privileges" is checked
    2. Triggers tab - Create a new trigger. 
        - Select "One-time".
        - The start time doesn't matter. 
        - The duration must be set to "infinitely".
        - Repeat task can be set to any time you want. This determines how frequently the computer will wake up to check the flag file.
        - Check "enabled", all settings not described should be unchecked or disabled.
    3. Actions tab - Create a new Action.
        - From the drop down list, select "Start a program".
        - In the text field under Program/script type "hide.vbs" (no quotation marks)
        - In the text field next to "Start in", type the path to the folder which contains hide.vbs. 
        - Note, if it doesn't work, try adding quotation marks to one of the above text field entries. This was inconsistent when I tried on two different machines.

    4. Conditions tab - 
        - Enable all options under "Power".
        - Enable "Start only if the following network connection is available" under "Network".
        - Select the network from the dropdown list that you connect to under "Network".
        - All other options should be disabled.

    5. Settings tab - 
        - Enable "Allow tasks to be run on demand".
        - Enable "Run tasks as soon as possible after a scheduled start is missed". 
        - If you intend to turn Wake without wol on and off, enable "Stop the task if it runs longer than..." and select an appropriate period of time.
        - Enable "If the running task does not end when requested, force it to stop".
        - From the drop down list, select "Do not start a new instance".
        - All other options should be disabled.
8. Press "OK" after all settings have been selected as described.

9. Run the task.


## How to use Wake without WOL to wake a computer remotely:<a name="how-to-use-wake-without-wol-to-wake-a-computer-remotely"></a>

Whenever you need to wake your computer remotely, simply change the value in the online text file to 1 and save it. Every x mins (as selected in (7.2)) the script will run and check whether the text file value is 1 or 0. If it is 1 it will remain awake, if it is 0, it will sleep.

Setting the text file value to 0 will cause the computer to remain asleep (after checks).