Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34813C7EE29
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 10:31:48 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.10001.1686306701681290161
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jun 2023 03:31:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 94BCF1C0E4E; Fri,  9 Jun 2023 12:31:38 +0200 (CEST)
Date: Fri, 9 Jun 2023 12:31:38 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 3/8] mfd: Add Renesas RZ/G2L MTU3a core driver
Message-ID: <ZIL/itcJvV5s3Bnf@duo.ucw.cz>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
 <20230606075235.183132-4-biju.das.jz@bp.renesas.com>
 <ZH8DnHZb8dDrq+Zm@duo.ucw.cz>
 <OS0PR01MB592237E5932B612CC5D4B4EB8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4EiYnZVD0F8Q+bcB"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB592237E5932B612CC5D4B4EB8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 10:31:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11931


--4EiYnZVD0F8Q+bcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > The 8/16/32 bit registers are mixed in each channel.
> > >
> > > Add MTU3a core driver for RZ/G2L SoC. The core driver shares the clk
> > > and channel register access for the other child devices like Counter,
> > > PWM and Clock event.
> >=20
> > > +struct rz_mtu3_priv {
> > > +	void __iomem *mmio;
> > > +	struct reset_control *rstc;
> > > +	raw_spinlock_t lock;
> > > +};
> >=20
> > Why is raw_spinlock used here? This is not really a core code... this
> > makes analysis for rt safety more interesting.
>=20
> I just used the spinlock variant used in regmap for concurrent access from
> different drivers.
>=20
> Do you see any issues here?

I guess regmap has to use it due to something critical (timer?) using
regmap.

raw_spin_lock:

+ better performance if used correctly on -rt kernel

- harder to analyse

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4EiYnZVD0F8Q+bcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIL/igAKCRAw5/Bqldv6
8ikSAJ9WPpOzBmYdAR5zMWSX/lyypDKa+gCeLt/cK3eQBusjCVA8nAkb2mKmDeE=
=RHmo
-----END PGP SIGNATURE-----

--4EiYnZVD0F8Q+bcB--

