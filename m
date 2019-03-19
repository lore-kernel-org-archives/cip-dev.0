From: akihiro27.suzuki@toshiba.co.jp (akihiro27.suzuki at toshiba.co.jp)
Date: Tue, 19 Mar 2019 05:18:52 +0000
Subject: [cip-dev] debootrap error
In-Reply-To: <204e9223-ed2b-9697-38a9-847fe2ee8704@siemens.com>
References: <HK0PR01MB297958B4B49D80F30DD800D9E24B0@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
	<OSAPR01MB37633BA45B40D16877229C51D04B0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<375b3b16-8688-6fb2-4d4b-fc130c501c7e@siemens.com>
	<TY2PR01MB5146389CBF352FDC6F104262D9440@TY2PR01MB5146.jpnprd01.prod.outlook.com>
	<cc3ea2e6-79d9-ed10-f1a3-cf615c3e6ec8@siemens.com>
	<TY2PR01MB514615FB285AF43385A49493D9470@TY2PR01MB5146.jpnprd01.prod.outlook.com>
	<02844bd9-fe8d-199f-27e3-42f59bb64163@siemens.com>
	<41b9fdc25373948d08ad360dc1db13340648cc93.camel@siemens.com>
	<1d4da986-92e6-87e3-11a4-30e15b48359d@siemens.com>
	<TY2PR01MB51463965A654EA6074848D00D9470@TY2PR01MB5146.jpnprd01.prod.outlook.com>
	<24beb970-86d2-c672-08e7-12732f9dd467@siemens.com>
	<204e9223-ed2b-9697-38a9-847fe2ee8704@siemens.com>
Message-ID: <TY2PR01MB5146C28D70580735866F91FDD9400@TY2PR01MB5146.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

> > That is how my qemu-arm setting looks like. Do you have a differentqemu path?
> > 
> > $ cat /proc/sys/fs/binfmt_misc/qemu-arm
> > enabled
> > interpreter /usr/bin/qemu-arm-static
> > flags: OCF
> > offset 0
> > magic 7f454c4601010100000000000000000002002800
> > mask ffffffffffffff00fffffffffffffffffeffffff
My qemu-arm setting is as follows:

    $ cat /proc/sys/fs/binfmt_misc/qemu-arm
    enabled
    interpreter /usr/bin/qemu-arm
    flags: OC
    offset 0
    magic 7f454c4601010100000000000000000002002800
    mask ffffffffffffff00fffffffffffffffffeffffff

According to this, the interpreter path was not same.
My machine used /usr/bin/qemu-arm but Claudius's machine used /usr/bin/qemu-arm-static.

If the first place, my machine didn't have /usr/bin/qemu-arm-static.
So, I installed qemu-user-static as follows:

    $ sudo aptitude install qemu-user-static
    [sudo] password for akihiro:
    The following NEW packages will be installed:
      qemu-user-static{b}
    0 packages upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
    Need to get 10.0 MB of archives. After unpacking 101 MB will be used.
    The following packages have unmet dependencies:
     qemu-user-static : Conflicts: qemu-user-binfmt but 1:2.11+dfsg-1ubuntu7.10 is installed
     qemu-user-binfmt : Conflicts: qemu-user-static but 1:2.11+dfsg-1ubuntu7.10 is to be installed
    The following actions will resolve these dependencies:
    
         Remove the following packages:
    1)     qemu-user-binfmt [1:2.11+dfsg-1ubuntu7.10 (bionic-updates, now)]
    
    Accept this solution? [Y/n/q/?] Y
    The following NEW packages will be installed:
      qemu-user-static
    The following packages will be REMOVED:
      qemu-user-binfmt{a}
    0 packages upgraded, 1 newly installed, 1 to remove and 0 not upgraded.
    Need to get 10.0 MB of archives. After unpacking 101 MB will be used.
    Do you want to continue? [Y/n/?] Y
    Get: 1 http://ftp.jaist.ac.jp/pub/Linux/ubuntu bionic-updates/universe amd64 qemu-user-static amd64 1:2.11+dfsg-1ubuntu7.10 [10.0 MB]
    Fetched 10.0 MB in 1min 5s (155 kB/s)
    (Reading database ... 299683 files and directories currently installed.)
    Removing qemu-user-binfmt (1:2.11+dfsg-1ubuntu7.10) ...
    Selecting previously unselected package qemu-user-static.
    (Reading database ... 299683 files and directories currently installed.)
    Preparing to unpack .../qemu-user-static_1%3a2.11+dfsg-1ubuntu7.10_amd64.deb ...
    Unpacking qemu-user-static (1:2.11+dfsg-1ubuntu7.10) ...
    Setting up qemu-user-static (1:2.11+dfsg-1ubuntu7.10) ...
    Processing triggers for man-db (2.8.3-2ubuntu0.1) ...

After that, I checked my qemu-arm setting.
The interpreter path has been changed to /usr/bin/qemu-arm-static as below:

    $ cat /proc/sys/fs/binfmt_misc/qemu-arm
    enabled
    interpreter /usr/bin/qemu-arm-static
    flags: OC
    offset 0
    magic 7f454c4601010100000000000000000002002800
    mask ffffffffffffff00fffffffffffffffffeffffff

After that, I built board-bbb.yml as below, and it succeeded!

    $ ./kas-docker --isar build kas.yml:board-bbb.yml

The root cause of this error is that my machine was not using
statically linked user mode qemu binaries?

Best regards,
Suzuki

> -----Original Message-----
> From: Jan Kiszka [mailto:jan.kiszka at siemens.com]
> Sent: Monday, March 18, 2019 7:19 PM
> To: Claudius Heine <claudius.heine.ext@siemens.com>; suzuki akihiro(?
> ? ?? ????????) <akihiro27.suzuki@toshiba.co.jp>;
> isar-users at googlegroups.com; ch at denx.de
> Cc: sangorrin daniel(????? ???? ????????)
> <daniel.sangorrin@toshiba.co.jp>; cip-dev at lists.cip-project.org
> Subject: Re: debootrap error
> 
> On 18.03.19 11:17, Claudius Heine wrote:
> > Hi,,
> >
> > On 18/03/2019 11.14, akihiro27.suzuki at toshiba.co.jp wrote:
> >> Hi,
> >>
> >>> That's a good hint: Suzuki-san, could you check if binfmt_misc is
> >>> available as
> >>> kernel feature/module on that machine? There may also be some warning
> >>> during the
> >>> container startup.
> >> I checked it and maybe it is available.
> >>
> >> ???? $ mount | grep binfmt
> >> ???? systemd-1 on /proc/sys/fs/binfmt_misc type autofs
> >>
> (rw,relatime,fd=31,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pip
> e_ino=18804)
> >> ???? binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc
> (rw,relatime)
> >> ???? $ lsmod | grep binfmt
> >> ???? binfmt_misc??????????? 20480? 1
> >> ???? $ cat /boot/config-4.15.0-46-generic? | grep BINFMT
> >> ???? CONFIG_BINFMT_ELF=y
> >> ???? CONFIG_COMPAT_BINFMT_ELF=y
> >> ???? CONFIG_BINFMT_SCRIPT=y
> >> ???? CONFIG_BINFMT_MISC=m
> >> ???? $ ls /proc/sys/fs/binfmt_misc/
> >> ???? python2.7???? qemu-armeb?????? qemu-mips64????? qemu-ppc64
> le
> >> qemu-sparc??????? status
> >> ???? python3.5???? qemu-cris??????? qemu-mips64el??? qemu-riscv
> 32
> >> qemu-sparc32plus
> >> ???? python3.6???? qemu-hppa??????? qemu-mipsel????? qemu-riscv
> 64? qemu-sparc64
> >> ???? qemu-aarch64? qemu-m68k??????? qemu-ppc???????? qemu-s390x
> ??? qemu-xtensa
> >> ???? qemu-alpha??? qemu-microblaze? qemu-ppc64?????? qemu-sh4
> ??? qemu-xtensaeb
> >> ???? qemu-arm????? qemu-mips??????? qemu-ppc64abi32? qemu-sh4eb
> ??? register
> >> ???? $ cat /proc/sys/fs/binfmt_misc/status
> >> ???? enabled
> >
> > That is how my qemu-arm setting looks like. Do you have a different
> qemu path?
> 
> Even if, it shouldn't be after starting the container: We allow it to
> adjust the
> system-wide binfmt configuration (one reason for --privileged).
> 
> Jan
> 
> >
> > $ cat /proc/sys/fs/binfmt_misc/qemu-arm
> > enabled
> > interpreter /usr/bin/qemu-arm-static
> > flags: OCF
> > offset 0
> > magic 7f454c4601010100000000000000000002002800
> > mask ffffffffffffff00fffffffffffffffffeffffff
> >
> > regards,
> > Claudius
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
