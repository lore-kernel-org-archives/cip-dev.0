Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7588FC001B0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 10:14:18 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.157644.1692180847597427421
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 03:14:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9DB231C0006; Wed, 16 Aug 2023 12:14:03 +0200 (CEST)
Date: Wed, 16 Aug 2023 12:14:02 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/2] Enable PMU support for RZ/{G2L,G2LC,V2L}
 SoCs
Message-ID: <ZNyhaqoh6F7UKe4n@duo.ucw.cz>
References: <20230816071239.3310-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZyzqFOhxW24dC7Yw"
Content-Disposition: inline
In-Reply-To: <20230816071239.3310-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 10:14:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12664


--ZyzqFOhxW24dC7Yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to enable PMU support for RZ/{G2L,G2LC,V2L}
> SoCs.
> =20
> All the patches are cherry-picked from the mainline.
>=20
> Lad Prabhakar (2):
>   arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
>   arm64: dts: renesas: r9a07g054: Add Cortex-A55 PMU node

This looks okay and passes testing, so I can apply it if there are no
other comments. 5.10 version looks okay, too. Consider sending both
5.10 and 6.1 versions in one email in cases like this :-).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ZyzqFOhxW24dC7Yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZNyhagAKCRAw5/Bqldv6
8kV/AJ9qaZgM2bnigPUA5RZdqjUWdFF+7ACgpYKY6Hqx/DA1CPnMKSiVXjHl6T8=
=Ktse
-----END PGP SIGNATURE-----

--ZyzqFOhxW24dC7Yw--

