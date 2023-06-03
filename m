Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42021C77B73
	for <webhook@archiver.kernel.org>; Sat,  3 Jun 2023 09:29:14 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.8706.1685784550730783385
 for <cip-dev@lists.cip-project.org>;
 Sat, 03 Jun 2023 02:29:11 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E23301C0CB6; Sat,  3 Jun 2023 11:29:07 +0200 (CEST)
Date: Sat, 3 Jun 2023 11:29:05 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/19] Add RZ/V2M USB3.1 support
Message-ID: <ZHsH4ZHYNlRxiWh3@duo.ucw.cz>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fa7vQ91+wSYM+zQT"
Content-Disposition: inline
In-Reply-To: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 03 Jun 2023 09:29:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11751


--Fa7vQ91+wSYM+zQT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add USB3.1 support for RZ/V2M EVK platform
>=20
> All these patches are cherry-picked from the mainline.

Patches look ok to me. I can apply them if they pass testing and if
there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Fa7vQ91+wSYM+zQT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZHsH4QAKCRAw5/Bqldv6
8jG9AJ4mq2LEagKcZG+5is+QOjWBEhRGsQCfb6U8VUn2C47bpFc4di3aw8sS1Is=
=g17O
-----END PGP SIGNATURE-----

--Fa7vQ91+wSYM+zQT--

