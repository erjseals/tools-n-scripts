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

## Download videos from Blackboard

* load the page containing the video; don't click anything yet, and wait for everything to load
* Right-click anywhere, and select "Inspect" or "Inspect Element" (Chrome/Firefox respectively). A large panel will come up; select the "Network" tab.
* Click once on the video to load it, and then another time to start playing it. Click pause after the video starts playing.
* The "Network" tab will fill up with a list of files. You want the last one called "index.m3u8". Right-click it; under "Copy", select "Copy link address" or "Copy URL" (Chrome/Firefox respectively)
* Download and run VLC. In the "Media" menu, click "Convert" (or "Convert / Save", depending on your version). Paste the URL you've copied into the URL text field. Depending on your VLC version, this might be under the "Network" tab, or it might be right there as the "Source" text field.
* Pick where to save your video under "Destination".
* Click "Start" to start the download, after which the lecture will be available as a video on your computer.

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

* breakpoint : b <filename>.c:<linenum>
* continue : c
* next : n
* print : p <variable>
* show all local : info locals
* run/restart : r
* disable breakpoints : disable
* (In tui) switch through previously used commands : ctrl + p & ctrl + n

## Windows / Linux Time Issue

Force Linux to use local time:

`timedatectl set-local-rtc 1 --adjust-system-clock`

To check current settings, run:

`timedatectl`

If you see “RTC in local TZ: yes”, Linux is set to use the local time zone instead of UTC. The command warns you that this mode is not fully supported and can cause some problems when changing between time zones and with daylight savings time. However, this mode is probably better supported than the UTC option in Windows. If you dual-boot with Windows, Windows will handle daylight savings time for you.

To undo the first command:

`timedatectl set-local-rtc 0 --adjust-system-clock`

## Git grep search to include all directories/submodules

`git grep -e "bar" --recurse-submodules`

## Git checkout and update the submodules to where they were pointed by super-repo

`git checkout $1; git submodule update --recursive`

## Git search repo for commits modifying a string

`git log -S <whatever> --source --all`

To find all commits that added or removed the fixed string whatever. The `--all` parameter means to start from every branch and `--source` means to show which of those branches led to finding that commit. It's often useful to add `-p` to show the patches that each of those commits would introduce as well.

You need to put quotes around the search term if it contains spaces or other special characters, for example:

`git log -S 'hello world' --source --all`
`git log -S "dude, where's my car?" --source --all`

## Latex and Vim (and with plugin VimTex)

At the default, you start compilation processes with "\\ll". From here, :w will recompile the pdf - so use a document viewer that allows for live updates.

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

You should get an output similar to the following:

```
Stopping VMware services:
   VMware Authentication Daemon                                        done
   VM communication interface socket family                            done
   Virtual machine communication interface                             done
   Virtual machine monitor                                             done
   Blocking file system                                                done
make: Entering directory '/tmp/modconfig-ySDgLm/vmmon-only'
Using kernel build system.
/usr/bin/make -C /lib/modules/5.4.0-14-generic/build/include/.. M=$PWD SRCROOT=$PWD/. \
  MODULEBUILDDIR= modules
make[1]: Entering directory '/usr/src/linux-headers-5.4.0-14-generic'
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/linux/driver.o
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/linux/hostif.o
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/linux/driverLog.o
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/common/memtrack.o
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/common/apic.o
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/common/statVarsVmmon.o
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/common/vmx86.o
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/common/sharedAreaVmmon.o
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/common/cpuid.o
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/common/task.o
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/common/comport.o
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/common/phystrack.o
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/vmcore/moduleloop.o
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/bootstrap/monLoaderVmmon.o
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/bootstrap/monLoader.o
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/bootstrap/vmmblob.o
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/bootstrap/bootstrap.o
  LD [M]  /tmp/modconfig-ySDgLm/vmmon-only/vmmon.o
  Building modules, stage 2.
  MODPOST 1 modules
  CC [M]  /tmp/modconfig-ySDgLm/vmmon-only/vmmon.mod.o
  LD [M]  /tmp/modconfig-ySDgLm/vmmon-only/vmmon.ko
make[1]: Leaving directory '/usr/src/linux-headers-5.4.0-14-generic'
/usr/bin/make -C $PWD SRCROOT=$PWD/. \
  MODULEBUILDDIR= postbuild
make[1]: Entering directory '/tmp/modconfig-ySDgLm/vmmon-only'
make[1]: 'postbuild' is up to date.
make[1]: Leaving directory '/tmp/modconfig-ySDgLm/vmmon-only'
cp -f vmmon.ko ./../vmmon.o
make: Leaving directory '/tmp/modconfig-ySDgLm/vmmon-only'
make: Entering directory '/tmp/modconfig-ySDgLm/vmnet-only'
Using kernel build system.
/usr/bin/make -C /lib/modules/5.4.0-14-generic/build/include/.. M=$PWD SRCROOT=$PWD/. \
  MODULEBUILDDIR= modules
make[1]: Entering directory '/usr/src/linux-headers-5.4.0-14-generic'
  CC [M]  /tmp/modconfig-ySDgLm/vmnet-only/driver.o
  CC [M]  /tmp/modconfig-ySDgLm/vmnet-only/hub.o
  CC [M]  /tmp/modconfig-ySDgLm/vmnet-only/userif.o
  CC [M]  /tmp/modconfig-ySDgLm/vmnet-only/netif.o
  CC [M]  /tmp/modconfig-ySDgLm/vmnet-only/bridge.o
  CC [M]  /tmp/modconfig-ySDgLm/vmnet-only/procfs.o
  CC [M]  /tmp/modconfig-ySDgLm/vmnet-only/smac_compat.o
  CC [M]  /tmp/modconfig-ySDgLm/vmnet-only/smac.o
  CC [M]  /tmp/modconfig-ySDgLm/vmnet-only/vnetEvent.o
  CC [M]  /tmp/modconfig-ySDgLm/vmnet-only/vnetUserListener.o
  LD [M]  /tmp/modconfig-ySDgLm/vmnet-only/vmnet.o
  Building modules, stage 2.
  MODPOST 1 modules
  CC [M]  /tmp/modconfig-ySDgLm/vmnet-only/vmnet.mod.o
  LD [M]  /tmp/modconfig-ySDgLm/vmnet-only/vmnet.ko
make[1]: Leaving directory '/usr/src/linux-headers-5.4.0-14-generic'
/usr/bin/make -C $PWD SRCROOT=$PWD/. \
  MODULEBUILDDIR= postbuild
make[1]: Entering directory '/tmp/modconfig-ySDgLm/vmnet-only'
make[1]: 'postbuild' is up to date.
make[1]: Leaving directory '/tmp/modconfig-ySDgLm/vmnet-only'
cp -f vmnet.ko ./../vmnet.o
make: Leaving directory '/tmp/modconfig-ySDgLm/vmnet-only'
Starting VMware services:
   Virtual machine monitor                                             done
   Virtual machine communication interface                             done
   VM communication interface socket family                            done
   Blocking file system                                                done
   Virtual ethernet                                                    done
   VMware Authentication Daemon                                        done
   Shared Memory Available                                             done
```