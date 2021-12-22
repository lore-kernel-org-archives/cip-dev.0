Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACA4C433EF
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 10:24:03 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.17608.1640168641963525265
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 02:24:02 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7D9D01C0B7C; Wed, 22 Dec 2021 11:23:59 +0100 (CET)
Date: Wed, 22 Dec 2021 11:23:58 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/22] RZ/G2L: Add support for
 pinctrl/dmac/iic
Message-ID: <20211222102358.GF15186@amd>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222100628.GE15186@amd>
 <OSZPR01MB7019DBBEC18AC93480A7D503AA7D9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Content-Disposition: inline
In-Reply-To: 
 <OSZPR01MB7019DBBEC18AC93480A7D503AA7D9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 10:24:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7230


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series adds Pinctrl/DMAC/IIC support for Renesas RZ/G2L So=
C.
> > >
> > > All the patches have been cherry picked from v5.16-rc5.
> > >
> > > I have created a MR [0] for cip-kernel-config (for testing purpose),
> > > which can later be merged once this patches have been merged.
> >=20
> > And these are various minor nits I noticed while reviewing the code.
> >=20
> Thank you for the review. Do you want me to collate the changes and
>submit or do you plan to submit them?

I'd preffer you to submit them.

Thank you,
								Pavel
							=09

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHC/L4ACgkQMOfwapXb+vJuaACeN4l5oWe5U7vfqpwvQI+2Up81
xlMAn2iy7EBS1tIsOlHZbfnZXLaXwpv/
=RVo9
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--

