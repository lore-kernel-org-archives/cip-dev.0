From: christian.storm@siemens.com (Christian Storm)
Date: Mon, 18 Mar 2019 11:27:56 +0100
Subject: [cip-dev] CIP IRC weekly meeting today
In-Reply-To: <TY2PR01MB514642E9DF502D9F239C224AD9470@TY2PR01MB5146.jpnprd01.prod.outlook.com>
Message-ID: <20190318102756.kvqvsy4yxzl3qta3@MD1ZFJVC.ad001.siemens.net>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Suzuki,

> > > > [Note] we are planning to develop the SWUpdate demo using ISAR, any
> > > > advice or news about how to build SWUpdate on ISAR with the right
> > > > U-Boot environment?
> > > >
> > > > - Regarding SWUpdate we hit an issue that we had not expected
> > > > before. Suzuki-san was trying to update the standard BBB debian
> > > > image (or a yocto-made one), but there were many warnings about
> > > > orphan nodes etc. After some investigation the reason seems to be
> > > > that the rootfs is modified during the first boot (or something like
> > > > that). This is probably one of the biggest problems with updating
> > > > images instead of files.
> > >
> > > Christian, any remarks?
> > 
> > Hm, did you check that you didn't flash the filesystem you have
> > currently booted, i.e., are you overwriting the currently running
> > root filesystem? I have seen such errors when I did this by accident.
>
> I mounted rootfs with read-only.

OK, from the diffs it seems that temporary storage directories such as
/run and /var/tmp are not separate mount points from your roots?

> I checked the difference of the rootfs image between before boot and after boot,
> and at least the number of mounts had changed.
> 
> I attached following log files. I think that 0x434 is a mount count.

You can use tune2fs -l /dev/<rootdevicenode> and look for
"Mount count: <some number>" to verify this.

> 
>     mmcblk1p2-1-2.diff: The difference of rootfs image between 1st boot and 2nd boot
>     mmcblk1p2-2-3.diff: The difference of rootfs image between 2nd boot and 3rd boot
> 
> Do you have some example of A/B update with binary delta update?

Well, currently nothing written in code. But I can try to elaborate on it here:
Assume that, initially, A/version=1 and B/version=1 is on-disk.
Then, the delta artifact ART_1->2 := rdiff(version=1 -> version=2) is applied to B,
resulting in A/version=1 and B/version=2 on-disk. Boot into B/version=2, which is
assumably successful.
Then, when wanting to update A to a version=3 by an artifact
ART_2->3 := rdiff(version=2 -> version=3), first ART_1->2 has to be applied to A and
thereafter ART_2->3 has to be applied to A.

Thing is here, you may have to apply a sequence of delta updates to the
"other" partition so that applying the latest delta to it results in a
consistent state, i.e., you have to do a "catchup" so that it matches
the version the latest diff is done against.

That said, in order to not be forced to store ART_1->2 on the device,
you can apply ART_1->2 to A once successfully booted into B/version=2.
Or you can generate and apply ART_1->3 := rdiff(version=1 -> version=3) to A.
Or you can split the update into first downloading and applying ART_1->2
and the ART_2->3. There are many options, actually, depending on your
preferences....


> BTW, the warning message after binary delta update was as follows:
> 
>     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm init: deleted inode referenced: 5040
>     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm init: deleted inode referenced: 5040
>     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm mount: deleted inode referenced: 5833
>     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm mount: deleted inode referenced: 5833
>     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm mount: deleted inode referenced: 5833
>     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm mount: deleted inode referenced: 5833
>     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm mount: deleted inode referenced: 5833
>     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm mount: deleted inode referenced: 5833
>     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm mount: deleted inode referenced: 5833
>     EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm mount: deleted inode referenced: 5833

Well, my suspicion is that, after a delta-update of the partition, the
filesystem's metadata is corrupt, i.e., the metdata was partially
updated by a delta update, resulting in an inconsistent overall state.
Could you elaborate on the exact steps you performed? Is the diff done
from/to the right sources? Could as well be that the journal hasn't
committed the changes... Just a wild guess though...

What kernel version are you using? There are some issues with v4.19.3
and v4.19.4 and ext4 filesystems having the same symptoms...


Kind regards,
   Christian

-- 
Dr. Christian Storm
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Otto-Hahn-Ring 6, 81739 M?nchen, Germany
