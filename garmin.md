# GARMIN notes

This is a scattered collection of things I've found either useful to write down or save. Should this be in multiple documents? Maybe - but I like giant files with ctl + f .
 
## VSCode Regex for removing certain lines in files

We are finding / replacing the regex pattern with emptiness, so:

`ctl + h`

then find the following pattern:

`^.*(PhoneCall:CallStateHandler|Logging:util|DigitalSwitchBox:RoutineSwitchDriver|CSM:Log|Orientation:DisplayManager|HAM:alsa_player|GUI:Timer|ASR4:ManifestUtil|Asr4Service:GUI_AsrService.cpp|ASR4:TopLevelContext.cpp|HWM:power_policy).*\n?`

and, for example, here's some individual regex searches:

* `^.*(PhoneCall:CallStateHandler).*\n?`
* `^.*(Logging:util).*\n?`
* `^.*(DigitalSwitchBox:RoutineSwitchDriver).*\n?`
* `^.*(MediaStateController:MediaStateController.cpp).*\n?`
* `^.*(CSM:Log).*\n?`
* `^.*(Orientation:DisplayManager).*\n?`
* `^.*(HAM:alsa_player).*\n?`
* `^.*(GUI:Timer).*\n?`
* `^.*(ASR4:ManifestUtil).*\n?`
* `^.*(Asr4Service:GUI_AsrService.cpp).*\n?`
* `^.*(ASR4:TopLevelContext.cpp).*\n?`
* `^.*(HWM:power_policy).*\n?`

## Decoding Android function addresses

Here's how to decode a single line of a tombstone file:

With x86_64-linux-android-addr2line.exe (thanks David), run as follows for the correct version.

For example, this would be used to analyze a Semi file running 4.07:

`$ ./x86_64-linux-android-addr2line.exe -C -f -e \\ad.garmin.com\builds\PND\release\Semi\4.07\exynos850\navapp\libsys.so 00000000018b43dc 00000000018ad0a0 00000000018ae4b0`

You can also use the parseAddresses.sh to do the same, but with the added luxury of text file storage :)

## PRMT

### Links

Confluence Pages:

* https://confluence.garmin.com/display/AUTOSW/Active+PRMT

Test Results:

* https://confluence.garmin.com/pages/viewpage.action?spaceKey=AUTOSW&title=Semi+C4P+PRMT+Results
* https://confluence.garmin.com/pages/viewpage.action?spaceKey=AUTOSW&title=Semi+Android+PRMT+Results
* https://confluence.garmin.com/pages/viewpage.action?spaceKey=AUTOSW&title=Denali+C4P+PRMT+Results
* https://confluence.garmin.com/pages/viewpage.action?spaceKey=AUTOSW&title=Denali+Android+PRMT+Results

Royal TS V5 executable:

G:\Eng\PRMT_Scripts\PC Setup\Royal TS V5

### Analysis
C4P
1.  Run the following script for each test to generate readable log files:

    `cd /d/grmn/prj/cauto/high-level/prmt`

    `./processPrmt.py -p $1 -v $2 -d '\\bombay\data\Eng\$1\PRMT\Logs\$3\$2' --platform $4`

    Where the $ variables are set to $1 = Semi / Denali , $2 = version number (like 4.03) , $3 = C4P / Android , $4 = linux / android. Case matters.

2.  After running the python script for Semi C4P 4.03, Hopper logs are place at:
  
    `\\bombay\data\Eng\Semi\PRMT\Logs\C4P\4.03\Hopper`

3.  Examine the files to get success rates and report JIRAs as needed.

    - Looking at Semi 4.03 C4P Hopper results. Go to the directory and open DONE_htmlshutdownreport.txt

    - Success means getting 0 or "No folders ..." on the device. In the case of Semi 4.03 C4P, we see 60% success. At this point, you can dig deeper into the individual devices to try to determine the cause of the failures.

    Device 5 had a crash, so go into `\\bombay\data\Eng\Semi\PRMT\Logs\C4P\4.03\Hopper\5\.System\Diag` for investigation. You can look at the LZO file in gdb (copy it to \grmn\prj\cauto\hydra)

    `cd ~/hydra`

    `./gdb.py *.lzo`

    And run bt (backtrace) at the gdb terminal. Full list available https://confluence.garmin.com/pages/viewpage.action?spaceKey=AUTOSW&title=GDB+Command+Line+Quick+Reference

    - For SuspendResume, we're looking for each device to hit 720+. The files DONE_htmlshutdownreport.txt shows errors and DONE_suspendresumecycles.txt shows cycle count.

    - For FullBootCycle, we're looking for each device to hit 720+. The DONE_htlmshutdownreport.txt shows errors and DONE_fullbootcount.txt shows boot count.

### OOM

Will walk through with the example of 4.04-OOM

Mostly followed this https://confluence.garmin.com/display/AUTOSW/Using+mtrace+for+out-of-memory+issues , but there were a few issues at the stage 'Analyzing an "OOM" coredump'

When running:

`Processor/Linux/mtrace/mtrace_find_allocations.py /d/Workspace/my_coredump.core`

a few issues might come up:

In *your* local hydra, at _Output/semi you need to add a folder 4.04-OOM.
In this folder, two folders. Builds and Tools.

Builds, you need to grab the "hydra" file from `\\bombay\data\Eng\Semi\Builds\4.04-OOM\koala\semi\release\hydra`

Tools. What I did was create copy of the folder "4.04" to "4.04-OOM" at `\\bombay\data\Eng\Semi\Tools\Libs`

I *think* this was all I had to do, and then the gdb.py script populated the local directory. Structure of local is `4.04-OOM\Tools\Libs\[lib/usr]`

Then guide should work as written =)

### Building Wifi Cycle Test release-automation

(from the page)

1.  Load an automation build onto the unit.
    - Plug a unit into your computer without a factory cable. Do not allow the unit to enter MTP mode.
    - Go to \\bombay\data\Eng\Kodiak\Builds\[desired version]\kodiak_c4p and confirm there is a release-automation build.
    - Go to \\bombay\data\Eng\Kodiak\Tools and run update-automation-secure.sh in Git Bash.
        - It will interactively ask for the version number to load.
        - It will then ask for a path to the private SSH key to be able to access the device. If you have a hydra repository checked out, you can find this at Processor/Linux/keys/306500/id_rsa. Otherwise, contact Hill, Jeffrey for assistance.
        - If the script cannot communicate with your device even after you have selected USB Ethernet mode in MTP settings, you may need to perform Linux PND USB Ethernet Setup.
2. Make sure the your unit is connected to Wi-Fi and has been through first time setup.
3. Put your device in MTP mode by plugging it into your computer without a factory cable. Feel free to hit continue on the prompt that appears when you are on the main page of the PND so you don't have to wait.

4. Extract Scripts.zip and place the "Scripts" folder in your root directory.
    - Script files were last updated on 2/11/19. Ensure you are using the latest iteration.
5. Boot up your unit. The test will automatically begin once the unit is booted.

(my notes)

- just build that --release --automation and then put the files you need at the proper spot in bombaby
    - That means, place a folder "release-automation" at, for example, `\\bombay\data\Eng\Denali\Builds\4.09\koala\release-automation`
    - The files we've created are at, again for denali 4.09, `\d\grmn\prj\cauto\hydra\_Output\denali\release`
    - The other files are obtained from `\\bombay\data\Eng\Denali\Builds\4.09\koala\denali\gir`
        - You need to place these all in the same directory as `\\bombay\data\Eng\Denali\Builds\4.09\koala\release-automation`

- You need to modify the update script for proper paths as well as the proper keys, but this is already updated for Denali/Semi/Kodiak 

- Run the script with arguments, so:
    - `./update-denali-automation-secure.sh -v 4.09 -i '/d/grmn/prj/cauto/hydra/Processor/Linux/keys/420900/id_rsa'`
    - `./update-semi-automation-secure.sh -v 4.09 -i '/d/grmn/prj/cauto/hydra/Processor/Linux/keys/416100/id_rsa'`
    - `./update-koala-automation-secure.sh -v 5.11 -i '/d/grmn/prj/cauto/clean-repos/hydra/Processor/Linux/keys/381700/id_rsa'`

- In terms of figuring out what to run, I select the most recent <official> release in the branch
    - When you do this, important to update the submodules before building the --release --automation