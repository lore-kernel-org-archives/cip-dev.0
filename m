Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F03C27C77
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 19:11:01 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2258.1718392251765871714
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jun 2024 12:10:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DAF121C009D; Fri, 14 Jun 2024 21:10:47 +0200 (CEST)
Date: Fri, 14 Jun 2024 21:10:47 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 0/7] Fix USBHS pipe configuration
Message-ID: <ZmyVtx1/PP3UDUKp@duo.ucw.cz>
References: <20240613104453.422524-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB638888EC53BD628A80B32F2C92C22@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K/XVCAllJ0wz40VU"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB638888EC53BD628A80B32F2C92C22@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 19:11:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16257


--K/XVCAllJ0wz40VU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Fix the USBHS Pipe configuration
> >=20
> > All the patches are cherry-picked from the mainline.
> >=20
> > Biju Das (6):
> >   dt-bindings: usb: renesas,usbhs: Document RZ/G2L family compatible
> >   usb: renesas_usbhs: Simplify obtaining device data
> >   usb: renesas_usbhs: Improve usbhsc_default_pipe[] for isochronous
> >     transfers
> >   usb: renesas_usbhs: Update usbhs pipe configuration for RZ/G2L family
> >   usb: renesas_usbhs: Remove trailing comma in the terminator entry for
> >     OF table
> >   arm64: dts: renesas: r9a07g0{43,44,54}: Update RZ/G2L family
> >     compatible
> >=20
> > Lad Prabhakar (1):
> >   dt-bindings: usb: renesas,usbhs: Document RZ/Five SoC
>=20
> I reviewed this series, LGTM.
> I can apppy this series, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review, I added your reviewed-by tag and applied the
series.

Best regards,
								Pavel    =20
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--K/XVCAllJ0wz40VU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmyVtwAKCRAw5/Bqldv6
8gFXAKCnb9V2C67cmxkX3r90iTqCRx+0TwCeNxPQhFFIHVbjbx1vaOgDb06RDUk=
=ustx
-----END PGP SIGNATURE-----

--K/XVCAllJ0wz40VU--

