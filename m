Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA4EC27C7A
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 11:01:58 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.184524.1692270114559058709
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 04:01:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6AAB81C0004; Thu, 17 Aug 2023 13:01:52 +0200 (CEST)
Date: Thu, 17 Aug 2023 13:01:51 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/13] Add Renesas PMIC RAA215300 driver and
 builtin RTC support
Message-ID: <ZN3+H+qd8KdWEssz@duo.ucw.cz>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="498spmJGK4K5Don5"
Content-Disposition: inline
In-Reply-To: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 11:01:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12753


--498spmJGK4K5Don5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add PMIC RAA215300 driver and builtin RTC suppo=
rt
> =20
> All the patches are cherry-picked from the mainline except the last
> 3 patches.

I reviewed the patches, and am currently running tests. I'll have some
comments on patches, but nothing that should stop the merge; I can
merge the first 10 patches if there are no other comments and if
testing passes.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--498spmJGK4K5Don5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZN3+HwAKCRAw5/Bqldv6
8kB6AKCmYMtvaItKXF2lIwbgIEvmJbPWbwCdH/8mKNCuqKCwppZThhYAXOW4T0g=
=1+iD
-----END PGP SIGNATURE-----

--498spmJGK4K5Don5--

