From: christian.storm@siemens.com (Christian Storm)
Date: Fri, 29 Mar 2019 14:21:56 +0100
Subject: [cip-dev] CIP IRC weekly meeting today
In-Reply-To: <TYAPR01MB2495456763610C72BCCB9E90D9580@TYAPR01MB2495.jpnprd01.prod.outlook.com>
Message-ID: <20190329132156.5nbwt5niagahvoxm@MD1ZFJVC.ad001.siemens.net>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Suzuki,


> I'm sorry to bother you.

You're always welcome.


> > Looks good as / is mounted ro. Question is whether this is done via a
> > remount,ro or whether it's ro right from the start?
> I didn't remount / with ro manually,
> but I have found that /proc/cmdline of the booted BBB includes "rw" as follows:
> 
>     root at beaglebone:~# cat /proc/cmdline
>     console=ttyO0,115200n8 root=PARTUUID=770dcaeb-02 rw rootfstype=ext4 rootwait
> 
> This is because "args_mmc" (the environment variable of u-boot) was not changed
> even though I had built the rootfs with "read-only-rootfs" option in poky.
> (Although "/" in /etc/fstab was changed from "rw" to "ro" by the option)
> 
> The "args_mmc" was as follows:
> 
>     args_mmc=run finduuid;setenv bootargs console=${console} ${optargs} root=PARTUUID=${uuid} rw rootfstype=${mmcrootfstype}
> 
> When I changed "rw" on args_mmc to "ro" and booted the BBB, /proc/cmdline was changed as follows:
> 
>     root at beaglebone:~# cat /proc/cmdline
>     console=ttyO0,115200n8 root=PARTUUID=770dcaeb-02 ro rootfstype=ext4 rootwait
> 
> Because of this, the rootfs came to able to be mounted with ro from the start.
> Actually, I booted the BBB on several times,
> and I checked that there were no changes in the partition.
> Of course the binary delta update was successful with this configuration.
> It seems for me that this issue has been resolved.
> Thank you for your great help!

That sounds good! Glad I could help here.


> BTW, I have found the cause of the ext4 error messages.
> This is because "/run/utmp" and "/run/mount" were created
> before "/" was remounted automatically with ro according to /etc/fstab in the boot process.
> Their inodes were created but they were overwritten by zero by the binary delta update.
> But the inode of /run, their parent directory, was not overwritten by the update,
> and the dentries of "utmp" and "mount" remained inside the inode of /run.
> So the ext4 error messages were shown.
> Currently, "utmp" and "mount" are not created because I can boot the rootfs with "ro" from the start.
> So this issue does not occur.

Sounds reasonable, good to have it sorted out.


> > Well, how did you instruct SWUpdate to choose "copy1" or "copy2"?
> Sorry for the lack of explanation.
> I used the method adopted by meta-swupdate-boards.
> The important file is the following startup script of swupdate.
> <https://github.com/sbabic/meta-swupdate-boards/blob/master/recipes-support/swupdate/swupdate/beaglebone/swupdate>
> The script checks the current rootfs partition and executes swupdate with "-e stable,copy{1|2}" as follows:
> 
>     root at beaglebone:~# cat /etc/init.d/swupdate
>     #! /bin/sh
>     -------- (snip) --------
>     DAEMON=/usr/bin/swupdate
>     -------- (snip) --------
>     rootfs=`mount | grep "on / type" | cut -d':' -f 2 | cut -d' ' -f 1`
> 
>     if [ $rootfs == '/dev/mmcblk1p2' ];then
>             selection="-e stable,copy2"
>     else
>             selection="-e stable,copy1"
>     fi
>     -------- (snip) --------
>     exec $DAEMON -v -H beaglebone:1.0 ${selection} -f /etc/swupdate.cfg -u "$EXTRA_ARGS" -w "" &
>     -------- (snip) --------
> 
> If the BBB is booted from /dev/mmcblk1p2, swupdate is executed with "-e stable,copy2" as follows:
> 
>     root at beaglebone:~# ps aux | grep swupdate
>     root       500  0.0  0.2   1704  1164 ?        S    13:15   0:00 /usr/bin/swupdate-progress -w -p -r
>     root       501  0.2  1.2  49456  6504 ?        Sl   13:15   0:00 /usr/bin/swupdate -v -H beaglebone 1.0 -e stable,copy2 -f /etc/swupdate.cfg -u  -w
>     root       522  0.2  0.7  31016  3868 ?        Sl   13:15   0:00 /usr/bin/swupdate -v -H beaglebone 1.0 -e stable,copy2 -f /etc/swupdate.cfg -u  -w
>     root       524  0.0  0.9  24200  4840 ?        S    13:15   0:00 /usr/bin/swupdate -v -H beaglebone 1.0 -e stable,copy2 -f /etc/swupdate.cfg -u  -w
>     root       551  0.0  0.2   1884  1040 ttyO0    S+   13:19   0:00 grep swupdate
>     (I'm not sure why /usr/bin/swupdate is running with 3 processes)

This is because SWUpdate is designed around a multi-process model with
IPC among the processes via sockets. This has, as one example, the
benefit that one can run the multiple components of SWUpdate with
different privileges. Apart from this, there's a clean interface also
imposed on the code structure which helps the modularization of the
source code.


> If you update now, the rule described in the "copy2" section in sw-description is used.
> In the sw-description which was attached in my previous email,
> the update target in the "copy2" section is /dev/mmcblk1p3.
> Besides, bootcmd_legacy_mmc1 (the environment variable of u-boot)
> is modified to use /dev/mmcblk1p3 as the next boot target.
> If the BBB is booted from /dev/mmcblk1p3, the "copy1" section is used.
> In the "copy1" section, the update and next boot target are /dev/mmcblk1p2.

Ah, OK. This is the "official" in the sense of exemplary implemented way
how to do round-robin A/B firmware update. That said, this is in my very
personal opinion a bit too involved and spread out over too many places.
That was also one reason I brought forward the Lua handler feature that
allows you to implement a handler in Lua. Lua handlers are feature-wise
on par with C handlers by now, i.e., they are equally powerful. So, you
can write a Lua handler that does the target partition round-robin
calculation, flashing, and updating of the bootloader environment in one
place. The sw-description becomes simpler as well since you don't need
to specify the A/B layout there but instead the Lua handler will take
care of this.



Kind regards,
   Christian

-- 
Dr. Christian Storm
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Otto-Hahn-Ring 6, 81739 M?nchen, Germany
