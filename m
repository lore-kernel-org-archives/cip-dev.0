Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47603C47DB3
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 11:37:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.20685.1706873849339091338
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 03:37:29 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EE9611C0075; Fri,  2 Feb 2024 12:37:26 +0100 (CET)
Date: Fri, 2 Feb 2024 12:37:26 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 4.19.y-cip 0/2] Drop undocumented register definitions
Message-ID: <ZbzT9jzYedKKVbCN@duo.ucw.cz>
References: <20240202103200.171406-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0t8BRLaT1JEG5zhA"
Content-Disposition: inline
In-Reply-To: <20240202103200.171406-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 11:37:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14614


--0t8BRLaT1JEG5zhA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to remove undocumented register definitions on the
> ethernet driver (ravb.h) in 4.19 cip kernel.
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Sergey Shtylyov (1):
>   ravb: update "undocumented" annotations
>=20
> Simon Horman (1):
>   ravb: remove undocumented endianness selection

So the patches look good to me, and they are already present in
5.10+. I guess I can apply them to 4.4 and 4.19 if there are no other
comments and if they pass testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0t8BRLaT1JEG5zhA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZbzT9gAKCRAw5/Bqldv6
8pAPAKC36UggVIc/2/+/9VPIcull2fV7cwCcCQHcPx2zezAOvzT8kqNN7jSHqv4=
=79G0
-----END PGP SIGNATURE-----

--0t8BRLaT1JEG5zhA--

