# tools-scripts

This is a scattered collection of things I've found useful to write down. Whether that be simple CLI commands I consistently forget, or just config files for applications like Vim and Tmux. This should probably be a private repository, but I don't want to log in to GitHub each time I forget how to unzip a tarball.

## SSH key generation

For new systems:
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
For older/legacy:
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

## Tar files

To compress: 

`tar -czvf name-of-archive.tar.gz /path/to/directory-or-file` 

To extract:

`tar -xzvf archive.tar.gz`

For reference:

* -c: Create an archive
* -x: Extract an archive
* -z: Compress the archive with gzip
* -v: Verbose
* -f: Specify filename of the archive

## GDB

To use GDB:

`$ gdb ./executablefile -tui`
`(gdb) r arg1 arg2 arg3`

* breakpoint (line #)   : b <filename>.c:<linenum>
* breakpoint (mem addr) : b \*0x12345678
* continue : c
* next : n
* print : p <variable>
* show all local : info locals
* run/restart : r
* disable breakpoints : disable
* (In tui) switch through previously used commands : ctrl + p & ctrl + n

## Vim netrw

List of useful commands on netrw:

* `R`: Renames a file 
* `gh`: Toggles the hidden files
* `I`: Changes display style (Vertical / Horizontal / Tree / ...)

## Latex and Vim (and with plugin VimTex)

At the default, you start compilation processes with "\\ll". From here, :w will recompile the pdf - so use a document viewer that allows for live updates.

## Valgrind

`valgrind --leak-check=full --track-origins=yes --verbose`

## (git) Grep

### Grep recursive search for a pattern in all *.c files

`grep -lr --include='*.c' search_pattern .`

### Git grep search to include all directories/submodules

`git grep -e "bar" --recurse-submodules`

### Git checkout and update the submodules to where they were pointed by super-repo

`git checkout $1; git submodule update --recursive`

### Git search repo for commits modifying a string

`git log -S <whatever> --source --all`

To find all commits that added or removed the fixed string whatever. The `--all` parameter means to start from every branch and `--source` means to show which of those branches led to finding that commit. It's often useful to add `-p` to show the patches that each of those commits would introduce as well.

You need to put quotes around the search term if it contains spaces or other special characters, for example:

`git log -S 'hello world' --source --all`
`git log -S "dude, where's my car?" --source --all`

## External HDD Read-Only Issue

Try executing the following command in a terminal:

`sudo mount -o remount,uid=1000,gid=1000,rw /dev/sdc1`

Explanation:

* -o means "with these options".
* remount - remounts the drive over the same mount point with the same previous options.
* uid=1000 - this option makes the user with id 1000 the owner of the drive. If you have more than one username on your system, run the command id and use the number after uid=.
* gid=1000 - this option makes the group with id 1000 the group owner of the drive. Same notes as previous point.
* rw - this option mounts the drive as read/write. It was probably read/write anyways, but this is just to double check.
* /dev/sdc1 is the name of the partition or device (can be checked in GParted in case you need to do the same with a different hardisk)

[Credit](https://askubuntu.com/questions/333287/how-to-fix-external-hard-disk-read-only)

## Windows / Linux Time Issue

Force Linux to use local time:

`timedatectl set-local-rtc 1 --adjust-system-clock`

To check current settings, run:

`timedatectl`

If you see “RTC in local TZ: yes”, Linux is set to use the local time zone instead of UTC. The command warns you that this mode is not fully supported and can cause some problems when changing between time zones and with daylight savings time. However, this mode is probably better supported than the UTC option in Windows. If you dual-boot with Windows, Windows will handle daylight savings time for you.

To undo the first command:

`timedatectl set-local-rtc 0 --adjust-system-clock`

## Jetson SDK Manager doesn't like Ubuntu>18

`sudo cp /usr/lib/os-release to /usr/lib/os-release-bionic`
`sudo cp /usr/lib/os-release to /usr/lib/os-release-hisure`
`sudo vim /usr/lib/os-release-bionic`

```
NAME="Ubuntu"
VERSION="18.04.5 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.5 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
```

When you want to start sdkmanager:

`sudo cp  /usr/lib/os-release-bionic /usr/lib/os-release`
`sdkmanager`

When you are done:
`sudo cp /usr/lib/os-release-hisure /usr/lib/os-release`

## Download videos from Blackboard

* load the page containing the video; don't click anything yet, and wait for everything to load
* Right-click anywhere, and select "Inspect" or "Inspect Element" (Chrome/Firefox respectively). A large panel will come up; select the "Network" tab.
* Click once on the video to load it, and then another time to start playing it. Click pause after the video starts playing.
* The "Network" tab will fill up with a list of files. You want the last one called "index.m3u8". Right-click it; under "Copy", select "Copy link address" or "Copy URL" (Chrome/Firefox respectively)
* Download and run VLC. In the "Media" menu, click "Convert" (or "Convert / Save", depending on your version). Paste the URL you've copied into the URL text field. Depending on your VLC version, this might be under the "Network" tab, or it might be right there as the "Source" text field.
* Pick where to save your video under "Destination".
* Click "Start" to start the download, after which the lecture will be available as a video on your computer.

## VMware Workstation fails to build kernel modules VMMON & VMNET

Newer kernel versions have issues with building kernel modules VMMON and VMNET. This will/can occur with the 5.4.x kernel series that are included in the 20.04 Focal Fossa release. Below is a work-around for this issue derived from the great work being maintained by [Michael Kubecek](https://github.com/mkubecek). You will need to download the appropriate file based on what version you have installed, this example is based on 15.5.1

Download the replacement files:

`wget https://github.com/mkubecek/vmware-host-modules/archive/workstation-15.5.1.tar.gz`

Extract the files:

`tar -xzf workstation-15.5.1.tar.gz`

cd into directory:

`cd vmware-host-modules-workstation-15.5.1/`

Create tar files of the modules:

`tar -cf vmmon.tar vmmon-only`
`tar -cf vmnet.tar vmnet-only`

Copy files to /usr/lib/vmware.modules.source (elevated privileges needed):

`sudo cp -v vmmon.tar vmnet.tar /usr/lib/vmware/modules/source/`

Install modules (elevated privileges needed):

`sudo vmware-modconfig --console --install-all`

