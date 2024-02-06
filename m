Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01743C4828D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 10:50:15 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.18834.1707216612534636103
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 02:50:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F11C21C0081; Tue,  6 Feb 2024 11:50:09 +0100 (CET)
Date: Tue, 6 Feb 2024 11:50:09 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/6] Versa3 clk driver improvements
Message-ID: <ZcIO4WHHMj0ZYZxR@duo.ucw.cz>
References: <20240202122338.309435-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLwjP6kmsi7G2UKt"
Content-Disposition: inline
In-Reply-To: <20240202122338.309435-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 10:50:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14781


--yLwjP6kmsi7G2UKt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to improve versa3 clock driver.
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Biju Das (6):
>   arm64: defconfig: Enable Renesas VersaClock 3 clock generator config
>   clk: versaclock3: Update vc3_get_div() to avoid divide by zero
>   clk: versaclock3: Avoid unnecessary padding
>   clk: versaclock3: Use u8 return type for get_parent() callback
>   clk: versaclock3: Add missing space between ')' and '{'
>   clk: versaclock3: Drop ret variable

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yLwjP6kmsi7G2UKt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcIO4QAKCRAw5/Bqldv6
8s1eAJ9mPcsHkv4koZpgmxziEyESVToQTQCdGEwN27/Zia7UThi56QyUiNDNOao=
=quTb
-----END PGP SIGNATURE-----

--yLwjP6kmsi7G2UKt--

