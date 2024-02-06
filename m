Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DFEC48286
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 09:08:24 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.17706.1707210499660555418
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 01:08:20 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4AAC51C0081; Tue,  6 Feb 2024 10:08:17 +0100 (CET)
Date: Tue, 6 Feb 2024 10:08:16 +0100
From: Pavel Machek <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/48] Add support for Renesas RZ/Five RISC-V
 SoC
Message-ID: <ZcH3AJQsUpIUxHoK@duo.ucw.cz>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZcHt3L9g6EtZ1OJj@duo.ucw.cz>
 <OSZPR01MB7019AB3F3CFDE3AEDE0D5F55AA462@OSZPR01MB7019.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8zT5lJAxVjZZEeLc"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB7019AB3F3CFDE3AEDE0D5F55AA462@OSZPR01MB7019.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 09:08:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14777


--8zT5lJAxVjZZEeLc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series aims to add support for Renesas RZ/Five RISC-V SoC,
> > > support for this SoC has already been added to 6.1-cip kernel.
> > >
> > > RFC->v1
> > > * Patch #35 updated according uptstream for easier maitainance.
> > >   Rest of the patches have been unchanged.
> > > * Merged RFC series [0] and preporatory series [1].
> > > * Previous test run results can be found at [2].
> > > * RISC-V Renesas defconfig file can be found at [3].
> >=20
> > I tried to apply/test the series, and besides 1..4 being already applie=
d, these failed, too:
> >=20
> > Can you double-check?
> >=20
> Can you please point me to the pipeline.

git am failed for me, so I don't really have a pipeline. Do I need to
double-check? :-)

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8zT5lJAxVjZZEeLc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcH3AAAKCRAw5/Bqldv6
8mdaAJ9fS+mn+SXAOAFdOxuevxagJT6EnQCcCsZUbktzhMsCSLzkl8w1TY/Cyg8=
=DQlI
-----END PGP SIGNATURE-----

--8zT5lJAxVjZZEeLc--

