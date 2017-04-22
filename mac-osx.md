
## Delete Time Machine on a Removable Disk

I have a removable hard drive named /Volume/PASSPORT that I had previously used as a Time Machine backup on another machine.

I wanted to clear out the space.

I tried to "Move to Trash..." on /Volume/PASSPORT/Backup.backupdb/ but it didn't work due to System Integrity Protection..

I tried to `sudo rm -rf` them, but it didn't work due to System Integrity Protection.

Here's what worked

```sh
sudo /System/Library/Extensions/TMSafetyNet.kext/Contents/Helpers/bypass rm -rfv /Volumes/PASSPORT/.Trashes/501/*
```
