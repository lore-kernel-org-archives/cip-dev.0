From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Wed, 13 Feb 2019 01:29:02 +0000
Subject: [cip-dev] CIP core tiny profile package list
In-Reply-To: <OSBPR01MB526959EAEE4BDD2478B20B45D9690@OSBPR01MB5269.jpnprd01.prod.outlook.com>
References: <OSAPR01MB37631F440E9797217D08C46BD06D0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<OSBPR01MB526959EAEE4BDD2478B20B45D9690@OSBPR01MB5269.jpnprd01.prod.outlook.com>
Message-ID: <OSAPR01MB3763BDC120D4301A99F37B8FD0660@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Fujita-san

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-project.org> On Behalf Of Kazuhiro
> Fujita
> Sent: Friday, February 8, 2019 1:40 PM
> To: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] CIP core tiny profile package list
> 
> Hello Daniel, all,
> 
> I compared your rootfs-summary.csv and Yocto(poky)'s core-image-minimal
> and found some major components are not included in the rootfs.
> For example: dbus, pam, systemd, udev

Yes, I think they are not essential. The tiny profile tool may offer them, but they are not strictly required.

> I think this result reflected policies for the tiny profile.
> I anticipate tiny profile let us:
>  - boot boards
>  - login via network and serial console
>  - copy files from network
> All other functions are supported in the generic profile.

Agreed.

Also, I think that this functionality is usually required as well:
- enable development of applications written in C or C++ (no python, java, nodejs, ruby..)
- support the CIP real-time kernel
- ability to use typical commands on shell scripts (grep, cat, nc, iptables, ..)
- monitor the status of the system (top, ..)
- a minimum level of security: this needs to be studied but i propose something below
	- smack
	- a firewall utility

> If this is correct, in my opinion, dropbear and busybox are enough
> for these components.

Thanks. I think busybox is an OS in itself. Maybe we need to discuss busybox commands in more detail.

> 	openssh-server \ <-- this one or dropbear?
> 	bash \ <-- or only busybox sh?
> 	procps \ <-- or busybox ps?
> 	findutils \ <-- or busybox find?
yes, we can just use busybox version (with limitations)

> And these are not mandatory for the tiny profile.
> 	iproute2 \ <-- required?
> 	iptables \ <-- required?
> 	gawk \ <-- required?
I think iptables can be useful to create a simple firewall.

Best regards,
Daniel

> > -----Original Message-----
> > From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-
> > project.org> On Behalf Of daniel.sangorrin at toshiba.co.jp
> > Sent: Monday, February 4, 2019 6:48 PM
> > To: cip-dev at lists.cip-project.org
> > Subject: [cip-dev] CIP core tiny profile package list
> >
> > Hello CIPers ;)
> >
> > A long time ago [1] we discussed about the packages that should be
> > included in CIP Core. Back then, we didn't have two profiles yet (tiny and
> > generic). For that reason, we ended up with a list that was good for the
> > generic profile but not specific enough for the tiny profile. I wanted to
> > re-start that activity but focusing on the tiny profile.
> >
> > First, I will start with the goal which is to create lists of packages to
> > standarize the CIP core tiny profile. In particular, I want to have these
> > lists:
> >
> > - Minimal binaries list: list of binary packages (eg.: oe names) that are
> > always included in the base layer.
> > 	- this list is useful information for application compatibility
> > 	- it must be supported by all build systems claiming to be tiny-
> > profile-compatible.
> > 	- it is useful to explain what the base layer is
> > 	- for example, in [2] this refers to the following packages
> > # system requirements
> > PKG_SYSTEM = "\
> > 	busybox \
> > 	init-files \
> > 	glib-2.0 \
> > 	libgcc \
> > 	libstdc++ \
> > "
> > # minimum package list
> > # TODO: agree on cip-core tiny profile minimal list
> > PKG_MIN = "\
> > 	openssh-server \ <-- this one or dropbear?
> > 	openssh-client \
> > 	gzip \
> > 	e2fsprogs \
> > 	libaio \
> > 	wget \ <-- wget or curl, or both?
> > 	curl \
> > 	bash \ <-- or only busybox sh?
> > 	procps \ <-- or busybox ps?
> > 	coreutils \
> > 	findutils \ <-- or busybox find?
> > 	iproute2 \ <-- required?
> > 	iptables \ <-- required?
> > 	gawk \ <-- required?
> > "
> >
> > - Extra binaries list: list of binary packages (e.g oe names) that are
> > also available as recipes
> > 	- this is a list of packages that is also backed by long-term
> > supported Debian source packages
> > 	- it is a list that will depend on the image build system
> > 	- for example, in meta-debian the list would come from the folder
> > [3]
> > 	- they are optional (good to have), not required for being cip tiny-
> > profile compatible
> >
> > - Sources list: list of Debian source packages required to build the base
> > layer
> > 	- useful for maintenance (e.g.: create a list for Debian LTS)
> > 	- ideally auto-generated by the build tool
> > 	- the list must include the source of binary package dependencies
> > (optionally separated)
> > 	- it must include the sources of the tools required to build the
> > rootfs as well (e.g. cross sdk)
> >
> > Ultimately, I want to be able to define what packages a CIP tiny profile
> > base layer must offer, no matter what build tool is used.
> > The build tool will add dependencies, but that is something automatic, I
> > want to focus on the package names that one would write in [2].
> > As an example, Deby currently generates the attached files for the iwg22m
> > board:
> > - rootfs-summary.csv (binaries list): this is a list of binary packages
> > (yocto names) included in the final image. It includes the packages
> > defined in [2] and its runtime dependencies. (NOTE: I forgot to remove the
> > DEBUG packages)
> > - git.list.github.com (sources list): this is a list of Debian source
> > packages including to source code corresponding to the binary packages in
> > the rootfs, AND the source code of the host tools (e.g. gcc)
> >
> > NEXT STEPS: feedback on the "minimal binaries list"
> >
> > [1] Previous discussions
> > - Criteria to prioritize security fixes
> >   Ref: https://lists.cip-project.org/mailman/private/cip-members/2018-
> > June/001365.html
> >   Ref: https://lists.cip-project.org/pipermail/cip-dev/2018-
> > July/001398.html
> >   Ref: https://lists.cip-project.org/pipermail/cip-dev/2018-
> > July/001411.html
> > - Packages sorted out by criteria.
> >   Ref: https://lists.cip-project.org/mailman/private/cip-members/2018-
> > June/001367.html (hitachi)
> >   Ref: https://lists.cip-project.org/mailman/private/cip-members/2018-
> > July/001374.html (renesas)
> > [2] https://gitlab.com/cip-project/cip-core/deby/blob/master/poky/meta-
> > cip-common/recipes-core/packagegroups/packagegroup-core-boot.bbappend
> > [3] https://github.com/meta-debian/meta-debian/tree/morty/recipes-debian
> >
> > Thanks,
> > Daniel
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
