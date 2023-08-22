Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D0AEE49A3
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 08:20:27 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.3761.1692692418234626849
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Aug 2023 01:20:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A03731C000B; Tue, 22 Aug 2023 10:20:15 +0200 (CEST)
Date: Tue, 22 Aug 2023 10:20:15 +0200
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/14] Add Renesas PMIC RAA215300 driver and
 builtin RTC support
Message-ID: <ZORvv2i2Z/vWmQTz@duo.ucw.cz>
References: <20230818092807.159112-1-biju.das.jz@bp.renesas.com>
 <ZOD5IfjHUF5l1COI@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7m/6BIHfECWsZqUA"
Content-Disposition: inline
In-Reply-To: <ZOD5IfjHUF5l1COI@duo.ucw.cz>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 08:20:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12815


--7m/6BIHfECWsZqUA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to add PMIC RAA215300 driver and builtin RTC sup=
port
> >=20
> > All the patches are cherry-picked from the mainline except the last
> > 3 patches.
> >=20
> > The last 3 patches are from next and just added here for testing.
>=20
> Thanks for the updated series. As far as I can see, patches are same
> as the 6.1 version and as upstream, with one addition of "rtc:
> isl1208: quiet maybe-unused variable warning". That made review easy.
>=20
> I'm okay with applying these (except last three), provided there are
> no other comments and provided it passes testing.

Thank you, applied all but the last 3.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7m/6BIHfECWsZqUA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZORvvwAKCRAw5/Bqldv6
8pSGAJ90F4HvfNBGo9tyI+MALWsHB0IEhQCffx79pbaPjehe/0I39Tv/pLjIHfI=
=WXEC
-----END PGP SIGNATURE-----

--7m/6BIHfECWsZqUA--

