Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D026E7B5E3
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 10:04:09 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.14790.1696413811589938421
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Oct 2023 03:03:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D223F1C004C; Wed,  4 Oct 2023 12:03:28 +0200 (CEST)
Date: Wed, 4 Oct 2023 12:03:28 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <chris.paterson2@renesas.com>
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 5.10.y-cip] arm64: dts: renesas: rzg2l: Fix
 txdv-skew-psec typos
Message-ID: <ZR04cKJEfjfkD7Sm@duo.ucw.cz>
References: <20231002145644.5771-1-chris.paterson2@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WSOHpAgP8DtwVs8u"
Content-Disposition: inline
In-Reply-To: <20231002145644.5771-1-chris.paterson2@renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 10:04:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13266


--WSOHpAgP8DtwVs8u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit db67345716a52abb750ec8f76d6a5675218715f9 upstream.
>=20
> It looks like txdv-skew-psec is a typo from a copy+paste. txdv-skew-psec
> is not present in the PHY bindings nor is it in the driver.
>=20
> Correct to txen-skew-psec which is clearly what it was meant to be.
>=20
> Given that the default for txen-skew-psec is 0, and the device tree is
> only trying to set it to 0 anyway, there should not be any functional
> change from this fix.

Thank you, applied.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--WSOHpAgP8DtwVs8u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZR04cAAKCRAw5/Bqldv6
8mYjAKCvpxGeHIvBKm3IwqgGSnBaiSVxmwCgwBEizzO6+Kxk9/UtyguT6YCNIaw=
=8cul
-----END PGP SIGNATURE-----

--WSOHpAgP8DtwVs8u--

