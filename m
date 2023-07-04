Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB336EB64D9
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 20:18:21 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2861.1688501892477202250
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jul 2023 13:18:12 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 12BC31C0DE7; Tue,  4 Jul 2023 22:18:10 +0200 (CEST)
Date: Tue, 4 Jul 2023 22:18:09 +0200
From: Pavel Machek <pavel@denx.de>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
Subject: Re: [PATCH 5.10.y-cip 2/4] soc: renesas: Add PWC support for RZ/V2M
Message-ID: <ZKR+gX4mNSKrfZes@duo.ucw.cz>
References: <20230703170211.15484-1-fabrizio.castro.jz@renesas.com>
 <20230703170211.15484-3-fabrizio.castro.jz@renesas.com>
 <TYWPR01MB9420F2EADFD20272DE1E5588922EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <TYWPR01MB87752AFE6723CB34DCF625C1C22EA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IHYFo70SM2OOwHmN"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB87752AFE6723CB34DCF625C1C22EA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 20:18:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12220


--IHYFo70SM2OOwHmN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +static int rzv2m_pwc_probe(struct platform_device *pdev) {
> > > +	struct rzv2m_pwc_priv *priv;
> > > +	char symname[KSYM_NAME_LEN];
> >=20
> > It's not a big, but we can declare symname in ' if (pm_power_off) {'.
> >=20
>=20
> I'll send a v2 for this, no problem at all

Thank you, but I believe we should take the orignal version (and wait
for the cleanup to reach mainline, first).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--IHYFo70SM2OOwHmN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZKR+gQAKCRAw5/Bqldv6
8uy6AJ0UKdqYJM+DI4mnmvX8Z7f37krE3ACcD07wn3a8zI7lF5nyPO1Xt8l1cR8=
=ABoV
-----END PGP SIGNATURE-----

--IHYFo70SM2OOwHmN--

