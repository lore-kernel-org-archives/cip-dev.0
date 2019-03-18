From: akihiro27.suzuki@toshiba.co.jp (akihiro27.suzuki at toshiba.co.jp)
Date: Mon, 18 Mar 2019 08:59:42 +0000
Subject: [cip-dev] debootstrap error (was: Re: CIP IRC weekly meeting
 today)
In-Reply-To: <76d6b375-8df8-d086-d7c8-afa708143eac@siemens.com>
References: <HK0PR01MB297958B4B49D80F30DD800D9E24B0@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
	<OSAPR01MB37633BA45B40D16877229C51D04B0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<375b3b16-8688-6fb2-4d4b-fc130c501c7e@siemens.com>
	<TY2PR01MB5146389CBF352FDC6F104262D9440@TY2PR01MB5146.jpnprd01.prod.outlook.com>
	<cc3ea2e6-79d9-ed10-f1a3-cf615c3e6ec8@siemens.com>
	<TY2PR01MB5146DF4BB293D840CA867429D9470@TY2PR01MB5146.jpnprd01.prod.outlook.com>
	<76d6b375-8df8-d086-d7c8-afa708143eac@siemens.com>
Message-ID: <TY2PR01MB51463AEC9B18513CC9370C55D9470@TY2PR01MB5146.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> On 18.03.19 03:53, akihiro27.suzuki at toshiba.co.jp wrote:
> >>      $ sudo ./kas-docker --isar build kas.yml:board-bbb.yml
> > I made a mistake. We don't need sudo to run kas-docker.
> >
> 
> Did that resolve the issue?
No. The error occurs with or without sudo.

Suzuki

> -----Original Message-----
> From: Jan Kiszka [mailto:jan.kiszka at siemens.com]
> Sent: Monday, March 18, 2019 5:57 PM
> To: suzuki akihiro(?? ?? ????????)
> <akihiro27.suzuki@toshiba.co.jp>; sangorrin daniel(????? ???
> ? ????????) <daniel.sangorrin@toshiba.co.jp>;
> SZ.Lin at moxa.com; cip-dev at lists.cip-project.org;
> christian.storm at siemens.com
> Subject: debootstrap error (was: Re: [cip-dev] CIP IRC weekly meeting
> today)
> 
> On 18.03.19 03:53, akihiro27.suzuki at toshiba.co.jp wrote:
> >>      $ sudo ./kas-docker --isar build kas.yml:board-bbb.yml
> > I made a mistake. We don't need sudo to run kas-docker.
> >
> 
> Did that resolve the issue?
> 
> > Suzuki
> >
> >> -----Original Message-----
> >> From: suzuki akihiro(?? ?? ????????)
> >> Sent: Monday, March 18, 2019 10:42 AM
> >> To: Jan Kiszka <jan.kiszka@siemens.com>; sangorrin daniel(????
> ? ?
> >> ??? ????????) <daniel.sangorrin@toshiba.co.jp>;
> >> SZ.Lin at moxa.com; cip-dev at lists.cip-project.org;
> >> christian.storm at siemens.com
> >> Subject: RE: [cip-dev] CIP IRC weekly meeting today
> >>
> >> Hi Jan,
> >>
> >>> Were you building natively on Debian or inside the kas container?
> >> I was executing following commands according to the README.md at
> >> isar-cip-core,
> >> so I think I was building inside the kas container.
> >>
> >>      $ wget
> >> https://raw.githubusercontent.com/siemens/kas/master/kas-docker
> >>      $ chmod a+x kas-docker
> >>      $ sudo ./kas-docker --isar build kas.yml:board-bbb.yml
> >>
> >> The error is as follows (from log.do_bootstrap of
> isar-bootstrap-target):
> >>
> >>      DEBUG: Executing shell function do_bootstrap
> >>      I: Running command: debootstrap --arch armhf --foreign --verbose
> >> --variant=minbase --include=locales
> >> --components=main,contrib,non-free stretch
> >> /work/build/tmp/work/cip-core-armhf/isar-bootstrap-target/rootfs
> >> http://ftp.de.debian.org/debian
> >>      I: Retrieving InRelease
> >>      I: Retrieving Release
> >>      I: Retrieving Release.gpg
> >>      I: Checking Release signature
> >>      I: Valid Release signature (key id
> >> 067E3C456BAE240ACEE88F6FEF0F382A1A7B6500)
> >>      I: Retrieving Packages
> >>      I: Validating Packages
> >>      I: Retrieving Packages
> >>      I: Validating Packages
> >>      I: Retrieving Packages
> >>      I: Validating Packages
> >>      I: Resolving dependencies of required packages...
> >>      I: Resolving dependencies of base packages...
> >>      I: Found additional required dependencies: libaudit1
> >> libaudit-common libbz2-1.0 libcap-ng0 libdb5.3 libdebconfclient0
> >> libgcrypt20 libgpg-error0 liblz4-1 libncursesw5 libsemanage1
> >> libsemanage-common libsystemd0 libudev1 libustr-1.0-1
> >>      I: Found additional base dependencies: adduser
> >> debian-archive-keyring gpgv libapt-pkg5.0 libc-l10n libstdc++6
> >>      I: Checking component main on
> http://ftp.de.debian.org/debian...
> >>      I: Retrieving libacl1 2.2.52-3+b1
> >>      I: Validating libacl1 2.2.52-3+b1
> >>      I: Retrieving adduser 3.115
> >>      I: Validating adduser 3.115
> >>      I: Retrieving apt 1.4.9
> >>      I: Validating apt 1.4.9
> >>      I: Retrieving libapt-pkg5.0 1.4.9
> >>      I: Validating libapt-pkg5.0 1.4.9
> >>      I: Retrieving libattr1 1:2.4.47-2+b2
> >>      I: Validating libattr1 1:2.4.47-2+b2
> >>      I: Retrieving libaudit-common 1:2.6.7-2
> >>      I: Validating libaudit-common 1:2.6.7-2
> >>      I: Retrieving libaudit1 1:2.6.7-2
> >>      I: Validating libaudit1 1:2.6.7-2
> >>      I: Retrieving base-files 9.9+deb9u8
> >>      I: Validating base-files 9.9+deb9u8
> >>      I: Retrieving base-passwd 3.5.43
> >>      I: Validating base-passwd 3.5.43
> >>      I: Retrieving bash 4.4-5
> >>      I: Validating bash 4.4-5
> >>      I: Retrieving libbz2-1.0 1.0.6-8.1
> >>      I: Validating libbz2-1.0 1.0.6-8.1
> >>      I: Retrieving libdebconfclient0 0.227
> >>      I: Validating libdebconfclient0 0.227
> >>      I: Retrieving coreutils 8.26-3
> >>      I: Validating coreutils 8.26-3
> >>      I: Retrieving dash 0.5.8-2.4
> >>      I: Validating dash 0.5.8-2.4
> >>      I: Retrieving libdb5.3 5.3.28-12+deb9u1
> >>      I: Validating libdb5.3 5.3.28-12+deb9u1
> >>      I: Retrieving debconf 1.5.61
> >>      I: Validating debconf 1.5.61
> >>      I: Retrieving debian-archive-keyring 2017.5
> >>      I: Validating debian-archive-keyring 2017.5
> >>      I: Retrieving debianutils 4.8.1.1
> >>      I: Validating debianutils 4.8.1.1
> >>      I: Retrieving diffutils 1:3.5-3
> >>      I: Validating diffutils 1:3.5-3
> >>      I: Retrieving dpkg 1.18.25
> >>      I: Validating dpkg 1.18.25
> >>      I: Retrieving e2fslibs 1.43.4-2
> >>      I: Validating e2fslibs 1.43.4-2
> >>      I: Retrieving e2fsprogs 1.43.4-2
> >>      I: Validating e2fsprogs 1.43.4-2
> >>      I: Retrieving libcomerr2 1.43.4-2
> >>      I: Validating libcomerr2 1.43.4-2
> >>      I: Retrieving libss2 1.43.4-2
> >>      I: Validating libss2 1.43.4-2
> >>      I: Retrieving findutils 4.6.0+git+20161106-2
> >>      I: Validating findutils 4.6.0+git+20161106-2
> >>      I: Retrieving gcc-6-base 6.3.0-18+deb9u1
> >>      I: Validating gcc-6-base 6.3.0-18+deb9u1
> >>      I: Retrieving libgcc1 1:6.3.0-18+deb9u1
> >>      I: Validating libgcc1 1:6.3.0-18+deb9u1
> >>      I: Retrieving libstdc++6 6.3.0-18+deb9u1
> >>      I: Validating libstdc++6 6.3.0-18+deb9u1
> >>      I: Retrieving libc-bin 2.24-11+deb9u4
> >>      I: Validating libc-bin 2.24-11+deb9u4
> >>      I: Retrieving libc-l10n 2.24-11+deb9u4
> >>      I: Validating libc-l10n 2.24-11+deb9u4
> >>      I: Retrieving libc6 2.24-11+deb9u4
> >>      I: Validating libc6 2.24-11+deb9u4
> >>      I: Retrieving locales 2.24-11+deb9u4
> >>      I: Validating locales 2.24-11+deb9u4
> >>      I: Retrieving multiarch-support 2.24-11+deb9u4
> >>      I: Validating multiarch-support 2.24-11+deb9u4
> >>      I: Retrieving gpgv 2.1.18-8~deb9u4
> >>      I: Validating gpgv 2.1.18-8~deb9u4
> >>      I: Retrieving grep 2.27-2
> >>      I: Validating grep 2.27-2
> >>      I: Retrieving gzip 1.6-5+b1
> >>      I: Validating gzip 1.6-5+b1
> >>      I: Retrieving hostname 3.18+b1
> >>      I: Validating hostname 3.18+b1
> >>      I: Retrieving init-system-helpers 1.48
> >>      I: Validating init-system-helpers 1.48
> >>      I: Retrieving libcap-ng0 0.7.7-3+b1
> >>      I: Validating libcap-ng0 0.7.7-3+b1
> >>      I: Retrieving libgcrypt20 1.7.6-2+deb9u3
> >>      I: Validating libgcrypt20 1.7.6-2+deb9u3
> >>      I: Retrieving libgpg-error0 1.26-2
> >>      I: Validating libgpg-error0 1.26-2
> >>      I: Retrieving libselinux1 2.6-3+b3
> >>      I: Validating libselinux1 2.6-3+b3
> >>      I: Retrieving libsemanage-common 2.6-2
> >>      I: Validating libsemanage-common 2.6-2
> >>      I: Retrieving libsemanage1 2.6-2
> >>      I: Validating libsemanage1 2.6-2
> >>      I: Retrieving libsepol1 2.6-2
> >>      I: Validating libsepol1 2.6-2
> >>      I: Retrieving lsb-base 9.20161125
> >>      I: Validating lsb-base 9.20161125
> >>      I: Retrieving liblz4-1 0.0~r131-2+b1
> >>      I: Validating liblz4-1 0.0~r131-2+b1
> >>      I: Retrieving mawk 1.3.3-17+b3
> >>      I: Validating mawk 1.3.3-17+b3
> >>      I: Retrieving libncursesw5 6.0+20161126-1+deb9u2
> >>      I: Validating libncursesw5 6.0+20161126-1+deb9u2
> >>      I: Retrieving libtinfo5 6.0+20161126-1+deb9u2
> >>      I: Validating libtinfo5 6.0+20161126-1+deb9u2
> >>      I: Retrieving ncurses-base 6.0+20161126-1+deb9u2
> >>      I: Validating ncurses-base 6.0+20161126-1+deb9u2
> >>      I: Retrieving ncurses-bin 6.0+20161126-1+deb9u2
> >>      I: Validating ncurses-bin 6.0+20161126-1+deb9u2
> >>      I: Retrieving libpam-modules 1.1.8-3.6
> >>      I: Validating libpam-modules 1.1.8-3.6
> >>      I: Retrieving libpam-modules-bin 1.1.8-3.6
> >>      I: Validating libpam-modules-bin 1.1.8-3.6
> >>      I: Retrieving libpam-runtime 1.1.8-3.6
> >>      I: Validating libpam-runtime 1.1.8-3.6
> >>      I: Retrieving libpam0g 1.1.8-3.6
> >>      I: Validating libpam0g 1.1.8-3.6
> >>      I: Retrieving libpcre3 2:8.39-3
> >>      I: Validating libpcre3 2:8.39-3
> >>      I: Retrieving perl-base 5.24.1-3+deb9u5
> >>      I: Validating perl-base 5.24.1-3+deb9u5
> >>      I: Retrieving sed 4.4-1
> >>      I: Validating sed 4.4-1
> >>      I: Retrieving sensible-utils 0.0.9+deb9u1
> >>      I: Validating sensible-utils 0.0.9+deb9u1
> >>      I: Retrieving login 1:4.4-4.1
> >>      I: Validating login 1:4.4-4.1
> >>      I: Retrieving passwd 1:4.4-4.1
> >>      I: Validating passwd 1:4.4-4.1
> >>      I: Retrieving libsystemd0 232-25+deb9u8
> >>      I: Validating libsystemd0 232-25+deb9u8
> >>      I: Retrieving libudev1 232-25+deb9u8
> >>      I: Validating libudev1 232-25+deb9u8
> >>      I: Retrieving sysvinit-utils 2.88dsf-59.9
> >>      I: Validating sysvinit-utils 2.88dsf-59.9
> >>      I: Retrieving tar 1.29b-1.1
> >>      I: Validating tar 1.29b-1.1
> >>      I: Retrieving tzdata 2018i-0+deb9u1
> >>      I: Validating tzdata 2018i-0+deb9u1
> >>      I: Retrieving libustr-1.0-1 1.0.4-6
> >>      I: Validating libustr-1.0-1 1.0.4-6
> >>      I: Retrieving bsdutils 1:2.29.2-1+deb9u1
> >>      I: Validating bsdutils 1:2.29.2-1+deb9u1
> >>      I: Retrieving libblkid1 2.29.2-1+deb9u1
> >>      I: Validating libblkid1 2.29.2-1+deb9u1
> >>      I: Retrieving libfdisk1 2.29.2-1+deb9u1
> >>      I: Validating libfdisk1 2.29.2-1+deb9u1
> >>      I: Retrieving libmount1 2.29.2-1+deb9u1
> >>      I: Validating libmount1 2.29.2-1+deb9u1
> >>      I: Retrieving libsmartcols1 2.29.2-1+deb9u1
> >>      I: Validating libsmartcols1 2.29.2-1+deb9u1
> >>      I: Retrieving libuuid1 2.29.2-1+deb9u1
> >>      I: Validating libuuid1 2.29.2-1+deb9u1
> >>      I: Retrieving mount 2.29.2-1+deb9u1
> >>      I: Validating mount 2.29.2-1+deb9u1
> >>      I: Retrieving util-linux 2.29.2-1+deb9u1
> >>      I: Validating util-linux 2.29.2-1+deb9u1
> >>      I: Retrieving liblzma5 5.2.2-1.2+b1
> >>      I: Validating liblzma5 5.2.2-1.2+b1
> >>      I: Retrieving zlib1g 1:1.2.8.dfsg-5
> >>      I: Validating zlib1g 1:1.2.8.dfsg-5
> >>      I: Chosen extractor for .deb packages: dpkg-deb
> >>      I: Extracting libacl1...
> >>      I: Extracting libattr1...
> >>      I: Extracting libaudit-common...
> >>      I: Extracting libaudit1...
> >>      I: Extracting base-files...
> >>      I: Extracting base-passwd...
> >>      I: Extracting bash...
> >>      I: Extracting libbz2-1.0...
> >>      I: Extracting libdebconfclient0...
> >>      I: Extracting coreutils...
> >>      I: Extracting dash...
> >>      I: Extracting libdb5.3...
> >>      I: Extracting debconf...
> >>      I: Extracting debianutils...
> >>      I: Extracting diffutils...
> >>      I: Extracting dpkg...
> >>      I: Extracting e2fslibs...
> >>      I: Extracting e2fsprogs...
> >>      I: Extracting libcomerr2...
> >>      I: Extracting libss2...
> >>      I: Extracting findutils...
> >>      I: Extracting gcc-6-base...
> >>      I: Extracting libgcc1...
> >>      I: Extracting libc-bin...
> >>      I: Extracting libc6...
> >>      I: Extracting multiarch-support...
> >>      I: Extracting grep...
> >>      I: Extracting gzip...
> >>      I: Extracting hostname...
> >>      I: Extracting init-system-helpers...
> >>      I: Extracting libcap-ng0...
> >>      I: Extracting libgcrypt20...
> >>      I: Extracting libgpg-error0...
> >>      I: Extracting libselinux1...
> >>      I: Extracting libsemanage-common...
> >>      I: Extracting libsemanage1...
> >>      I: Extracting libsepol1...
> >>      I: Extracting lsb-base...
> >>      I: Extracting liblz4-1...
> >>      I: Extracting mawk...
> >>      I: Extracting libncursesw5...
> >>      I: Extracting libtinfo5...
> >>      I: Extracting ncurses-base...
> >>      I: Extracting ncurses-bin...
> >>      I: Extracting libpam-modules...
> >>      I: Extracting libpam-modules-bin...
> >>      I: Extracting libpam-runtime...
> >>      I: Extracting libpam0g...
> >>      I: Extracting libpcre3...
> >>      I: Extracting perl-base...
> >>      I: Extracting sed...
> >>      I: Extracting sensible-utils...
> >>      I: Extracting login...
> >>      I: Extracting passwd...
> >>      I: Extracting libsystemd0...
> >>      I: Extracting libudev1...
> >>      I: Extracting sysvinit-utils...
> >>      I: Extracting tar...
> >>      I: Extracting tzdata...
> >>      I: Extracting libustr-1.0-1...
> >>      I: Extracting bsdutils...
> >>      I: Extracting libblkid1...
> >>      I: Extracting libfdisk1...
> >>      I: Extracting libmount1...
> >>      I: Extracting libsmartcols1...
> >>      I: Extracting libuuid1...
> >>      I: Extracting mount...
> >>      I: Extracting util-linux...
> >>      I: Extracting liblzma5...
> >>      I: Extracting zlib1g...
> >>      I: Running command: chroot
> >> /work/build/tmp/work/cip-core-armhf/isar-bootstrap-target/rootfs
> >> /debootstrap/debootstrap --second-stage
> >>      chroot: failed to run command ?/debootstrap/debootstrap?: No
> such
> >> file or directory
> 
> This is weird: it's internal to debootstrap, and I don't see why it should
> happen.
> 
> >>      WARNING: exit code 127 from a shell command.
> >>      ERROR: Function failed: do_bootstrap (log file is located at
> >>
> /work/build/tmp/work/cip-core-armhf/isar-bootstrap-target/temp/log.d
> >> o_bootstrap.316)
> >>
> >> Best regards,
> >> Suzuki
> >>
> >>
> >>> -----Original Message-----
> >>> From: Jan Kiszka [mailto:jan.kiszka at siemens.com]
> >>> Sent: Friday, March 15, 2019 7:50 PM
> >>> To: suzuki akihiro(?? ?? ????????)
> >>> <akihiro27.suzuki@toshiba.co.jp>; sangorrin daniel(????? ?
> ?
> >> ?
> >>> ? ????????) <daniel.sangorrin@toshiba.co.jp>;
> >>> SZ.Lin at moxa.com; cip-dev at lists.cip-project.org;
> >>> christian.storm at siemens.com
> >>> Subject: Re: [cip-dev] CIP IRC weekly meeting today
> >>>
> >>> On 15.03.19 10:48, akihiro27.suzuki at toshiba.co.jp wrote:
> >>>> Hi Jan,
> >>>>
> >>>>> On 14.03.19 08:26, daniel.sangorrin at toshiba.co.jp wrote:
> >>>>>> - Suzuki-san has found a couple of issues in ISAR CIP Core.
> >>>>>>      - when building ISAR for the beaglebone black it complains
> that
> >>>>> "/debootstrap/debootstrap is not found" (or something like that).
> >> He
> >>> will
> >>>>> post a new issue on the Gitlab web page with the complete log.
> >>>>>
> >>>>> Has this been resolved locally?
> >>>> When I tried to build isar-cip-core on another 2 machines, the error
> >>> didn't occur.
> >>>> So, my machine which occurred the error may have some problem.
> >>>
> >>> Were you building natively on Debian or inside the kas container?
> >>>
> >>>> I will check it when I have the time.
> >>>
> >>> OK, thanks.
> >>>
> >>> Jan
> >>>
> >>> --
> >>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >>> Corporate Competence Center Embedded Linux
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
