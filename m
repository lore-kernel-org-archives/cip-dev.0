Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD24EB8FAD
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 08:18:20 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.3687.1693988296093294314
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 01:18:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 91B5C1C000B; Wed,  6 Sep 2023 10:18:12 +0200 (CEST)
Date: Wed, 6 Sep 2023 10:18:12 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 13/20] arm64: dts: renesas: rzg2lc-smarc: Link
 DSI with ADV7535
Message-ID: <ZPg1xFmaspa3vHKU@duo.ucw.cz>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
 <20230905160737.167877-14-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4I+ddbfxtDMz+Pel"
Content-Disposition: inline
In-Reply-To: <20230905160737.167877-14-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 08:18:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12977


--4I+ddbfxtDMz+Pel
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 961eed28296853a81d792654f392773800df91db upstream.
>=20
> Enable DSI and ADV7535 and link DSI with ADV7535 on RZ/G2LC SMARC EVK.

There seems to be a bit of duplication between different dts
fragments. Would it make sense to put common parts into dtsi
somewhere?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4I+ddbfxtDMz+Pel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZPg1xAAKCRAw5/Bqldv6
8k42AJ9kQVilbVZWv1EzzSp1TXLbzWgxTACggb60gJ/6BOfzV1OxaR6Khsh2ZKI=
=wj2H
-----END PGP SIGNATURE-----

--4I+ddbfxtDMz+Pel--

