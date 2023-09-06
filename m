Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11C4EB8FAF
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 08:47:30 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4031.1693990049378546107
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 01:47:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DF1BE1C000B; Wed,  6 Sep 2023 10:47:27 +0200 (CEST)
Date: Wed, 6 Sep 2023 10:47:27 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/20] Add Renesas RZ/G2L DSI,VSP,FCP support
Message-ID: <ZPg8n16XTqWOXhMf@duo.ucw.cz>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HIUXhJK5/c6N5blt"
Content-Disposition: inline
In-Reply-To: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 08:47:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12982


--HIUXhJK5/c6N5blt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add RZ/G2L DSI,VSP,FCP support
> =20
> All the patches are cherry-picked from the mainline except the last
> 6 patches.

Thanks for the series. I only found tiny nits in the first 14 patches,
and they pass testing, so I can merge them if there are no other
comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HIUXhJK5/c6N5blt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZPg8nwAKCRAw5/Bqldv6
8o7dAJ91Q3De4MdxFtNzAUVt3RAsEoksRwCgrvsOikWxUIzLZ4nW1oSib4SWBVQ=
=NrfP
-----END PGP SIGNATURE-----

--HIUXhJK5/c6N5blt--

