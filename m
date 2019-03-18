From: akihiro27.suzuki@toshiba.co.jp (akihiro27.suzuki at toshiba.co.jp)
Date: Mon, 18 Mar 2019 09:14:24 +0000
Subject: [cip-dev] CIP IRC weekly meeting today
In-Reply-To: <20190318084218.jvf56lfecrbjtge3@MD1ZFJVC.ad001.siemens.net>
References: <375b3b16-8688-6fb2-4d4b-fc130c501c7e@siemens.com>
	<20190318084218.jvf56lfecrbjtge3@MD1ZFJVC.ad001.siemens.net>
Message-ID: <TY2PR01MB514642E9DF502D9F239C224AD9470@TY2PR01MB5146.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Christian,

> > > [Note] we are planning to develop the SWUpdate demo using ISAR, any
> > > advice or news about how to build SWUpdate on ISAR with the right
> > > U-Boot environment?
> > >
> > > - Regarding SWUpdate we hit an issue that we had not expected
> > > before. Suzuki-san was trying to update the standard BBB debian
> > > image (or a yocto-made one), but there were many warnings about
> > > orphan nodes etc. After some investigation the reason seems to be
> > > that the rootfs is modified during the first boot (or something like
> > > that). This is probably one of the biggest problems with updating
> > > images instead of files.
> >
> > Christian, any remarks?
> 
> Hm, did you check that you didn't flash the filesystem you have
> currently booted, i.e., are you overwriting the currently running
> root filesystem? I have seen such errors when I did this by accident.
I mounted rootfs with read-only.
I checked the difference of the rootfs image between before boot and after boot,
and at least the number of mounts had changed.

I attached following log files. I think that 0x434 is a mount count.

    mmcblk1p2-1-2.diff: The difference of rootfs image between 1st boot and 2nd boot
    mmcblk1p2-2-3.diff: The difference of rootfs image between 2nd boot and 3rd boot

Do you have some example of A/B update with binary delta update?

BTW, the warning message after binary delta update was as follows:

    EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm init: deleted inode referenced: 5040
    EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm init: deleted inode referenced: 5040
    EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm mount: deleted inode referenced: 5833
    EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm mount: deleted inode referenced: 5833
    EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm mount: deleted inode referenced: 5833
    EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm mount: deleted inode referenced: 5833
    EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm mount: deleted inode referenced: 5833
    EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm mount: deleted inode referenced: 5833
    EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm mount: deleted inode referenced: 5833
    EXT4-fs error (device mmcblk1p3): ext4_lookup:1584: inode #12: comm mount: deleted inode referenced: 5833

Best regards,
Suzuki


> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Christian
> Storm
> Sent: Monday, March 18, 2019 5:42 PM
> To: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: SZ.Lin at moxa.com; cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] CIP IRC weekly meeting today
> 
> Hi,
> 
> > > [Note] we are planning to develop the SWUpdate demo using ISAR, any
> > > advice or news about how to build SWUpdate on ISAR with the right
> > > U-Boot environment?
> > >
> > > - Regarding SWUpdate we hit an issue that we had not expected
> > > before. Suzuki-san was trying to update the standard BBB debian
> > > image (or a yocto-made one), but there were many warnings about
> > > orphan nodes etc. After some investigation the reason seems to be
> > > that the rootfs is modified during the first boot (or something like
> > > that). This is probably one of the biggest problems with updating
> > > images instead of files.
> >
> > Christian, any remarks?
> 
> Hm, did you check that you didn't flash the filesystem you have
> currently booted, i.e., are you overwriting the currently running
> root filesystem? I have seen such errors when I did this by accident.
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
-------------- next part --------------
A non-text attachment was scrubbed...
Name: mmcblk1p2-1-2.diff
Type: application/octet-stream
Size: 20959 bytes
Desc: mmcblk1p2-1-2.diff
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190318/96c49ba5/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: mmcblk1p2-2-3.diff
Type: application/octet-stream
Size: 7953 bytes
Desc: mmcblk1p2-2-3.diff
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190318/96c49ba5/attachment-0003.obj>
