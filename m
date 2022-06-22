Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51878C43334
	for <webhook@archiver.kernel.org>; Wed, 22 Jun 2022 11:52:42 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.6276.1655898757924695282
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jun 2022 04:52:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1C3B61C0B9B; Wed, 22 Jun 2022 13:52:34 +0200 (CEST)
Date: Wed, 22 Jun 2022 13:52:33 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Reported 4.4.y-st issue from Flamefire #cip
Message-ID: <20220622115233.GA7458@duo.ucw.cz>
References: <20220603095930.GA1095@duo.ucw.cz>
 <5284.1655133381155499357@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <5284.1655133381155499357@lists.cip-project.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jun 2022 11:52:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8581


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Unfortunately, mainline seems to be different here. Looking at the
> > code, is min < 0 in your case?
>=20
> yes "min" is negative. IIRC min and max are centered around zero. And as =
linked above a similar function has the adjustment and others independently=
 came up with the same fix. I also verified that it fixes my issue.
>=20

Upstream said this code is correct and affected drivers should be
fixed, instead, so we don't plan to do anything here.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYrMCgQAKCRAw5/Bqldv6
8iADAJkBQyQkeH4192FJ3HaftnAhrIgVHACfcmJVeuVmqJI7Bf6345yyFldzEzQ=
=WjgL
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

