Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ECFC83033
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:12 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.19891.1650538970614055862
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Apr 2022 04:02:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A2EDB1C0B8B; Thu, 21 Apr 2022 13:02:45 +0200 (CEST)
Date: Thu, 21 Apr 2022 13:02:45 +0200
From: Pavel Machek <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 04/24] ASoC: sh: Add RZ/G2L SSIF-2 driver
Message-ID: <20220421110244.GA9759@amd>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220420213424.27837-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYWPR01MB9420CAD2775ACC96157525E292F49@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <OSZPR01MB7019ED6926ED5A3D67B52E66AAF49@OSZPR01MB7019.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: 
 <OSZPR01MB7019ED6926ED5A3D67B52E66AAF49@OSZPR01MB7019.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8160


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I guess there was two comments hidden in the quoted text. I'm not sure
if you noticed them?

Best regards,
								Pavel

> > > +#define SSIFSR_TDC_MASK		0x3f
> > > +#define SSIFSR_TDC_SHIFT	24
> > > +#define SSIFSR_RDC_MASK		0x3f
> > > +#define SSIFSR_RDC_SHIFT	8
> > > +
> > > +#define SSIFSR_TDC(x)		(((x) & 0x1f) << 24)
> >=20
> > This is not used.
> > If you use it, you can use SSIFSR_TDC_SHIFT and SSIFSR_TDC_MASK.
> >=20
> > > +#define SSIFSR_TDE		BIT(16)
> > > +#define SSIFSR_RDC(x)		(((x) & 0x1f) << 8)
> >=20
> > Same above.

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJhOdQACgkQMOfwapXb+vIjVwCdHBBtRDQ9ZQM75jZoqGeGp33s
usYAnReG4H9zFlnqVA5lsxliQNQSvQTP
=8rek
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

