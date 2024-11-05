Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E621D1268A
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 11:19:48 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.15402.1730805583765265382
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Nov 2024 03:19:44 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8E6011C00B2; Tue,  5 Nov 2024 12:19:40 +0100 (CET)
Date: Tue, 5 Nov 2024 12:19:40 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 5.10.y-cip 00/28] Add CRU, CSI support for Renesas
 RZ/{G2L, V2L} SoCs
Message-ID: <Zyn/TJ1DMQZNzk6R@duo.ucw.cz>
References: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jgmgc6/N1boMAz6c"
Content-Disposition: inline
In-Reply-To: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Nov 2024 11:19:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17171


--Jgmgc6/N1boMAz6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add support for CRU and CSI drivers for the
> Renesas RZ/G2L SoC.
>=20
> All the patches have been cherry-picked from upstream kernel.

Thanks for the series. I'll have some minor comments, but I can apply
this if there are no other comments and it passes testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Jgmgc6/N1boMAz6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZyn/TAAKCRAw5/Bqldv6
8u2WAJ0Trq4/TpOZeWb623rlNrq/5Uy9uQCdEteAy1vWk9LXNza3doFgqx//2wI=
=uO0L
-----END PGP SIGNATURE-----

--Jgmgc6/N1boMAz6c--

