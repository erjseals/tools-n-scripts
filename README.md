# tools-scripts

This is the private repository for Eric Seals. This will be used to document helpful configurations for applications, for useful CLI sequences, or whatever.

## SSH key generation

```bash
ssh-keygen -f ~/.ssh/<name_of_key>_id -t rsa -b 4096 
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

