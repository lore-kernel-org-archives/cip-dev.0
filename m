From: akihiro27.suzuki@toshiba.co.jp (akihiro27.suzuki at toshiba.co.jp)
Date: Mon, 18 Mar 2019 10:14:05 +0000
Subject: [cip-dev] debootrap error
In-Reply-To: <1d4da986-92e6-87e3-11a4-30e15b48359d@siemens.com>
References: <HK0PR01MB297958B4B49D80F30DD800D9E24B0@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
	<OSAPR01MB37633BA45B40D16877229C51D04B0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<375b3b16-8688-6fb2-4d4b-fc130c501c7e@siemens.com>
	<TY2PR01MB5146389CBF352FDC6F104262D9440@TY2PR01MB5146.jpnprd01.prod.outlook.com>
	<cc3ea2e6-79d9-ed10-f1a3-cf615c3e6ec8@siemens.com>
	<TY2PR01MB514615FB285AF43385A49493D9470@TY2PR01MB5146.jpnprd01.prod.outlook.com>
	<02844bd9-fe8d-199f-27e3-42f59bb64163@siemens.com>
	<41b9fdc25373948d08ad360dc1db13340648cc93.camel@siemens.com>
	<1d4da986-92e6-87e3-11a4-30e15b48359d@siemens.com>
Message-ID: <TY2PR01MB51463965A654EA6074848D00D9470@TY2PR01MB5146.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

> That's a good hint: Suzuki-san, could you check if binfmt_misc is
> available as
> kernel feature/module on that machine? There may also be some warning
> during the
> container startup.
I checked it and maybe it is available.

    $ mount | grep binfmt
    systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=31,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=18804)
    binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc (rw,relatime)
    $ lsmod | grep binfmt
    binfmt_misc            20480  1
    $ cat /boot/config-4.15.0-46-generic  | grep BINFMT
    CONFIG_BINFMT_ELF=y
    CONFIG_COMPAT_BINFMT_ELF=y
    CONFIG_BINFMT_SCRIPT=y
    CONFIG_BINFMT_MISC=m
    $ ls /proc/sys/fs/binfmt_misc/
    python2.7     qemu-armeb       qemu-mips64      qemu-ppc64le  qemu-sparc        status
    python3.5     qemu-cris        qemu-mips64el    qemu-riscv32  qemu-sparc32plus
    python3.6     qemu-hppa        qemu-mipsel      qemu-riscv64  qemu-sparc64
    qemu-aarch64  qemu-m68k        qemu-ppc         qemu-s390x    qemu-xtensa
    qemu-alpha    qemu-microblaze  qemu-ppc64       qemu-sh4      qemu-xtensaeb
    qemu-arm      qemu-mips        qemu-ppc64abi32  qemu-sh4eb    register
    $ cat /proc/sys/fs/binfmt_misc/status
    enabled

The startup message is as follows:

    $ ./kas-docker --isar build kas.yml:board-bbb.yml
    2019-03-18 10:08:58 - INFO     - kas 0.20.1 started
    2019-03-18 10:08:58 - INFO     - /repo$ git rev-parse --show-toplevel
    2019-03-18 10:08:58 - INFO     - /repo$ git rev-parse --show-toplevel
    2019-03-18 10:08:58 - INFO     - /repo$ git rev-parse --show-toplevel
    2019-03-18 10:08:58 - INFO     - Using /repo as root for repository cip-core
    2019-03-18 10:08:58 - INFO     - /work$ git clone -q https://github.com/ilbers/isar /work/isar
    2019-03-18 10:09:02 - INFO     - Repository isar cloned
    2019-03-18 10:09:02 - INFO     - /repo$ git rev-parse --show-toplevel
    2019-03-18 10:09:02 - INFO     - Using /repo as root for repository cip-core
    2019-03-18 10:09:02 - INFO     - /work/isar$ git status -s
    2019-03-18 10:09:02 - INFO     - /work/isar$ git rev-parse --verify HEAD
    2019-03-18 10:09:02 - INFO     - 6c5db020b9b837d7b0ce63bfc719f9192e725f26
    2019-03-18 10:09:02 - INFO     - /work/isar$ git checkout -q d226c29d24f791a15fbdce9c354eb189a1003dcc
    2019-03-18 10:09:02 - INFO     - /repo$ git rev-parse --show-toplevel
    2019-03-18 10:09:02 - INFO     - Using /repo as root for repository cip-core
    2019-03-18 10:09:02 - INFO     - /work/isar$ /tmp/tmpyscgo7lw /work/build
    2019-03-18 10:09:02 - INFO     - /repo$ git rev-parse --show-toplevel
    2019-03-18 10:09:02 - INFO     - Using /repo as root for repository cip-core
    2019-03-18 10:09:02 - INFO     - /repo$ git rev-parse --show-toplevel
    2019-03-18 10:09:02 - INFO     - Using /repo as root for repository cip-core
    2019-03-18 10:09:02 - INFO     - /work/build$ /work/isar/bitbake/bin/bitbake -k -c build cip-core-image
    Parsing recipes: 100% |################################################################################
    ...(snip)...

Best regards,
Suzuki


> -----Original Message-----
> From: Jan Kiszka [mailto:jan.kiszka at siemens.com]
> Sent: Monday, March 18, 2019 6:39 PM
> To: Claudius Heine <claudius.heine.ext@siemens.com>; suzuki akihiro(?
> ? ?? ????????) <akihiro27.suzuki@toshiba.co.jp>;
> isar-users <isar-users@googlegroups.com>; Claudius Heine <ch@denx.de>
> Cc: sangorrin daniel(????? ???? ????????)
> <daniel.sangorrin@toshiba.co.jp>; cip-dev at lists.cip-project.org
> Subject: Re: debootrap error
> 
> On 18.03.19 10:11, Claudius Heine wrote:
> > Hi,
> >
> > On Mon, 2019-03-18 at 10:05 +0100, [ext] Jan Kiszka wrote:
> >> On 18.03.19 02:42, akihiro27.suzuki at toshiba.co.jp wrote:
> >>> Hi Jan,
> >>>
> >>>> Were you building natively on Debian or inside the kas container?
> >>> I was executing following commands according to the README.md at
> >>> isar-cip-core,
> >>> so I think I was building inside the kas container.
> >>>
> >>>       $ wget
> >>> https://raw.githubusercontent.com/siemens/kas/master/kas-docker
> >>>       $ chmod a+x kas-docker
> >>>       $ sudo ./kas-docker --isar build kas.yml:board-bbb.yml
> >>>
> >>> The error is as follows (from log.do_bootstrap of isar-bootstrap-
> >>> target):
> >>>
> >>>       DEBUG: Executing shell function do_bootstrap
> >>>       I: Running command: debootstrap --arch armhf --foreign --
> >>> verbose --variant=minbase --include=locales --
> >>> components=main,contrib,non-free stretch /work/build/tmp/work/cip-
> >>> core-armhf/isar-bootstrap-target/rootfs
> >>> http://ftp.de.debian.org/debian
> >>>       I: Retrieving InRelease
> >>>       I: Retrieving Release
> >>>       I: Retrieving Release.gpg
> >>>       I: Checking Release signature
> >>>       I: Valid Release signature (key id
> >>> 067E3C456BAE240ACEE88F6FEF0F382A1A7B6500)
> >>>       I: Retrieving Packages
> >>>       I: Validating Packages
> >>>       I: Retrieving Packages
> >>>       I: Validating Packages
> >>>       I: Retrieving Packages
> >>>       I: Validating Packages
> >>>       I: Resolving dependencies of required packages...
> >>>       I: Resolving dependencies of base packages...
> >>>       I: Found additional required dependencies: libaudit1
> libaudit-
> >>> common libbz2-1.0 libcap-ng0 libdb5.3 libdebconfclient0 libgcrypt20
> >>> libgpg-error0 liblz4-1 libncursesw5 libsemanage1 libsemanage-common
> >>> libsystemd0 libudev1 libustr-1.0-1
> >>>       I: Found additional base dependencies: adduser
> debian-archive-
> >>> keyring gpgv libapt-pkg5.0 libc-l10n libstdc++6
> >>>       I: Checking component main on
> http://ftp.de.debian.org/debian.
> >>> ..
> >>>       I: Retrieving libacl1 2.2.52-3+b1
> >>>       I: Validating libacl1 2.2.52-3+b1
> >>>       I: Retrieving adduser 3.115
> >>>       I: Validating adduser 3.115
> >>>       I: Retrieving apt 1.4.9
> >>>       I: Validating apt 1.4.9
> >>>       I: Retrieving libapt-pkg5.0 1.4.9
> >>>       I: Validating libapt-pkg5.0 1.4.9
> >>>       I: Retrieving libattr1 1:2.4.47-2+b2
> >>>       I: Validating libattr1 1:2.4.47-2+b2
> >>>       I: Retrieving libaudit-common 1:2.6.7-2
> >>>       I: Validating libaudit-common 1:2.6.7-2
> >>>       I: Retrieving libaudit1 1:2.6.7-2
> >>>       I: Validating libaudit1 1:2.6.7-2
> >>>       I: Retrieving base-files 9.9+deb9u8
> >>>       I: Validating base-files 9.9+deb9u8
> >>>       I: Retrieving base-passwd 3.5.43
> >>>       I: Validating base-passwd 3.5.43
> >>>       I: Retrieving bash 4.4-5
> >>>       I: Validating bash 4.4-5
> >>>       I: Retrieving libbz2-1.0 1.0.6-8.1
> >>>       I: Validating libbz2-1.0 1.0.6-8.1
> >>>       I: Retrieving libdebconfclient0 0.227
> >>>       I: Validating libdebconfclient0 0.227
> >>>       I: Retrieving coreutils 8.26-3
> >>>       I: Validating coreutils 8.26-3
> >>>       I: Retrieving dash 0.5.8-2.4
> >>>       I: Validating dash 0.5.8-2.4
> >>>       I: Retrieving libdb5.3 5.3.28-12+deb9u1
> >>>       I: Validating libdb5.3 5.3.28-12+deb9u1
> >>>       I: Retrieving debconf 1.5.61
> >>>       I: Validating debconf 1.5.61
> >>>       I: Retrieving debian-archive-keyring 2017.5
> >>>       I: Validating debian-archive-keyring 2017.5
> >>>       I: Retrieving debianutils 4.8.1.1
> >>>       I: Validating debianutils 4.8.1.1
> >>>       I: Retrieving diffutils 1:3.5-3
> >>>       I: Validating diffutils 1:3.5-3
> >>>       I: Retrieving dpkg 1.18.25
> >>>       I: Validating dpkg 1.18.25
> >>>       I: Retrieving e2fslibs 1.43.4-2
> >>>       I: Validating e2fslibs 1.43.4-2
> >>>       I: Retrieving e2fsprogs 1.43.4-2
> >>>       I: Validating e2fsprogs 1.43.4-2
> >>>       I: Retrieving libcomerr2 1.43.4-2
> >>>       I: Validating libcomerr2 1.43.4-2
> >>>       I: Retrieving libss2 1.43.4-2
> >>>       I: Validating libss2 1.43.4-2
> >>>       I: Retrieving findutils 4.6.0+git+20161106-2
> >>>       I: Validating findutils 4.6.0+git+20161106-2
> >>>       I: Retrieving gcc-6-base 6.3.0-18+deb9u1
> >>>       I: Validating gcc-6-base 6.3.0-18+deb9u1
> >>>       I: Retrieving libgcc1 1:6.3.0-18+deb9u1
> >>>       I: Validating libgcc1 1:6.3.0-18+deb9u1
> >>>       I: Retrieving libstdc++6 6.3.0-18+deb9u1
> >>>       I: Validating libstdc++6 6.3.0-18+deb9u1
> >>>       I: Retrieving libc-bin 2.24-11+deb9u4
> >>>       I: Validating libc-bin 2.24-11+deb9u4
> >>>       I: Retrieving libc-l10n 2.24-11+deb9u4
> >>>       I: Validating libc-l10n 2.24-11+deb9u4
> >>>       I: Retrieving libc6 2.24-11+deb9u4
> >>>       I: Validating libc6 2.24-11+deb9u4
> >>>       I: Retrieving locales 2.24-11+deb9u4
> >>>       I: Validating locales 2.24-11+deb9u4
> >>>       I: Retrieving multiarch-support 2.24-11+deb9u4
> >>>       I: Validating multiarch-support 2.24-11+deb9u4
> >>>       I: Retrieving gpgv 2.1.18-8~deb9u4
> >>>       I: Validating gpgv 2.1.18-8~deb9u4
> >>>       I: Retrieving grep 2.27-2
> >>>       I: Validating grep 2.27-2
> >>>       I: Retrieving gzip 1.6-5+b1
> >>>       I: Validating gzip 1.6-5+b1
> >>>       I: Retrieving hostname 3.18+b1
> >>>       I: Validating hostname 3.18+b1
> >>>       I: Retrieving init-system-helpers 1.48
> >>>       I: Validating init-system-helpers 1.48
> >>>       I: Retrieving libcap-ng0 0.7.7-3+b1
> >>>       I: Validating libcap-ng0 0.7.7-3+b1
> >>>       I: Retrieving libgcrypt20 1.7.6-2+deb9u3
> >>>       I: Validating libgcrypt20 1.7.6-2+deb9u3
> >>>       I: Retrieving libgpg-error0 1.26-2
> >>>       I: Validating libgpg-error0 1.26-2
> >>>       I: Retrieving libselinux1 2.6-3+b3
> >>>       I: Validating libselinux1 2.6-3+b3
> >>>       I: Retrieving libsemanage-common 2.6-2
> >>>       I: Validating libsemanage-common 2.6-2
> >>>       I: Retrieving libsemanage1 2.6-2
> >>>       I: Validating libsemanage1 2.6-2
> >>>       I: Retrieving libsepol1 2.6-2
> >>>       I: Validating libsepol1 2.6-2
> >>>       I: Retrieving lsb-base 9.20161125
> >>>       I: Validating lsb-base 9.20161125
> >>>       I: Retrieving liblz4-1 0.0~r131-2+b1
> >>>       I: Validating liblz4-1 0.0~r131-2+b1
> >>>       I: Retrieving mawk 1.3.3-17+b3
> >>>       I: Validating mawk 1.3.3-17+b3
> >>>       I: Retrieving libncursesw5 6.0+20161126-1+deb9u2
> >>>       I: Validating libncursesw5 6.0+20161126-1+deb9u2
> >>>       I: Retrieving libtinfo5 6.0+20161126-1+deb9u2
> >>>       I: Validating libtinfo5 6.0+20161126-1+deb9u2
> >>>       I: Retrieving ncurses-base 6.0+20161126-1+deb9u2
> >>>       I: Validating ncurses-base 6.0+20161126-1+deb9u2
> >>>       I: Retrieving ncurses-bin 6.0+20161126-1+deb9u2
> >>>       I: Validating ncurses-bin 6.0+20161126-1+deb9u2
> >>>       I: Retrieving libpam-modules 1.1.8-3.6
> >>>       I: Validating libpam-modules 1.1.8-3.6
> >>>       I: Retrieving libpam-modules-bin 1.1.8-3.6
> >>>       I: Validating libpam-modules-bin 1.1.8-3.6
> >>>       I: Retrieving libpam-runtime 1.1.8-3.6
> >>>       I: Validating libpam-runtime 1.1.8-3.6
> >>>       I: Retrieving libpam0g 1.1.8-3.6
> >>>       I: Validating libpam0g 1.1.8-3.6
> >>>       I: Retrieving libpcre3 2:8.39-3
> >>>       I: Validating libpcre3 2:8.39-3
> >>>       I: Retrieving perl-base 5.24.1-3+deb9u5
> >>>       I: Validating perl-base 5.24.1-3+deb9u5
> >>>       I: Retrieving sed 4.4-1
> >>>       I: Validating sed 4.4-1
> >>>       I: Retrieving sensible-utils 0.0.9+deb9u1
> >>>       I: Validating sensible-utils 0.0.9+deb9u1
> >>>       I: Retrieving login 1:4.4-4.1
> >>>       I: Validating login 1:4.4-4.1
> >>>       I: Retrieving passwd 1:4.4-4.1
> >>>       I: Validating passwd 1:4.4-4.1
> >>>       I: Retrieving libsystemd0 232-25+deb9u8
> >>>       I: Validating libsystemd0 232-25+deb9u8
> >>>       I: Retrieving libudev1 232-25+deb9u8
> >>>       I: Validating libudev1 232-25+deb9u8
> >>>       I: Retrieving sysvinit-utils 2.88dsf-59.9
> >>>       I: Validating sysvinit-utils 2.88dsf-59.9
> >>>       I: Retrieving tar 1.29b-1.1
> >>>       I: Validating tar 1.29b-1.1
> >>>       I: Retrieving tzdata 2018i-0+deb9u1
> >>>       I: Validating tzdata 2018i-0+deb9u1
> >>>       I: Retrieving libustr-1.0-1 1.0.4-6
> >>>       I: Validating libustr-1.0-1 1.0.4-6
> >>>       I: Retrieving bsdutils 1:2.29.2-1+deb9u1
> >>>       I: Validating bsdutils 1:2.29.2-1+deb9u1
> >>>       I: Retrieving libblkid1 2.29.2-1+deb9u1
> >>>       I: Validating libblkid1 2.29.2-1+deb9u1
> >>>       I: Retrieving libfdisk1 2.29.2-1+deb9u1
> >>>       I: Validating libfdisk1 2.29.2-1+deb9u1
> >>>       I: Retrieving libmount1 2.29.2-1+deb9u1
> >>>       I: Validating libmount1 2.29.2-1+deb9u1
> >>>       I: Retrieving libsmartcols1 2.29.2-1+deb9u1
> >>>       I: Validating libsmartcols1 2.29.2-1+deb9u1
> >>>       I: Retrieving libuuid1 2.29.2-1+deb9u1
> >>>       I: Validating libuuid1 2.29.2-1+deb9u1
> >>>       I: Retrieving mount 2.29.2-1+deb9u1
> >>>       I: Validating mount 2.29.2-1+deb9u1
> >>>       I: Retrieving util-linux 2.29.2-1+deb9u1
> >>>       I: Validating util-linux 2.29.2-1+deb9u1
> >>>       I: Retrieving liblzma5 5.2.2-1.2+b1
> >>>       I: Validating liblzma5 5.2.2-1.2+b1
> >>>       I: Retrieving zlib1g 1:1.2.8.dfsg-5
> >>>       I: Validating zlib1g 1:1.2.8.dfsg-5
> >>>       I: Chosen extractor for .deb packages: dpkg-deb
> >>>       I: Extracting libacl1...
> >>>       I: Extracting libattr1...
> >>>       I: Extracting libaudit-common...
> >>>       I: Extracting libaudit1...
> >>>       I: Extracting base-files...
> >>>       I: Extracting base-passwd...
> >>>       I: Extracting bash...
> >>>       I: Extracting libbz2-1.0...
> >>>       I: Extracting libdebconfclient0...
> >>>       I: Extracting coreutils...
> >>>       I: Extracting dash...
> >>>       I: Extracting libdb5.3...
> >>>       I: Extracting debconf...
> >>>       I: Extracting debianutils...
> >>>       I: Extracting diffutils...
> >>>       I: Extracting dpkg...
> >>>       I: Extracting e2fslibs...
> >>>       I: Extracting e2fsprogs...
> >>>       I: Extracting libcomerr2...
> >>>       I: Extracting libss2...
> >>>       I: Extracting findutils...
> >>>       I: Extracting gcc-6-base...
> >>>       I: Extracting libgcc1...
> >>>       I: Extracting libc-bin...
> >>>       I: Extracting libc6...
> >>>       I: Extracting multiarch-support...
> >>>       I: Extracting grep...
> >>>       I: Extracting gzip...
> >>>       I: Extracting hostname...
> >>>       I: Extracting init-system-helpers...
> >>>       I: Extracting libcap-ng0...
> >>>       I: Extracting libgcrypt20...
> >>>       I: Extracting libgpg-error0...
> >>>       I: Extracting libselinux1...
> >>>       I: Extracting libsemanage-common...
> >>>       I: Extracting libsemanage1...
> >>>       I: Extracting libsepol1...
> >>>       I: Extracting lsb-base...
> >>>       I: Extracting liblz4-1...
> >>>       I: Extracting mawk...
> >>>       I: Extracting libncursesw5...
> >>>       I: Extracting libtinfo5...
> >>>       I: Extracting ncurses-base...
> >>>       I: Extracting ncurses-bin...
> >>>       I: Extracting libpam-modules...
> >>>       I: Extracting libpam-modules-bin...
> >>>       I: Extracting libpam-runtime...
> >>>       I: Extracting libpam0g...
> >>>       I: Extracting libpcre3...
> >>>       I: Extracting perl-base...
> >>>       I: Extracting sed...
> >>>       I: Extracting sensible-utils...
> >>>       I: Extracting login...
> >>>       I: Extracting passwd...
> >>>       I: Extracting libsystemd0...
> >>>       I: Extracting libudev1...
> >>>       I: Extracting sysvinit-utils...
> >>>       I: Extracting tar...
> >>>       I: Extracting tzdata...
> >>>       I: Extracting libustr-1.0-1...
> >>>       I: Extracting bsdutils...
> >>>       I: Extracting libblkid1...
> >>>       I: Extracting libfdisk1...
> >>>       I: Extracting libmount1...
> >>>       I: Extracting libsmartcols1...
> >>>       I: Extracting libuuid1...
> >>>       I: Extracting mount...
> >>>       I: Extracting util-linux...
> >>>       I: Extracting liblzma5...
> >>>       I: Extracting zlib1g...
> >>>       I: Running command: chroot /work/build/tmp/work/cip-core-
> >>> armhf/isar-bootstrap-target/rootfs /debootstrap/debootstrap --
> >>> second-stage
> >>>       chroot: failed to run command ?/debootstrap/debootstrap?: No
> >>> such file or directory
> >>>       WARNING: exit code 127 from a shell command.
> >>>       ERROR: Function failed: do_bootstrap (log file is located at
> >>> /work/build/tmp/work/cip-core-armhf/isar-bootstrap-
> >>> target/temp/log.do_bootstrap.316)
> >>>
> >>
> >> Looping in isar-users and Claudius. I've no idea why debootstrap
> >> should stumble here, apparently over its own feet.
> >
> > Well I would assume that it is an issue with your binfmt configuration
> > if '/work/build/tmp/work/cip-core-armhf/isar-bootstrap-
> > target/rootfs/debootstrap/deboostrap' exists.
> >
> 
> That's a good hint: Suzuki-san, could you check if binfmt_misc is
> available as
> kernel feature/module on that machine? There may also be some warning
> during the
> container startup.
> 
> If that should have been the reason, we likely need a better detection
> in Isar,
> before the user runs into this non-obvious error message.
> 
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
