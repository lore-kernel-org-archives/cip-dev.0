Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2133C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 08:06:41 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.3706.1702281992837764192
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 00:06:33 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 220461C0050; Mon, 11 Dec 2023 09:06:30 +0100 (CET)
Date: Mon, 11 Dec 2023 09:06:29 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip v2 00/25] Add RZ/G2L DSI support
Message-ID: <ZXbDBXhRRx0PsHzT@duo.ucw.cz>
References: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7/18miR6nzTLRaOl"
Content-Disposition: inline
In-Reply-To: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 08:06:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13996


--7/18miR6nzTLRaOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add RZ/G2L DSI support on
> RZ/{G2L,GLC,V2L} SMARC EVKs.
> =20
> All the patches are cherry-picked from the mainline, except [1] and
> [2]

Thank you, applied and pushed out.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7/18miR6nzTLRaOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXbDBQAKCRAw5/Bqldv6
8qbVAKCqKDupzPkV26IRYbp9evcmy4UAiQCcDD0futFtOEWnHlLWuOxHtbRb83Q=
=5UX9
-----END PGP SIGNATURE-----

--7/18miR6nzTLRaOl--

