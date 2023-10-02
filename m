Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647A8E77378
	for <webhook@archiver.kernel.org>; Mon,  2 Oct 2023 20:40:48 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.93648.1696279243313464255
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Oct 2023 13:40:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 750221C0065; Mon,  2 Oct 2023 22:40:40 +0200 (CEST)
Date: Mon, 2 Oct 2023 22:40:39 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 5.10.y-cip] arm64: dts: renesas: rzg2l: Fix
 txdv-skew-psec typos
Message-ID: <ZRsqx6rKJ6oKanAS@duo.ucw.cz>
References: <20231002145644.5771-1-chris.paterson2@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JfWDZelTpP8fWp2k"
Content-Disposition: inline
In-Reply-To: <20231002145644.5771-1-chris.paterson2@renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Oct 2023 20:40:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13262


--JfWDZelTpP8fWp2k
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

Looks ok to me. I can apply it provided there are no other comments
and that it passes testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JfWDZelTpP8fWp2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZRsqxwAKCRAw5/Bqldv6
8nO2AJ4njFaf3BIV6B9fIqi4eaGkHHuHaACgsdkLgN/tAV9zIhiLlisaXH9y1yA=
=UwkR
-----END PGP SIGNATURE-----

--JfWDZelTpP8fWp2k--

