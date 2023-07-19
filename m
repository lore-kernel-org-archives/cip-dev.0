Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83C9C001B0
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 14:06:46 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.14597.1689775595862749793
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jul 2023 07:06:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 631FA1C0AA0; Wed, 19 Jul 2023 16:06:34 +0200 (CEST)
Date: Wed, 19 Jul 2023 16:06:33 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 05/13] mfd: Add Renesas RZ/G2L MTU3a core
 driver
Message-ID: <ZLft6RjBqxtdb/Cq@duo.ucw.cz>
References: <20230718140608.119449-1-biju.das.jz@bp.renesas.com>
 <20230718140608.119449-6-biju.das.jz@bp.renesas.com>
 <ZLfX6EeK4JPuOsqZ@duo.ucw.cz>
 <OS0PR01MB5922D9826D87474A68DAD8308639A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iz1j9rtqPNfUD/iG"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922D9826D87474A68DAD8308639A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 14:06:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12433


--iz1j9rtqPNfUD/iG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +static inline void rz_mtu3_release_channel(struct rz_mtu3_channel
> > > +*ch) {
> > > +	mutex_lock(&ch->lock);
> > > +	ch->is_busy =3D false;
> > > +	mutex_unlock(&ch->lock);
> > > +}
> >=20
> > mutex is really wrong primitive for this. Use test_and_set_bit() and
> > clear_bit instead?
>=20
> You mean in this context, better primitive is atomic variable rather than=
 mutex??

atomic variable would be an improvement, too. But I meant
test_and_set_bit() and clear_bit(). They operate on bitmap, aka
unsigned long, IIRC.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--iz1j9rtqPNfUD/iG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLft6QAKCRAw5/Bqldv6
8of2AJ9X8i6nkIUXDqxs1zmgI+INLilLIACeOBWmIN2gESKqa76UilUJp5Dm74o=
=MVsP
-----END PGP SIGNATURE-----

--iz1j9rtqPNfUD/iG--

