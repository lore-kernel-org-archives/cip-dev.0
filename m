From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Tue, 16 Apr 2019 09:08:10 +0000
Subject: [cip-dev] Supported kernel and Debian versions in Isar
In-Reply-To: <55d67dcb-e16f-8e9f-d053-32bf30537ef6@siemens.com>
References: <OSBPR01MB27743E33CB9ED2B9B5885577E12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
	<a3ddd6c7-799b-001f-e134-752766536744@siemens.com>
	<OSBPR01MB2774CEC142FC42D93728BD65E12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
	<4ca0a48f-b728-b7af-eb78-c57f3bf71840@siemens.com>
	<OSBPR01MB27743C65D403FD9027F2CCF9E1280@OSBPR01MB2774.jpnprd01.prod.outlook.com>
	<55d67dcb-e16f-8e9f-d053-32bf30537ef6@siemens.com>
Message-ID: <OSBPR01MB27749C3010936F406CF30EA1E1240@OSBPR01MB2774.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Jan,

> > I'm interested in what kind of variables is appropriate to provide the "options" with kas.
> > The most simple way I can guess is that:
> >
> > * Provide another distro conf (e.g. cip-core_4.19_buster.conf) with the followings
> > 	require conf/distro/debian-buster.conf
> > 	...
> > 	PREFERRED_VERSION_linux-cip ?= "4.19.%"
> > 	PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
> > 	...
> > * Change the default "distro" in kas.yml
> > 	-distro: cip-core
> > 	+distro: cip-core_4.19_buster
> > * The current combination (4.4 + stretch) still available by setting
> > 	KAS_DISTRO="cip-core" (or should be renamed to "cip-core_4.4_stretch" ?)
> >
> > If no objections or other ideas, I would like to create a simple patch to do that.
> 
> I would do the following:
> 
> - define distro/cip-core_stretch.conf and distro/cip-core_buster.conf
> - maybe redefine distro/cip-core.conf as link to stretch today that is going to move to
>   buster once that was released and validated (similar to the default kernel story)
> - define PREFERRED_VERSION_linux-cip to 4.19, maybe in a cip-core-common.conf
> - allow override via kas fragments:
>    - distro: cip-core_buster
>    - PREFERRED_VERSION_linux-cip[-rt] = "4.4.%"

Thank you for your opinion.
I've already created a patch following your proposal and
tried the following three patterns with Isar.
Everything works fine with qemux86-64.

(1) 4.19 + stretch (default)

    $ ./kas-docker --isar build kas.yml:board-qemu-amd64.yml
    $ ./start-qemu.sh x86
    ...
    (login as root)
    # poweroff

(2) 4.19 + buster

    $ cat <<EOF > buster.yml
    header:
      version: 8
    distro: cip-core_buster
    EOF
    $ ./kas-docker --isar build kas.yml:board-qemu-amd64.yml:buster.yml
    <***>
    $ ./start-qemu.sh x86
    ...
    (login as root)
    # poweroff

NOTE: The following replace is required at <***>:
-IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/qemu-${DISTRO_ARCH}/cip-core-image-cip-core-qemu-${DISTRO_ARCH}"
+IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/qemu-${DISTRO_ARCH}/cip-core-image-cip-core_buster-qemu-${DISTRO_ARCH}"

(3) 4.4 + stretch

    $ cat <<EOF > cip-4.4.yml
    header:
      version: 8
    local_conf_header:
      standard: |
        PREFERRED_VERSION_linux-cip = "4.4.%"
        PREFERRED_VERSION_linux-cip-rt = "4.4.%"
    EOF
    $ ./kas-docker --isar build kas.yml:board-qemu-amd64.yml:cip-4.4.yml
    $ ./start-qemu.sh x86
    ...
    (login as root)
    # poweroff

Currently, there is no variable that includes the distro name in start-qemu.sh.
I'm not sure which is better approach:

1. Always use the same image name independent from the Debian version:
   cip-core-image-cip-core-qemu-${DISTRO_ARCH}
2. Add a variable to control Debian version like:
   [ -z "${DISTRO_CODENAME}" ] || DISTR_NAME = "cip-core_${DISTRO_CODENAME}"
   (and use cip-core-image-${DISRO_NAME}-qemu-${DISTRO_ARCH}

I can create the final patch if start-qemu.sh is fixed.

> 
> >
> > In addition, I'm also interested in the appropriate name for "distro"
> > because I'm just considering the branch name for the tiny profile (deby).
> > My first idea is the above. After it's decided,,
> > we can share the common names for specifying the version combinations between the both profiles.
> 
> I think appending the distro version name to the "cip-core" like above is a reasonable approach.

OK, I would like to use the common naming in the tiny profile as well.

Kazu

> 
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
