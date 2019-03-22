From: akihiro27.suzuki@toshiba.co.jp (akihiro27.suzuki at toshiba.co.jp)
Date: Fri, 22 Mar 2019 05:01:11 +0000
Subject: [cip-dev] CIP IRC weekly meeting today
In-Reply-To: <20190318102756.kvqvsy4yxzl3qta3@MD1ZFJVC.ad001.siemens.net>
References: <TY2PR01MB514642E9DF502D9F239C224AD9470@TY2PR01MB5146.jpnprd01.prod.outlook.com>
	<20190318102756.kvqvsy4yxzl3qta3@MD1ZFJVC.ad001.siemens.net>
Message-ID: <TY2PR01MB5146E2F09AB9D220F4E26C3CD9430@TY2PR01MB5146.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Christian,

Sorry for the late reply.

> > I mounted rootfs with read-only.
> 
> OK, from the diffs it seems that temporary storage directories such as
> /run and /var/tmp are not separate mount points from your roots?
I built the rootfs image by poky with "read-only-rootfs" option like following URL.
<https://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html#creating-the-root-filesystem>

I think that the temporary storage directories were mounted as tmpfs as follows:

    root at beaglebone:~# df -T
    Filesystem     Type     1K-blocks  Used Available Use% Mounted on
    /dev/root      ext4        135221 75902     49409  61% /
    devtmpfs       devtmpfs    243420     0    243420   0% /dev
    tmpfs          tmpfs       252124   124    252000   1% /run
    tmpfs          tmpfs       252124   252    251872   1% /var/volatile

    root at beaglebone:~# mount
    /dev/mmcblk1p2 on / type ext4 (ro,relatime,data=ordered)
    devtmpfs on /dev type devtmpfs (rw,relatime,size=243420k,nr_inodes=60855,mode=755)
    proc on /proc type proc (rw,relatime)
    sysfs on /sys type sysfs (rw,relatime)
    debugfs on /sys/kernel/debug type debugfs (rw,relatime)
    tmpfs on /run type tmpfs (rw,nosuid,nodev,mode=755)
    tmpfs on /var/volatile type tmpfs (rw,relatime)
    devpts on /dev/pts type devpts (rw,relatime,gid=5,mode=620,ptmxmode=000)
    tmpfs on /var/lib type tmpfs (rw,relatime)

    root at beaglebone:~# ls -l /var
    total 4
    drwxr-xr-x  2 root root 1024 Feb 13 08:41 backups
    drwxr-xr-x  4 root root 1024 Mar 19 07:47 cache
    drwxr-xr-x 10 root root  220 Mar 19 08:20 lib
    drwxr-xr-x  2 root root 1024 Feb 13 08:41 local
    lrwxrwxrwx  1 root root    9 Mar 19 07:47 lock -> /run/lock
    lrwxrwxrwx  1 root root   17 Mar 19 07:47 log -> /var/volatile/log
    lrwxrwxrwx  1 root root    4 Mar 19 07:47 run -> /run
    drwxr-xr-x  4 root root 1024 Mar 19 07:47 spool
    lrwxrwxrwx  1 root root   17 Mar 19 07:47 tmp -> /var/volatile/tmp
    drwxrwxrwt  5 root root  100 Mar 19 08:20 volatile

> > I checked the difference of the rootfs image between before boot and
> after boot,
> > and at least the number of mounts had changed.
> >
> > I attached following log files. I think that 0x434 is a mount count.
> 
> You can use tune2fs -l /dev/<rootdevicenode> and look for
> "Mount count: <some number>" to verify this.
I checked this by tune2fs, and it was correct.

    After the 1st boot:

        root at beaglebone:~# tune2fs -l /dev/mmcblk1p2 | grep "Mount count"
        Mount count:              1

        root at beaglebone:~# hexdump -C -n 2048 /dev/mmcblk1p2 | grep 430
        00000430  81 43 6d 38 01 00 ff ff  53 ef 01 00 01 00 00 00  |.Cm8....S.......|

    After the 2nd boot:

        root at beaglebone:~# tune2fs -l /dev/mmcblk1p2 | grep "Mount count"
        Mount count:              2

        root at beaglebone:~# hexdump -C -n 2048 /dev/mmcblk1p2 | grep 430
        00000430  f4 a4 90 5c 02 00 ff ff  53 ef 01 00 01 00 00 00  |...\....S.......|

    After the 3rd boot:

        root at beaglebone:~# tune2fs -l /dev/mmcblk1p2 | grep "Mount count"
        Mount count:              3

        root at beaglebone:~# hexdump -C -n 2048 /dev/mmcblk1p2 | grep 430
        00000430  63 a6 90 5c 03 00 ff ff  53 ef 01 00 01 00 00 00  |c..\....S.......|

BTW, the values of "Last mount time", "Last write time" and "Lifetime writes" were also changed.

I'm concerned that if the partition which is set to rdiffbase is changed as above,
the binary delta update will be done correctly or not.

> Well, currently nothing written in code. But I can try to elaborate on
> it here:
> Assume that, initially, A/version=1 and B/version=1 is on-disk.
> Then, the delta artifact ART_1->2 := rdiff(version=1 -> version=2) is
> applied to B,
> resulting in A/version=1 and B/version=2 on-disk. Boot into B/version=2,
> which is
> assumably successful.
> Then, when wanting to update A to a version=3 by an artifact
> ART_2->3 := rdiff(version=2 -> version=3), first ART_1->2 has to be
> applied to A and
> thereafter ART_2->3 has to be applied to A.
Thank you for the detailed explanation. 
I was thinking the same way, too.

> > BTW, the warning message after binary delta update was as follows:
> >
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm init: deleted inode referenced: 5040
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm init: deleted inode referenced: 5040
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm mount: deleted inode referenced: 5833
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm mount: deleted inode referenced: 5833
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm mount: deleted inode referenced: 5833
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm mount: deleted inode referenced: 5833
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm mount: deleted inode referenced: 5833
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm mount: deleted inode referenced: 5833
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm mount: deleted inode referenced: 5833
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm mount: deleted inode referenced: 5833
> 
> Well, my suspicion is that, after a delta-update of the partition, the
> filesystem's metadata is corrupt, i.e., the metdata was partially
> updated by a delta update, resulting in an inconsistent overall state.
> Could you elaborate on the exact steps you performed? Is the diff done
> from/to the right sources? Could as well be that the journal hasn't
> committed the changes... Just a wild guess though...
The exact steps I performed are as follows:

     1. Build rootfs image as v1 by poky by reference to the following article:
        <https://mkrak.org/2018/01/26/updating-embedded-linux-devices-part2/>
     2. Boot BeagleBone Black (BBB) from microSD
     3. Write "core-image-full-cmdline-beaglebone.wic" to /dev/mmcblk1 (eMMC) on BBB
     4. Write "core-image-full-cmdline-beaglebone.ext4" to /dev/mmcblk1p2
     5. Make /dev/mmcblk1p3 partition by fdisk and copy /dev/mmcblk1p2 to /dev/mmcblk1p3
     6. Shutdown BBB and boot from /dev/mmcblk1p3
     7. Add a change to the recipe of poky and rebuild rootfs image as v2
     8. Make a delta image from v1 and v2 by rdiff command
     9. Make swu image from attached sw-description, emmcsetup.lua, and the delta image
    10. Access http://[IP address of BBB]:8080/ by Web browser and upload the above swu image
        (After the update is finished, It reboots automatically)
    11. Check the update is done correctly
        (It boots from /dev/mmcblk1p2 and the rootfs image version is v2)
    12. Do the step of No.10 to update the rootfs image on /dev/mmcblk1p3 to v2
    13. After updating and rebooting, BBB is booted from /dev/mmcblk1p3 and
        the rootfs image version is v2, but the ext4 warning message is shown

If you need more detailed steps, please let me know.

To tell the truth, at first, I set the different partition to "device" and "rdiffbase" field at sw-description.
If "/dev/mmcblk1p2" was set to "device", I set "/dev/mmcblk1p3" to "rdiffbase" -- and vice versa.
When I used this sw-description, the ext4 warning message was shown at the step of No.11.

> What kernel version are you using? There are some issues with v4.19.3
> and v4.19.4 and ext4 filesystems having the same symptoms...
The kernel version is v4.12.28, but I think that it is no relation of this issue...

    root at beaglebone:~# uname -a
    Linux beaglebone 4.12.28-yocto-standard #1 PREEMPT Wed Feb 13 09:33:37 UTC 2019 armv7l armv7l armv7l GNU/Linux

Best regards,
Suzuki

> -----Original Message-----
> From: Christian Storm [mailto:christian.storm at siemens.com]
> Sent: Monday, March 18, 2019 7:28 PM
> To: cip-dev at lists.cip-project.org
> Cc: suzuki akihiro(???? ???? ????????????????)
> <akihiro27.suzuki@toshiba.co.jp>; jan.kiszka at siemens.com;
> SZ.Lin at moxa.com
> Subject: Re: [cip-dev] CIP IRC weekly meeting today
> 
> Hi Suzuki,
> 
> > > > > [Note] we are planning to develop the SWUpdate demo using ISAR,
> any
> > > > > advice or news about how to build SWUpdate on ISAR with the right
> > > > > U-Boot environment?
> > > > >
> > > > > - Regarding SWUpdate we hit an issue that we had not expected
> > > > > before. Suzuki-san was trying to update the standard BBB debian
> > > > > image (or a yocto-made one), but there were many warnings about
> > > > > orphan nodes etc. After some investigation the reason seems to
> be
> > > > > that the rootfs is modified during the first boot (or something
> like
> > > > > that). This is probably one of the biggest problems with updating
> > > > > images instead of files.
> > > >
> > > > Christian, any remarks?
> > >
> > > Hm, did you check that you didn't flash the filesystem you have
> > > currently booted, i.e., are you overwriting the currently running
> > > root filesystem? I have seen such errors when I did this by accident.
> >
> > I mounted rootfs with read-only.
> 
> OK, from the diffs it seems that temporary storage directories such as
> /run and /var/tmp are not separate mount points from your roots?
> 
> > I checked the difference of the rootfs image between before boot and
> after boot,
> > and at least the number of mounts had changed.
> >
> > I attached following log files. I think that 0x434 is a mount count.
> 
> You can use tune2fs -l /dev/<rootdevicenode> and look for
> "Mount count: <some number>" to verify this.
> 
> >
> >     mmcblk1p2-1-2.diff: The difference of rootfs image between 1st boot
> and 2nd boot
> >     mmcblk1p2-2-3.diff: The difference of rootfs image between 2nd boot
> and 3rd boot
> >
> > Do you have some example of A/B update with binary delta update?
> 
> Well, currently nothing written in code. But I can try to elaborate on
> it here:
> Assume that, initially, A/version=1 and B/version=1 is on-disk.
> Then, the delta artifact ART_1->2 := rdiff(version=1 -> version=2) is
> applied to B,
> resulting in A/version=1 and B/version=2 on-disk. Boot into B/version=2,
> which is
> assumably successful.
> Then, when wanting to update A to a version=3 by an artifact
> ART_2->3 := rdiff(version=2 -> version=3), first ART_1->2 has to be
> applied to A and
> thereafter ART_2->3 has to be applied to A.
> 
> Thing is here, you may have to apply a sequence of delta updates to the
> "other" partition so that applying the latest delta to it results in a
> consistent state, i.e., you have to do a "catchup" so that it matches
> the version the latest diff is done against.
> 
> That said, in order to not be forced to store ART_1->2 on the device,
> you can apply ART_1->2 to A once successfully booted into B/version=2.
> Or you can generate and apply ART_1->3 := rdiff(version=1 -> version=3)
> to A.
> Or you can split the update into first downloading and applying ART_1->2
> and the ART_2->3. There are many options, actually, depending on your
> preferences....
> 
> 
> > BTW, the warning message after binary delta update was as follows:
> >
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm init: deleted inode referenced: 5040
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm init: deleted inode referenced: 5040
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm mount: deleted inode referenced: 5833
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm mount: deleted inode referenced: 5833
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm mount: deleted inode referenced: 5833
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm mount: deleted inode referenced: 5833
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm mount: deleted inode referenced: 5833
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm mount: deleted inode referenced: 5833
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm mount: deleted inode referenced: 5833
> >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> comm mount: deleted inode referenced: 5833
> 
> Well, my suspicion is that, after a delta-update of the partition, the
> filesystem's metadata is corrupt, i.e., the metdata was partially
> updated by a delta update, resulting in an inconsistent overall state.
> Could you elaborate on the exact steps you performed? Is the diff done
> from/to the right sources? Could as well be that the journal hasn't
> committed the changes... Just a wild guess though...
> 
> What kernel version are you using? There are some issues with v4.19.3
> and v4.19.4 and ext4 filesystems having the same symptoms...
> 
> 
> Kind regards,
>    Christian
> 
> --
> Dr. Christian Storm
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Otto-Hahn-Ring 6, 81739 M??nchen, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sw-description
Type: application/octet-stream
Size: 1178 bytes
Desc: sw-description
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190322/e3b6a710/attachment-0001.obj>
