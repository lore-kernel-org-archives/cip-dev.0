From: kazuhiro.fujita.jg@renesas.com (Kazuhiro Fujita)
Date: Fri, 22 Feb 2019 01:55:12 +0000
Subject: [cip-dev] CIP core tiny profile package list
In-Reply-To: <OSBPR01MB499913CE0591EDF6B6A4D58AD97F0@OSBPR01MB4999.jpnprd01.prod.outlook.com>
References: <OSAPR01MB37631F440E9797217D08C46BD06D0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<OSBPR01MB526959EAEE4BDD2478B20B45D9690@OSBPR01MB5269.jpnprd01.prod.outlook.com>
	<OSAPR01MB3763BDC120D4301A99F37B8FD0660@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<OSAPR01MB3763870E217D0A694E598D51D0660@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<OSBPR01MB4999A16BF9C169007A062D3FD9630@OSBPR01MB4999.jpnprd01.prod.outlook.com>
	<OSBPR01MB49994A87D84918D2C146B29CD97E0@OSBPR01MB4999.jpnprd01.prod.outlook.com>
	<OSAPR01MB37633FE18450CDFE4A9A7900D07E0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<OSBPR01MB49992E20CE88D2AF16C5E709D97E0@OSBPR01MB4999.jpnprd01.prod.outlook.com>
	<TY2PR01MB2201DEE3598B8E9C8FA5DD5DC67E0@TY2PR01MB2201.jpnprd01.prod.outlook.com>
	<OSBPR01MB499913CE0591EDF6B6A4D58AD97F0@OSBPR01MB4999.jpnprd01.prod.outlook.com>
Message-ID: <OSBPR01MB499902FA76A23BFAD31292CAD97F0@OSBPR01MB4999.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Daniel,

> > > One question. Do your application use all those commands (e.g. in a
> > > script) or just for login/monitoring/debugging?

I picked up the commands used in /etc/init.d scrips in our BSP.
This is not a complete list, but it may help our discussion.

awk, cat, date, depmod, dmesg, echo, grep, halt, hostname, hwclock, 
ifdown, ifup, killall5, ln, mknod, modprobe, mount, rmmod, rpcbind, 
sed, sleep, sort, swapoff, swapon, sysctl, test, umask, umount, uniq

Regards,
Fujita


> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-
> project.org> On Behalf Of Kazuhiro Fujita
> Sent: Friday, February 22, 2019 10:28 AM
> To: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] CIP core tiny profile package list
> 
> Hello Hung-san, Daniel,
> 
> Do you have any idea which commands should be included in tiny profile?
> Should tiny profile to support only network and local storage?
> If so, these may classify like this:
>     Tiny profile only: ethtool, linuxptp, e2fsprogs, dosfstools, iproute2
>     Tiny and basic profile: v4l-utils, i2c-tools, can-utils, usbutils,
> pciutils, alsa-utils
> 
> Regards,
> Fujita
> 
> 
> > -----Original Message-----
> > From: Hung Tran <hung.tran.jy@renesas.com>
> > Sent: Thursday, February 21, 2019 4:12 PM
> > To: Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>; cip-dev at lists.cip-
> > project.org
> > Subject: RE: CIP core tiny profile package list
> >
> > Hello Fujita-san, Daniel,
> > Cc all,
> >
> > We usually need to include below tools to support testing related
> > hardware/driver.
> > It would be good for us if CIP Core include them:
> > 	v4l-utils, i2c-tools, ethtool, linuxptp, e2fsprogs, dosfstools, can-
> > utils, iproute2, usbutils, pciutils, alsa-utils
> >
> > Regards,
> > Hung.
> >
> > -----Original Message-----
> > From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-
> > bounces at lists.cip-project.org] On Behalf Of Kazuhiro Fujita
> > Sent: Thursday, February 21, 2019 12:27 PM
> > To: cip-dev at lists.cip-project.org
> > Subject: Re: [cip-dev] CIP core tiny profile package list
> >
> > Hello Daniel, all,
> >
> > > Did I miss scottk comment?
> > Oh, the email was delivered directly to me.
> >
> > > One question. Do your application use all those commands (e.g. in a
> > > script) or just for login/monitoring/debugging?
> > These are mainly used for login/monitoring/debugging, but some are used
> > also in scripts.
> >
> > By the way, my colleague pointed out that the almost all commands I
> listed
> > are supported by busybox.
> >
> >   https://busybox.net/downloads/BusyBox.html
> >
> > Dear all:
> > Is there a command which is not in busybox but CIP should maintain?
> > How about these commands?
> > 	file, shutdown, iptables, printenv, setenv, view, ...
> >
> > Regards,
> > Fujita
> >
> >
> > > -----Original Message-----
> > > From: daniel.sangorrin at toshiba.co.jp <daniel.sangorrin@toshiba.co.jp>
> > > Sent: Thursday, February 21, 2019 10:57 AM
> > > To: Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>;
> > > cip-dev at lists.cip- project.org
> > > Subject: RE: CIP core tiny profile package list
> > >
> > > Fujita-san
> > >
> > > > -----Original Message-----
> > > > From: cip-dev-bounces at lists.cip-project.org
> > > > <cip-dev-bounces@lists.cip-
> > > project.org> On Behalf Of Kazuhiro
> > > > Fujita
> > > > Sent: Thursday, February 21, 2019 10:42 AM
> > > > To: cip-dev at lists.cip-project.org
> > > > Subject: Re: [cip-dev] CIP core tiny profile package list
> > > >
> > > > Hello Daniel, all,
> > > >
> > > > > I'll try to make short list what command we always use and share
> > > > > with
> > > you.
> > > >
> > > > Below are the popular commands we use on target boards.
> > > > # scottk: thank you for comment
> > >
> > > Did I miss scottk comment?
> > >
> > > > awk, cat, cd, chgrp, chmod, chown, cp, date, dd, df, diff, dirs,
> > > > dmesg, du, echo, export, file, find, grep, gunzip, gzip, halt, head,
> > > > history, ifconfig, ip, iptables, kill, less, ln, ls, make, mkdir,
> > > > more, mount, mv, nc, popd, printenv, ps, pushd, pwd, reboot, rm,
> > > > rmdir, sed, set, setenv, shutdown, su, sync, tail, tar, top, umount,
> > > > uname, vi, view, xargs
> > > >
> > > > This list includes shell internal commands. (sorry for
> > > > inconvenience) Is there any other important one I forgot?
> > >
> > > One question. Do your application use all those commands (e.g. in a
> > > script) or just for login/monitoring/debugging?
> > >
> > > Thanks,
> > > Daniel
> > >
> > >
> > > >
> > > > Regards,
> > > > Fujita
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: cip-dev-bounces at lists.cip-project.org <cip-dev-
> > > bounces at lists.cip-
> > > > > project.org> On Behalf Of Kazuhiro Fujita
> > > > > Sent: Monday, February 18, 2019 7:44 PM
> > > > > To: cip-dev at lists.cip-project.org
> > > > > Subject: Re: [cip-dev] CIP core tiny profile package list
> > > > >
> > > > > Hello Daniel,
> > > > >
> > > > > Sorry for late reply.
> > > > >
> > > > > > > Also, I think that this functionality is usually required as
> > well:
> > > > > > > - enable development of applications written in C or C++ (no
> > > python,
> > > > > > java, nodejs, ruby..)
> > > > > > > - support the CIP real-time kernel
> > > > >
> > > > > > > - a minimum level of security: this needs to be studied but i
> > > propose
> > > > > > something below
> > > > > > > 	- smack
> > > > > > > 	- a firewall utility
> > > > >
> > > > > > > I think iptables can be useful to create a simple firewall.
> > > > >
> > > > > I agree all above points.
> > > > >
> > > > > > > - ability to use typical commands on shell scripts (grep, cat,
> > > > > > > nc,
> > > > > > iptables, ..)
> > > > > > > - monitor the status of the system (top, ..)
> > > > >
> > > > > The point we should discuss is here.
> > > > > I'll try to make short list what command we always use and share
> > > > > with
> > > you.
> > > > >
> > > > > Kind regards,
> > > > > Fujita
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: daniel.sangorrin at toshiba.co.jp
> > > <daniel.sangorrin@toshiba.co.jp>
> > > > > > Sent: Wednesday, February 13, 2019 10:35 AM
> > > > > > To: daniel.sangorrin at toshiba.co.jp; Kazuhiro Fujita
> > > > > > <kazuhiro.fujita.jg@renesas.com>; cip-dev at lists.cip-project.org
> > > > > > Subject: RE: CIP core tiny profile package list
> > > > > >
> > > > > > Maybe we also want to have CURL (or libcurl) for devices that
> > > > > > need
> > > to
> > > > > > interact with servers.
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: cip-dev-bounces at lists.cip-project.org <cip-dev-
> > > > > bounces at lists.cip-
> > > > > > project.org> On Behalf Of
> > > > > > > daniel.sangorrin at toshiba.co.jp
> > > > > > > Sent: Wednesday, February 13, 2019 10:29 AM
> > > > > > > To: kazuhiro.fujita.jg at renesas.com;
> > > > > > > cip-dev at lists.cip-project.org
> > > > > > > Subject: Re: [cip-dev] CIP core tiny profile package list
> > > > > > >
> > > > > > > Fujita-san
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: cip-dev-bounces at lists.cip-project.org <cip-dev-
> > > > > > bounces at lists.cip-project.org> On Behalf Of Kazuhiro
> > > > > > > > Fujita
> > > > > > > > Sent: Friday, February 8, 2019 1:40 PM
> > > > > > > > To: cip-dev at lists.cip-project.org
> > > > > > > > Subject: Re: [cip-dev] CIP core tiny profile package list
> > > > > > > >
> > > > > > > > Hello Daniel, all,
> > > > > > > >
> > > > > > > > I compared your rootfs-summary.csv and Yocto(poky)'s
> > > > > > > > core-image-
> > > > > > minimal
> > > > > > > > and found some major components are not included in the
> rootfs.
> > > > > > > > For example: dbus, pam, systemd, udev
> > > > > > >
> > > > > > > Yes, I think they are not essential. The tiny profile tool may
> > > offer
> > > > > > them, but they are not strictly required.
> > > > > > >
> > > > > > > > I think this result reflected policies for the tiny profile.
> > > > > > > > I anticipate tiny profile let us:
> > > > > > > >  - boot boards
> > > > > > > >  - login via network and serial console
> > > > > > > >  - copy files from network
> > > > > > > > All other functions are supported in the generic profile.
> > > > > > >
> > > > > > > Agreed.
> > > > > > >
> > > > > > > Also, I think that this functionality is usually required as
> > well:
> > > > > > > - enable development of applications written in C or C++ (no
> > > python,
> > > > > > java, nodejs, ruby..)
> > > > > > > - support the CIP real-time kernel
> > > > > > > - ability to use typical commands on shell scripts (grep, cat,
> > > > > > > nc,
> > > > > > iptables, ..)
> > > > > > > - monitor the status of the system (top, ..)
> > > > > > > - a minimum level of security: this needs to be studied but i
> > > propose
> > > > > > something below
> > > > > > > 	- smack
> > > > > > > 	- a firewall utility
> > > > > > >
> > > > > > > > If this is correct, in my opinion, dropbear and busybox are
> > > enough
> > > > > > > > for these components.
> > > > > > >
> > > > > > > Thanks. I think busybox is an OS in itself. Maybe we need to
> > > discuss
> > > > > > busybox commands in more detail.
> > > > > > >
> > > > > > > > 	openssh-server \ <-- this one or dropbear?
> > > > > > > > 	bash \ <-- or only busybox sh?
> > > > > > > > 	procps \ <-- or busybox ps?
> > > > > > > > 	findutils \ <-- or busybox find?
> > > > > > > yes, we can just use busybox version (with limitations)
> > > > > > >
> > > > > > > > And these are not mandatory for the tiny profile.
> > > > > > > > 	iproute2 \ <-- required?
> > > > > > > > 	iptables \ <-- required?
> > > > > > > > 	gawk \ <-- required?
> > > > > > > I think iptables can be useful to create a simple firewall.
> > > > > > >
> > > > > > > Best regards,
> > > > > > > Daniel
> > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: cip-dev-bounces at lists.cip-project.org <cip-dev-
> > > > > > bounces at lists.cip-
> > > > > > > > > project.org> On Behalf Of daniel.sangorrin at toshiba.co.jp
> > > > > > > > > Sent: Monday, February 4, 2019 6:48 PM
> > > > > > > > > To: cip-dev at lists.cip-project.org
> > > > > > > > > Subject: [cip-dev] CIP core tiny profile package list
> > > > > > > > >
> > > > > > > > > Hello CIPers ;)
> > > > > > > > >
> > > > > > > > > A long time ago [1] we discussed about the packages that
> > > should be
> > > > > > > > > included in CIP Core. Back then, we didn't have two
> > > > > > > > > profiles
> > > yet
> > > > > > (tiny and
> > > > > > > > > generic). For that reason, we ended up with a list that
> > > > > > > > > was
> > > good
> > > > > for
> > > > > > the
> > > > > > > > > generic profile but not specific enough for the tiny
> profile.
> > > I
> > > > > > wanted to
> > > > > > > > > re-start that activity but focusing on the tiny profile.
> > > > > > > > >
> > > > > > > > > First, I will start with the goal which is to create lists
> > > > > > > > > of
> > > > > > packages to
> > > > > > > > > standarize the CIP core tiny profile. In particular, I
> > > > > > > > > want to
> > > > > have
> > > > > > these
> > > > > > > > > lists:
> > > > > > > > >
> > > > > > > > > - Minimal binaries list: list of binary packages (eg.: oe
> > > names)
> > > > > > that are
> > > > > > > > > always included in the base layer.
> > > > > > > > > 	- this list is useful information for application
> > > > > > compatibility
> > > > > > > > > 	- it must be supported by all build systems claiming to
> > > be
> > > > > > tiny-
> > > > > > > > > profile-compatible.
> > > > > > > > > 	- it is useful to explain what the base layer is
> > > > > > > > > 	- for example, in [2] this refers to the following
> > > packages
> > > > > > > > > # system requirements
> > > > > > > > > PKG_SYSTEM = "\
> > > > > > > > > 	busybox \
> > > > > > > > > 	init-files \
> > > > > > > > > 	glib-2.0 \
> > > > > > > > > 	libgcc \
> > > > > > > > > 	libstdc++ \
> > > > > > > > > "
> > > > > > > > > # minimum package list
> > > > > > > > > # TODO: agree on cip-core tiny profile minimal list
> > > > > > > > > PKG_MIN = "\
> > > > > > > > > 	openssh-server \ <-- this one or dropbear?
> > > > > > > > > 	openssh-client \
> > > > > > > > > 	gzip \
> > > > > > > > > 	e2fsprogs \
> > > > > > > > > 	libaio \
> > > > > > > > > 	wget \ <-- wget or curl, or both?
> > > > > > > > > 	curl \
> > > > > > > > > 	bash \ <-- or only busybox sh?
> > > > > > > > > 	procps \ <-- or busybox ps?
> > > > > > > > > 	coreutils \
> > > > > > > > > 	findutils \ <-- or busybox find?
> > > > > > > > > 	iproute2 \ <-- required?
> > > > > > > > > 	iptables \ <-- required?
> > > > > > > > > 	gawk \ <-- required?
> > > > > > > > > "
> > > > > > > > >
> > > > > > > > > - Extra binaries list: list of binary packages (e.g oe
> > > > > > > > > names)
> > > that
> > > > > > are
> > > > > > > > > also available as recipes
> > > > > > > > > 	- this is a list of packages that is also backed by
> > > long-term
> > > > > > > > > supported Debian source packages
> > > > > > > > > 	- it is a list that will depend on the image build
> > > system
> > > > > > > > > 	- for example, in meta-debian the list would come from
> > > the
> > > > > > folder
> > > > > > > > > [3]
> > > > > > > > > 	- they are optional (good to have), not required for
> > > being cip
> > > > > > tiny-
> > > > > > > > > profile compatible
> > > > > > > > >
> > > > > > > > > - Sources list: list of Debian source packages required to
> > > build
> > > > > the
> > > > > > base
> > > > > > > > > layer
> > > > > > > > > 	- useful for maintenance (e.g.: create a list for Debian
> > > LTS)
> > > > > > > > > 	- ideally auto-generated by the build tool
> > > > > > > > > 	- the list must include the source of binary package
> > > > > > dependencies
> > > > > > > > > (optionally separated)
> > > > > > > > > 	- it must include the sources of the tools required to
> > > build
> > > > > > the
> > > > > > > > > rootfs as well (e.g. cross sdk)
> > > > > > > > >
> > > > > > > > > Ultimately, I want to be able to define what packages a
> > > > > > > > > CIP
> > > tiny
> > > > > > profile
> > > > > > > > > base layer must offer, no matter what build tool is used.
> > > > > > > > > The build tool will add dependencies, but that is
> > > > > > > > > something
> > > > > > automatic, I
> > > > > > > > > want to focus on the package names that one would write in
> > [2].
> > > > > > > > > As an example, Deby currently generates the attached files
> > > > > > > > > for
> > > the
> > > > > > iwg22m
> > > > > > > > > board:
> > > > > > > > > - rootfs-summary.csv (binaries list): this is a list of
> > > > > > > > > binary
> > > > > > packages
> > > > > > > > > (yocto names) included in the final image. It includes the
> > > > > packages
> > > > > > > > > defined in [2] and its runtime dependencies. (NOTE: I
> > > > > > > > > forgot
> > > to
> > > > > > remove the
> > > > > > > > > DEBUG packages)
> > > > > > > > > - git.list.github.com (sources list): this is a list of
> > > > > > > > > Debian
> > > > > > source
> > > > > > > > > packages including to source code corresponding to the
> > > > > > > > > binary
> > > > > > packages in
> > > > > > > > > the rootfs, AND the source code of the host tools (e.g.
> > > > > > > > > gcc)
> > > > > > > > >
> > > > > > > > > NEXT STEPS: feedback on the "minimal binaries list"
> > > > > > > > >
> > > > > > > > > [1] Previous discussions
> > > > > > > > > - Criteria to prioritize security fixes
> > > > > > > > >   Ref: https://lists.cip-project.org/mailman/private/cip-
> > > > > > members/2018-
> > > > > > > > > June/001365.html
> > > > > > > > >   Ref:
> > > > > > > > > https://lists.cip-project.org/pipermail/cip-dev/2018-
> > > > > > > > > July/001398.html
> > > > > > > > >   Ref:
> > > > > > > > > https://lists.cip-project.org/pipermail/cip-dev/2018-
> > > > > > > > > July/001411.html
> > > > > > > > > - Packages sorted out by criteria.
> > > > > > > > >   Ref: https://lists.cip-project.org/mailman/private/cip-
> > > > > > members/2018-
> > > > > > > > > June/001367.html (hitachi)
> > > > > > > > >   Ref: https://lists.cip-project.org/mailman/private/cip-
> > > > > > members/2018-
> > > > > > > > > July/001374.html (renesas) [2]
> > > > > > > > > https://gitlab.com/cip-project/cip-
> > > > > > core/deby/blob/master/poky/meta-
> > > > > > > > > cip-common/recipes-core/packagegroups/packagegroup-core-
> > > > > > boot.bbappend
> > > > > > > > > [3] https://github.com/meta-debian/meta-
> > > debian/tree/morty/recipes-
> > > > > > debian
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Daniel
> > > > > > > > _______________________________________________
> > > > > > > > cip-dev mailing list
> > > > > > > > cip-dev at lists.cip-project.org
> > > > > > > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > > > > > > _______________________________________________
> > > > > > > cip-dev mailing list
> > > > > > > cip-dev at lists.cip-project.org
> > > > > > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > > > > _______________________________________________
> > > > > cip-dev mailing list
> > > > > cip-dev at lists.cip-project.org
> > > > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > > > _______________________________________________
> > > > cip-dev mailing list
> > > > cip-dev at lists.cip-project.org
> > > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
