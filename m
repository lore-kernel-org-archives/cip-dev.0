Return-Path: <florian.bezdeka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9328C38142
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 12:20:13 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.10346.1675167611024652194
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Jan 2023 04:20:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=florian.bezdeka@siemens.com header.s=fm1 header.b=poTOrMOo;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-68982-20230131122008b2db70d50f088719c9-tb52xl@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230131122008b2db70d50f088719c9
        for <cip-dev@lists.cip-project.org>;
        Tue, 31 Jan 2023 13:20:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EpLxDdNxinSiwCgftN7yI9Fs44MsLGwqjCAT7rUGKEQ=;
 b=poTOrMOoD/Crn+niZE+0+JPus+EIADADSvvy9l9cPij8ZIiAUSC0MAghJq2Z7Aq53ni23n
 WsUN//+08DoCwyl3zgyI/Jse0znRJx6bK/7mG96hTAy9MKHFiRDtKf+Gwlg1NKgRpGG2qlec
 turoIFzu90+R509rO2dPKDLlvPJV8=;
Message-ID: <04ad45dd7d2d86046a77e4dfec13e4283a7622bb.camel@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH] Add bookworm
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: cip-dev@lists.cip-project.org, Quirin Gylstorff
	 <Quirin.Gylstorff@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 31 Jan 2023 13:20:07 +0100
In-Reply-To: <6fc061ea-a0b6-13f8-e1e8-50840d4c8622@siemens.com>
References: <20230130113412.628646-1-Quirin.Gylstorff@siemens.com>
	 <6fc061ea-a0b6-13f8-e1e8-50840d4c8622@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 12:20:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10523

On Tue, 2023-01-31 at 11:54 +0100, Jan Kiszka via lists.cip-project.org
wrote:
> On 30.01.23 12:34, Quirin Gylstorff wrote:
> > From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> >=20
> > This will add prelimitary support for the debian 12 aka bookworm.

I was triggered by the subject of this patch. Why do we re-add the
bookworm distribution when it's already available in Isar itself?

Maybe rephrase to something like "enable tests for bookworm" or "enable
building images based on bookworm"?

> >=20
> > Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> > ---
> >  .gitlab-ci.yml                       | 45 ++++++++++++++++++++++++++++
> >  Kconfig                              |  5 ++++
> >  conf/distro/cip-core-bookworm.conf   | 17 +++++++++++
> >  kas/opt/bookworm.yml                 | 15 ++++++++++
> >  recipes-core/images/efibootguard.inc |  6 ++--
> >  recipes-core/images/swupdate.inc     |  6 +++-
> >  6 files changed, 91 insertions(+), 3 deletions(-)
> >  create mode 100644 conf/distro/cip-core-bookworm.conf
> >  create mode 100644 kas/opt/bookworm.yml
> >=20
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index f7c8c88..2b9505d 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -37,6 +37,7 @@ default:
> >      - if [ "${targz}" =3D "enable" ]; then base_yaml=3D"${base_yaml}:k=
as/opt/targz-img.yml"; fi
> >      - if [ "${release}" =3D "buster" ]; then base_yaml=3D"${base_yaml}=
:kas/opt/buster.yml"; fi
> >      - if [ "${release}" =3D "bullseye" ]; then base_yaml=3D"${base_yam=
l}:kas/opt/bullseye.yml"; fi
> > +    - if [ "${release}" =3D "bookworm" ]; then base_yaml=3D"${base_yam=
l}:kas/opt/bookworm.yml"; fi
> >      - echo "Building ${base_yaml}"
> >      - kas build ${base_yaml}
> >      - if [ "${deploy}" =3D "enable" ]; then scripts/deploy-cip-core.sh=
 ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
> > @@ -281,3 +282,47 @@ build:qemu-amd64-secure-boot-buster:
> >      use_rt: disable
> >      wic_targz: disable
> >      deploy: disable
> > +
> > +# bookworm images
> > +build:simatic-ipc227e-bookworm:
> > +  extends:
> > +    - .build_base
> > +  variables:
> > +    target: simatic-ipc227e
> > +    release: bookworm
> > +
> > +build:bbb-bookworm:
> > +  extends:
> > +    - .build_base
> > +  variables:
> > +    target: bbb
> > +    dtb: am335x-boneblack.dtb
> > +    release: bookworm
> > +
> > +build:iwg20m-bookworm:
> > +  extends:
> > +    - .build_base
> > +  variables:
> > +    target: iwg20m
> > +    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
> > +    release: bookworm
> > +
> > +build:hihope-rzg2m-bookworm:
> > +  extends:
> > +    - .build_base
> > +  variables:
> > +    target: hihope-rzg2m
> > +    dtb: r8a774a1-hihope-rzg2m-ex.dtb
> > +    release: bookworm
> > +
> > +build:qemu-amd64-secure-boot-bookworm:
> > +  extends:
> > +    - .build_base
> > +  variables:
> > +    base_yaml: "kas-cip.yml:kas/board/${target}.yml:kas/opt/5.10.yml"
>=20
> I don't think we need pin to 5.10 here. Once there is a 6.1 option, it
> will be preferred for bookworm, and this may just be forgotten to be
> dropped.
>=20
> > +    release: bookworm
> > +    target: qemu-amd64
> > +    extension: ebg-secure-boot-snakeoil
> > +    use_rt: disable
> > +    wic_targz: disable
> > +    deploy: disable
> > diff --git a/Kconfig b/Kconfig
> > index cd24ce2..87056b9 100644
> > --- a/Kconfig
> > +++ b/Kconfig
> > @@ -128,6 +128,10 @@ config DEBIAN_BULLSEYE
> >  	bool "bullseye (11)"
> >  	depends on !ARCH_RISCV64
> > =20
> > +config DEBIAN_BOOKWORM
> > +	bool "bookworm (12)"
> > +	depends on !ARCH_RISCV64
> > +
> >  config DEBIAN_SID_PORTS
> >  	bool "sid (unstable) with unofficial ports"
> >  	depends on ARCH_RISCV64
> > @@ -138,6 +142,7 @@ config KAS_INCLUDE_DEBIAN
> >  	string
> >  	default "kas/opt/buster.yml" if DEBIAN_BUSTER
> >  	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
> > +	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
> >  	default "kas/opt/sid-ports.yml" if DEBIAN_SID_PORTS
> > =20
> >  comment "Image features"
> > diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-=
bookworm.conf
> > new file mode 100644
> > index 0000000..86c97a1
> > --- /dev/null
> > +++ b/conf/distro/cip-core-bookworm.conf
> > @@ -0,0 +1,17 @@
> > +#
> > +# CIP Core, generic profile
> > +#
> > +# Copyright (c) Siemens AG, 2023
> > +#
> > +# Authors:
> > +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +
> > +require conf/distro/debian-bookworm.conf
> > +require cip-core-common.inc
> > +
> > +PREFERRED_VERSION_efibootguard ?=3D "0.13.%"
> > +PREFERRED_VERSION_linux-cip ?=3D "5.10.%"
> > +PREFERRED_VERSION_linux-cip-rt ?=3D "5.10.%"
> > diff --git a/kas/opt/bookworm.yml b/kas/opt/bookworm.yml
> > new file mode 100644
> > index 0000000..8b4431b
> > --- /dev/null
> > +++ b/kas/opt/bookworm.yml
> > @@ -0,0 +1,15 @@
> > +#
> > +# CIP Core, generic profile
> > +#
> > +# Copyright (c) Siemens AG, 2023
> > +#
> > +# Authors:
> > +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +
> > +header:
> > +  version: 12
> > +
> > +distro: cip-core-bookworm
> > diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images=
/efibootguard.inc
> > index eace4fd..d8d3a06 100644
> > --- a/recipes-core/images/efibootguard.inc
> > +++ b/recipes-core/images/efibootguard.inc
> > @@ -8,8 +8,10 @@
> >  #
> >  # SPDX-License-Identifier: MIT
> >  #
> > -
>=20
> Please keep.
>=20
> > -IMAGE_INSTALL_append =3D " efibootguard"
> > +OVERRIDES_append =3D ":${BASE_DISTRO_CODENAME}"
>=20
> Blank line here, also to be consistent.
>=20
> > +IMAGE_PREINSTALL_append_bookworm +=3D " efibootguard"
> > +IMAGE_INSTALL_append_bullseye +=3D " efibootguard"
> > +IMAGE_INSTALL_append_buster +=3D " efibootguard"
>=20
> +=3D does not make sense together with "_append".
>=20
> > =20
> >  WIC_IMAGER_INSTALL_append =3D " efibootguard"
> >  WDOG_TIMEOUT ?=3D "60"
> > diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swu=
pdate.inc
> > index 9b2aedc..a47928a 100644
> > --- a/recipes-core/images/swupdate.inc
> > +++ b/recipes-core/images/swupdate.inc
> > @@ -13,7 +13,11 @@ inherit image_uuid
> >  inherit swupdate
> >  inherit read-only-rootfs
> > =20
> > -IMAGE_INSTALL +=3D " swupdate"
> > +OVERRIDES_append =3D ":${BASE_DISTRO_CODENAME}"
> > +
> > +IMAGE_PREINSTALL_append_bookworm +=3D " swupdate"
> > +IMAGE_INSTALL_append_bullseye +=3D " swupdate"
> > +IMAGE_INSTALL_append_buster +=3D " swupdate"
>=20
> Same here.
>=20
> >  IMAGE_INSTALL +=3D " swupdate-handler-roundrobin"
> > =20
> >  ROOTFS_PARTITION_NAME =3D "${IMAGE_FULLNAME}.wic.p4.gz"
>=20
> Jan
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#10520): https://lists.cip-project.org/g/cip-dev/messa=
ge/10520
> Mute This Topic: https://lists.cip-project.org/mt/96625657/5792637
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/9882880/579263=
7/2090341516/xyzzy [florian.bezdeka@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


