Return-Path: <florian.bezdeka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3A7D21699
	for <webhook@archiver.kernel.org>; Tue, 15 Oct 2024 12:28:05 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.12138.1728995275804265202
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Oct 2024 05:27:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=florian.bezdeka@siemens.com header.s=fm2 header.b=UA6t4ZGj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-68982-20241015122752b81007946e6fd1a2a6-g1vrp3@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20241015122752b81007946e6fd1a2a6
        for <cip-dev@lists.cip-project.org>;
        Tue, 15 Oct 2024 14:27:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Rt30nuDH9f4utYkJ+JirWtO1aaZvla50hTj9HdXKLl4=;
 b=UA6t4ZGj6/emLm+FydYAPJJGhtP9lGCjqHo5qWKEhxMzw4TuSRj54jIgPINZNvTYPbfUCd
 OmqOOX0iEmz7xodL21K46sn/bgifMLRtucMPjoH7ghdNAxakE1pu50b7AKWIe1KSp+oOokZu
 ZnVveuM1YJEKAx78VZ8dhm4Jz7FhWAg1cZ5+elda0hi5JnKE5kOFA2undUnGQDDveP9+V1WR
 ngOi9NkUw0VLgz7++Oi6Z5br78rwB0Rs7/CVqgHH1KHlVwppMVYjrbX+rmSc9YnlpohVgmiN
 y0GkqMdpgkn8DuNM0EXNTVaIXzj4+EiLr4jcUyiaTvq8ZXdGrvvE++MA==;
Message-ID: <739eeffd9c49aa0a138752eba0ff861702ce3907.camel@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH] distro: add preliminary
 support for the upcoming Debian 13 (trixie)
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: cip-dev@lists.cip-project.org, Cedric Hombourger
	 <cedric.hombourger@siemens.com>
Date: Tue, 15 Oct 2024 14:27:50 +0200
In-Reply-To: <d59b93d9-44a0-4adf-bb7a-c97d12e1c1b9@siemens.com>
References: <20241014155604.569003-1-cedric.hombourger@siemens.com>
	 <d59b93d9-44a0-4adf-bb7a-c97d12e1c1b9@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Oct 2024 12:28:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17039

On Tue, 2024-10-15 at 00:22 +0200, Jan Kiszka via lists.cip-project.org
wrote:
> On 14.10.24 17:56, Cedric Hombourger wrote:
> > Debian will probably start freezing packages next year (first a soft fr=
eeze
> > then a hard freeze). It is important that the CIP community starts test=
ing
> > Debian 13 to provide feedback upstream while we may still influence ver=
sions
> > that the distribution will select for their new major version.
> >=20
> > Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
> > ---
> >  Kconfig                                          |  5 +++++
> >  conf/distro/cip-core-trixie.conf                 | 16 ++++++++++++++++
> >  kas/opt/trixie.yml                               | 15 +++++++++++++++
> >  .../secure-boot-secrets/files/trixie             |  1 +
> >  .../swupdate-certificates/files/trixie           |  1 +
> >  5 files changed, 38 insertions(+)
> >  create mode 100644 conf/distro/cip-core-trixie.conf
> >  create mode 100644 kas/opt/trixie.yml
> >  create mode 120000 recipes-devtools/secure-boot-secrets/files/trixie
> >  create mode 120000 recipes-devtools/swupdate-certificates/files/trixie
> >=20
> > diff --git a/Kconfig b/Kconfig
> > index a70ce22..9b15c05 100644
> > --- a/Kconfig
> > +++ b/Kconfig
> > @@ -136,6 +136,10 @@ config DEBIAN_BOOKWORM
> >  	bool "bookworm (12)"
> >  	depends on !ARCH_RISCV64
> > =20
> > +config DEBIAN_TRIXIE
> > +	bool "trixie (testing)"
> > +	depends on !ARCH_RISCV64
>=20
> That is obsolete once trixie is stable enough. In fact, being able to
> finally build RISC-V via trixie, rather than a sid snapshot, would be a
> good indicator that it is worth to start regular testing.
>=20
> > +
> >  config DEBIAN_SID
> >  	bool "sid (unstable)"
> >  	depends on ARCH_RISCV64
> > @@ -147,6 +151,7 @@ config KAS_INCLUDE_DEBIAN
> >  	default "kas/opt/buster.yml" if DEBIAN_BUSTER
> >  	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
> >  	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
> > +	default "kas/opt/trixie.yml" if DEBIAN_TRIXIE
> >  	default "kas/opt/sid.yml" if DEBIAN_SID
> > =20
> >  comment "Image features"
> > diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-tr=
ixie.conf
> > new file mode 100644
> > index 0000000..58999d1
> > --- /dev/null
> > +++ b/conf/distro/cip-core-trixie.conf
> > @@ -0,0 +1,16 @@
> > +#
> > +# CIP Core, generic profile
> > +#
> > +# Copyright (c) Siemens AG, 2024
> > +#
> > +# Authors:
> > +#  Cedric Hombourger <cedric.hombourger@siemens.com>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +
> > +require conf/distro/debian-trixie.conf
> > +require cip-core-common.inc
> > +
> > +PREFERRED_VERSION_linux-cip ?=3D "6.1.%"
> > +PREFERRED_VERSION_linux-cip-rt ?=3D "6.1.%"
>=20
> That will likely change before the release but we indeed started with an
> older kernel into bookworm as well.
>=20
> > diff --git a/kas/opt/trixie.yml b/kas/opt/trixie.yml
> > new file mode 100644
> > index 0000000..e9a76ef
> > --- /dev/null
> > +++ b/kas/opt/trixie.yml
> > @@ -0,0 +1,15 @@
> > +#
> > +# CIP Core, generic profile
> > +#
> > +# Copyright (c) Siemens AG, 2024
> > +#
> > +# Authors:
> > +#  Cedric Hombourger <cedric.hombourger@siemens.com>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +
> > +header:
> > +  version: 14
> > +
> > +distro: cip-core-trixie
> > diff --git a/recipes-devtools/secure-boot-secrets/files/trixie b/recipe=
s-devtools/secure-boot-secrets/files/trixie
> > new file mode 120000
> > index 0000000..91bf492
> > --- /dev/null
> > +++ b/recipes-devtools/secure-boot-secrets/files/trixie
> > @@ -0,0 +1 @@
> > +bullseye
> > \ No newline at end of file
> > diff --git a/recipes-devtools/swupdate-certificates/files/trixie b/reci=
pes-devtools/swupdate-certificates/files/trixie
> > new file mode 120000
> > index 0000000..3d633ae
> > --- /dev/null
> > +++ b/recipes-devtools/swupdate-certificates/files/trixie
> > @@ -0,0 +1 @@
> > +../../secure-boot-secrets/files/trixie
> > \ No newline at end of file
>=20
> As Florian already mentioned, some minimal cross-compilation stability
> is required as we cannot wait for hours on emulated native builds. There
> is also [1] waiting for a fix so that our core features can be tested.
> And there might be more.

Btw: Isn't that something that should go into isar directly? Why is
Trixie support isar-cip-core specific?

Florian

>=20
> Jan
>=20
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/114
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center


