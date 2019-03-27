From: akihiro27.suzuki@toshiba.co.jp (akihiro27.suzuki at toshiba.co.jp)
Date: Wed, 27 Mar 2019 08:25:45 +0000
Subject: [cip-dev] CIP IRC weekly meeting today
In-Reply-To: <20190322123711.lc44vtkgk6bbgi6y@MD1ZFJVC.ad001.siemens.net>
References: <TY2PR01MB5146E2F09AB9D220F4E26C3CD9430@TY2PR01MB5146.jpnprd01.prod.outlook.com>
	<20190322123711.lc44vtkgk6bbgi6y@MD1ZFJVC.ad001.siemens.net>
Message-ID: <TYAPR01MB2495456763610C72BCCB9E90D9580@TYAPR01MB2495.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Christian,

I'm sorry to bother you.

> Looks good as / is mounted ro. Question is whether this is done via a
> remount,ro or whether it's ro right from the start?
I didn't remount / with ro manually,
but I have found that /proc/cmdline of the booted BBB includes "rw" as follows:

    root at beaglebone:~# cat /proc/cmdline
    console=ttyO0,115200n8 root=PARTUUID=770dcaeb-02 rw rootfstype=ext4 rootwait

This is because "args_mmc" (the environment variable of u-boot) was not changed
even though I had built the rootfs with "read-only-rootfs" option in poky.
(Although "/" in /etc/fstab was changed from "rw" to "ro" by the option)

The "args_mmc" was as follows:

    args_mmc=run finduuid;setenv bootargs console=${console} ${optargs} root=PARTUUID=${uuid} rw rootfstype=${mmcrootfstype}

When I changed "rw" on args_mmc to "ro" and booted the BBB, /proc/cmdline was changed as follows:

    root at beaglebone:~# cat /proc/cmdline
    console=ttyO0,115200n8 root=PARTUUID=770dcaeb-02 ro rootfstype=ext4 rootwait

Because of this, the rootfs came to able to be mounted with ro from the start.
Actually, I booted the BBB on several times,
and I checked that there were no changes in the partition.
Of course the binary delta update was successful with this configuration.
It seems for me that this issue has been resolved.
Thank you for your great help!

BTW, I have found the cause of the ext4 error messages.
This is because "/run/utmp" and "/run/mount" were created
before "/" was remounted automatically with ro according to /etc/fstab in the boot process.
Their inodes were created but they were overwritten by zero by the binary delta update.
But the inode of /run, their parent directory, was not overwritten by the update,
and the dentries of "utmp" and "mount" remained inside the inode of /run.
So the ext4 error messages were shown.
Currently, "utmp" and "mount" are not created because I can boot the rootfs with "ro" from the start.
So this issue does not occur.

> Well, how did you instruct SWUpdate to choose "copy1" or "copy2"?
Sorry for the lack of explanation.
I used the method adopted by meta-swupdate-boards.
The important file is the following startup script of swupdate.
<https://github.com/sbabic/meta-swupdate-boards/blob/master/recipes-support/swupdate/swupdate/beaglebone/swupdate>
The script checks the current rootfs partition and executes swupdate with "-e stable,copy{1|2}" as follows:

    root at beaglebone:~# cat /etc/init.d/swupdate
    #! /bin/sh
    -------- (snip) --------
    DAEMON=/usr/bin/swupdate
    -------- (snip) --------
    rootfs=`mount | grep "on / type" | cut -d':' -f 2 | cut -d' ' -f 1`

    if [ $rootfs == '/dev/mmcblk1p2' ];then
            selection="-e stable,copy2"
    else
            selection="-e stable,copy1"
    fi
    -------- (snip) --------
    exec $DAEMON -v -H beaglebone:1.0 ${selection} -f /etc/swupdate.cfg -u "$EXTRA_ARGS" -w "" &
    -------- (snip) --------

If the BBB is booted from /dev/mmcblk1p2, swupdate is executed with "-e stable,copy2" as follows:

    root at beaglebone:~# ps aux | grep swupdate
    root       500  0.0  0.2   1704  1164 ?        S    13:15   0:00 /usr/bin/swupdate-progress -w -p -r
    root       501  0.2  1.2  49456  6504 ?        Sl   13:15   0:00 /usr/bin/swupdate -v -H beaglebone 1.0 -e stable,copy2 -f /etc/swupdate.cfg -u  -w
    root       522  0.2  0.7  31016  3868 ?        Sl   13:15   0:00 /usr/bin/swupdate -v -H beaglebone 1.0 -e stable,copy2 -f /etc/swupdate.cfg -u  -w
    root       524  0.0  0.9  24200  4840 ?        S    13:15   0:00 /usr/bin/swupdate -v -H beaglebone 1.0 -e stable,copy2 -f /etc/swupdate.cfg -u  -w
    root       551  0.0  0.2   1884  1040 ttyO0    S+   13:19   0:00 grep swupdate
    (I'm not sure why /usr/bin/swupdate is running with 3 processes)

If you update now, the rule described in the "copy2" section in sw-description is used.
In the sw-description which was attached in my previous email,
the update target in the "copy2" section is /dev/mmcblk1p3.
Besides, bootcmd_legacy_mmc1 (the environment variable of u-boot)
is modified to use /dev/mmcblk1p3 as the next boot target.
If the BBB is booted from /dev/mmcblk1p3, the "copy1" section is used.
In the "copy1" section, the update and next boot target are /dev/mmcblk1p2.

Best regards,
Suzuki

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Christian
> Storm
> Sent: Friday, March 22, 2019 9:37 PM
> To: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] CIP IRC weekly meeting today
> 
> Hi Suzuki,
> 
> > > > I mounted rootfs with read-only.
> > >
> > > OK, from the diffs it seems that temporary storage directories such
> as
> > > /run and /var/tmp are not separate mount points from your roots?
> > I built the rootfs image by poky with "read-only-rootfs" option like
> following URL.
> >
> <https://www.yoctoproject.org/docs/current/mega-manual/mega-manual.h
> tml#creating-the-root-filesystem>
> 
> Ah, OK, didn't try that myself yet.
> 
> 
> > I think that the temporary storage directories were mounted as tmpfs
> as follows:
> >
> >     root at beaglebone:~# df -T
> >     Filesystem     Type     1K-blocks  Used Available Use% Mounted
> on
> >     /dev/root      ext4        135221 75902     49409  61% /
> >     devtmpfs       devtmpfs    243420     0    243420   0% /dev
> >     tmpfs          tmpfs       252124   124    252000   1% /run
> >     tmpfs          tmpfs       252124   252    251872   1%
> /var/volatile
> >
> >     root at beaglebone:~# mount
> >     /dev/mmcblk1p2 on / type ext4 (ro,relatime,data=ordered)
> >     devtmpfs on /dev type devtmpfs
> (rw,relatime,size=243420k,nr_inodes=60855,mode=755)
> >     proc on /proc type proc (rw,relatime)
> >     sysfs on /sys type sysfs (rw,relatime)
> >     debugfs on /sys/kernel/debug type debugfs (rw,relatime)
> >     tmpfs on /run type tmpfs (rw,nosuid,nodev,mode=755)
> >     tmpfs on /var/volatile type tmpfs (rw,relatime)
> >     devpts on /dev/pts type devpts
> (rw,relatime,gid=5,mode=620,ptmxmode=000)
> >     tmpfs on /var/lib type tmpfs (rw,relatime)
> 
> Looks good as / is mounted ro. Question is whether this is done via a
> remount,ro or whether it's ro right from the start?
> 
> To find out what's touching the files you can, e.g., turn on block_dump
> $ echo 1 > /proc/sys/vm/block_dump
> quite early in the boot process and filter it by grepping dmesg like
> $ dmesg | grep dirtied | grep "on sda" | sort
> 
> 
> > > > I checked the difference of the rootfs image between before boot
> and
> > > after boot,
> > > > and at least the number of mounts had changed.
> > > >
> > > > I attached following log files. I think that 0x434 is a mount count.
> > >
> > > You can use tune2fs -l /dev/<rootdevicenode> and look for
> > > "Mount count: <some number>" to verify this.
> > I checked this by tune2fs, and it was correct.
> >
> >     After the 1st boot:
> >
> >         root at beaglebone:~# tune2fs -l /dev/mmcblk1p2 | grep "Mount
> count"
> >         Mount count:              1
> >
> >         root at beaglebone:~# hexdump -C -n 2048 /dev/mmcblk1p2 | grep
> 430
> >         00000430  81 43 6d 38 01 00 ff ff  53 ef 01 00 01 00 00 00
> |.Cm8....S.......|
> >
> >     After the 2nd boot:
> >
> >         root at beaglebone:~# tune2fs -l /dev/mmcblk1p2 | grep "Mount
> count"
> >         Mount count:              2
> >
> >         root at beaglebone:~# hexdump -C -n 2048 /dev/mmcblk1p2 | grep
> 430
> >         00000430  f4 a4 90 5c 02 00 ff ff  53 ef 01 00 01 00 00 00
> |...\....S.......|
> >
> >     After the 3rd boot:
> >
> >         root at beaglebone:~# tune2fs -l /dev/mmcblk1p2 | grep "Mount
> count"
> >         Mount count:              3
> >
> >         root at beaglebone:~# hexdump -C -n 2048 /dev/mmcblk1p2 | grep
> 430
> >         00000430  63 a6 90 5c 03 00 ff ff  53 ef 01 00 01 00 00 00
> |c..\....S.......|
> >
> > BTW, the values of "Last mount time", "Last write time" and "Lifetime
> writes" were also changed.
> >
> > I'm concerned that if the partition which is set to rdiffbase is changed
> as above,
> > the binary delta update will be done correctly or not.
> 
> Well, technically it's just a patch, so if there is a difference in the
> two partition images you diff, and be it the filesystem's mount count,
> then this will end up in the patch and be applied on the device. If
> that's deemed incorrect, then such filesystem metadata has to be
> excluded from the diff by means of preprocessing both partition images
> so that there's no difference in the metadata that could end up in the
> binary patch.
> 
> The resulting partition's data is copied from the partition designated
> by rdiffbase except for the patch contents that overrule these. So, to
> stay in the above example, if the filesystem's mount count is not in the
> binary patch, it's taken from rdiffbase.
> 
> 
> > > > BTW, the warning message after binary delta update was as follows:
> > > >
> > > >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> > > comm init: deleted inode referenced: 5040
> > > >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> > > comm init: deleted inode referenced: 5040
> > > >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> > > comm mount: deleted inode referenced: 5833
> > > >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> > > comm mount: deleted inode referenced: 5833
> > > >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> > > comm mount: deleted inode referenced: 5833
> > > >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> > > comm mount: deleted inode referenced: 5833
> > > >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> > > comm mount: deleted inode referenced: 5833
> > > >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> > > comm mount: deleted inode referenced: 5833
> > > >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> > > comm mount: deleted inode referenced: 5833
> > > >     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12:
> > > comm mount: deleted inode referenced: 5833
> > >
> > > Well, my suspicion is that, after a delta-update of the partition,
> the
> > > filesystem's metadata is corrupt, i.e., the metdata was partially
> > > updated by a delta update, resulting in an inconsistent overall state.
> > > Could you elaborate on the exact steps you performed? Is the diff
> done
> > > from/to the right sources? Could as well be that the journal hasn't
> > > committed the changes... Just a wild guess though...
> > The exact steps I performed are as follows:
> >
> >      1. Build rootfs image as v1 by poky by reference to the following
> article:
> >
> <https://mkrak.org/2018/01/26/updating-embedded-linux-devices-part2/
> >
> >      2. Boot BeagleBone Black (BBB) from microSD
> >      3. Write "core-image-full-cmdline-beaglebone.wic" to
> /dev/mmcblk1 (eMMC) on BBB
> >      4. Write "core-image-full-cmdline-beaglebone.ext4" to
> /dev/mmcblk1p2
> >      5. Make /dev/mmcblk1p3 partition by fdisk and copy /dev/mmcblk1p2
> to /dev/mmcblk1p3
> >      6. Shutdown BBB and boot from /dev/mmcblk1p3
> >      7. Add a change to the recipe of poky and rebuild rootfs image
> as v2
> >      8. Make a delta image from v1 and v2 by rdiff command
> >      9. Make swu image from attached sw-description, emmcsetup.lua,
> and the delta image
> 
> Well, in the attached sw-description, you're using
> 						device =
> "/dev/mmcblk1p2";
> 						properties: {
> 							rdiffbase =
> ["/dev/mmcblk1p2"];
> 						};
> for "copy1" and
> 						device =
> "/dev/mmcblk1p3";
> 						properties: {
> 							rdiffbase =
> ["/dev/mmcblk1p3"];
> 						};
> for "copy2" which basically says use /dev/mmcblk1p{2,3} as rdiffbase
> (i.e. copy source) *and* target, hence you're overwriting
> /dev/mmcblk1p{2,3} with /dev/mmcblk1p{2,3} + binary patch applied.
> If /dev/mmcblk1p{2,3} happens to be mounted, then you'll get the ext4
> errors as you're overwriting a mounted filesystem on the block layer.
> 
> >     10. Access http://[IP address of BBB]:8080/ by Web browser and
> upload the above swu image
> >         (After the update is finished, It reboots automatically)
> 
> Well, how did you instruct SWUpdate to choose "copy1" or "copy2"?
> Can you provide the logs of the SWUpdate runs and the information from
> which partition you booted while running SWUpdate?
> 
> >     11. Check the update is done correctly
> >         (It boots from /dev/mmcblk1p2 and the rootfs image version is
> v2)
> 
> Well, I cannot tell about your setup but does
>   value = "... setenv bootpart 1:3 ..."
> in "copy2" instruct to boot from /dev/mmcblk1p2? Same question applies
> to "copy1".
> 
> >     12. Do the step of No.10 to update the rootfs image on /dev/mmcblk1p3
> to v2
> >     13. After updating and rebooting, BBB is booted from /dev/mmcblk1p3
> and
> >         the rootfs image version is v2, but the ext4 warning message
> is shown
> >
> > If you need more detailed steps, please let me know.
> >
> > To tell the truth, at first, I set the different partition to "device"
> and "rdiffbase" field at sw-description.
> > If "/dev/mmcblk1p2" was set to "device", I set "/dev/mmcblk1p3" to
> "rdiffbase" -- and vice versa.
> > When I used this sw-description, the ext4 warning message was shown
> at the step of No.11.
> 
> 
> 
> Kind regards,
>    Christian
> 
> --
> Dr. Christian Storm
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Otto-Hahn-Ring 6, 81739 M?nchen, Germany
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
