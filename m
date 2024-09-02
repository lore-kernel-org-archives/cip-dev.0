Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06544CD3420
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 09:57:08 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.35236.1725271025216887692
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Sep 2024 02:57:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id ADC4B1C009A; Mon,  2 Sep 2024 11:57:03 +0200 (CEST)
Date: Mon, 2 Sep 2024 11:57:03 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 08/30] media: dt-bindings: Document
 Renesas RZ/G2L CRU block
Message-ID: <ZtWL7+rn3kQgfYVS@duo.ucw.cz>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
 <20240805164342.211857-9-biju.das.jz@bp.renesas.com>
 <ZtWJqOdRxkBkUb9y@duo.ucw.cz>
 <TY3PR01MB1134657025BC48D12CE94672186922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+SnU2Ex5Y/yp0yu/"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB1134657025BC48D12CE94672186922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Sep 2024 09:57:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16839


--+SnU2Ex5Y/yp0yu/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +description:
> > > +  The CRU image processing module is a data conversion module equipp=
ed with pixel
> > > +  color space conversion, LUT, pixel format conversion, etc. An MIPI=
 CSI-2 input and
> > > +  parallel (including ITU-R BT.656) input are provided as the image =
sensor interface.
> >=20
> > input -> inputs?
>=20
> OK.
>=20
> >=20
> > > +  clocks:
> > > +    items:
> > > +      - description: CRU Main clock
> >=20
> > Main -> main?
>=20
> OK.
> >=20
> > > +      - description: CRU Register access clock
> >=20
> > Register -> register?
>=20
> Ok.
>=20
> Will fix this in mainline.

Thank you. These are just nitpicks I noticed during review, and then
had them in "I should post this".

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+SnU2Ex5Y/yp0yu/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZtWL7wAKCRAw5/Bqldv6
8s0AAKCyW++m2PA6uRr69GKjT2KQ3qsN7wCeO9f2sRroj50ArMnVlbPeofRNMBk=
=E3v9
-----END PGP SIGNATURE-----

--+SnU2Ex5Y/yp0yu/--

