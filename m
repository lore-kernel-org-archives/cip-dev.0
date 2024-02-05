Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E54C4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 10:15:05 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.60089.1707128097669918010
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 02:14:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 23B671C0050; Mon,  5 Feb 2024 11:14:55 +0100 (CET)
Date: Mon, 5 Feb 2024 11:14:54 +0100
From: Pavel Machek <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [RFC PATCH 5.10.y-cip 00/39] Add support for Renesas RZ/Five
 RISC-V SoC
Message-ID: <ZcC1HtNcQJ4dhXNX@duo.ucw.cz>
References: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZbowIA9sDtDExkBU@duo.ucw.cz>
 <OSZPR01MB70199E2D7FE8CF56D5536481AA472@OSZPR01MB7019.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YcF913QNczor/6P1"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB70199E2D7FE8CF56D5536481AA472@OSZPR01MB7019.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 10:15:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14663


--YcF913QNczor/6P1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series aims to add support for Renesas RZ/Five RISC-V SoC,
> > > support for this SoC has already been added to 6.1-cip kernel.
> > >
> > > Sending this series as an RFC as,
> > > 1] Support for Global DMA cohernet pool is added 2] As support for
> > > non-coherent DMA is missing for RISC-V core,
> > >    required changes have been added directly in ax45mp_cache.c
> > >    (ie patch #26)
> > > 3] Patch #26 has been newly added, rest of the patches have been
> > >    cherry-picked from upstream kernel.
> >=20
> > I quickly went through this, and found nothing too crazy. But as this a=
dds whole new architecture into
> > 5.10-cip, I guess I should get confirmation on the IRC. We'll also need=
 to add this (and RISC-V qemu)
> > to 5.10 testing.
> >=20
> Now that we have agreed for RISC-V support on 5.10-cip, shall I send non =
RFC series?

It will be same as RFC series, right? :-). So I guess no need to do
that, I believe we can just review and apply this one.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YcF913QNczor/6P1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcC1HgAKCRAw5/Bqldv6
8rWJAKCOBj9Sw5z6s9gk1mGGhtCJ9KoPnwCgw25EOSRjE5GwaeamEGXVnugSiZk=
=2V5b
-----END PGP SIGNATURE-----

--YcF913QNczor/6P1--

