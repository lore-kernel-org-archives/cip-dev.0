Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1BAC001E0
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 14:11:27 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.14798.1689775876651893170
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jul 2023 07:11:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 022FF1C0A97; Wed, 19 Jul 2023 16:11:13 +0200 (CEST)
Date: Wed, 19 Jul 2023 16:11:12 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/6]  Add RZ/{G2L,G2LC,V2L} MTU3 PWM support.
Message-ID: <ZLfvACwmys4CMRdk@duo.ucw.cz>
References: <20230718141129.119809-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGht8STdr9TUJ0TS"
Content-Disposition: inline
In-Reply-To: <20230718141129.119809-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 14:11:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12434


--MGht8STdr9TUJ0TS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add support for RZ/{G2L,G2LC,V2L}
> MTU3 PWM driver.
>=20
> All the patches are cherry-picked from the mainline
> except patch#4-patch#6. The trivial patches#4-#6 are
> cherry-picked from next.

So... this is similar to 5.10, and same comments apply except that
WARN_ON. They are details that should not block merge.

But we really should not be merging patches that are not yet upstream
(because policy and because the commit numbers would change).

So I'd propose testing this and then merging all the patches that are
mainline (for both this and 5.10 series), unless there are other
comments.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--MGht8STdr9TUJ0TS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLfvAAAKCRAw5/Bqldv6
8ogmAJ9N72vU9YnE0Fip0FdWJUTTploCgwCfS/srUXXeCxUYpWggFGCwX40xMpI=
=NClp
-----END PGP SIGNATURE-----

--MGht8STdr9TUJ0TS--

