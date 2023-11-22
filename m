Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AF9C61D97
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 21:11:02 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.45045.1700687460892611521
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 13:11:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 702AD1C0073; Wed, 22 Nov 2023 22:10:41 +0100 (CET)
Date: Wed, 22 Nov 2023 22:10:40 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
Message-ID: <ZV5uUFDxiawBZf30@duo.ucw.cz>
References: <20231122143156.204055-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/4zPeIQ+QDtA15RZ"
Content-Disposition: inline
In-Reply-To: <20231122143156.204055-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 21:11:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13655


--/4zPeIQ+QDtA15RZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add versa3 clk generator support on
> RZ/G2{L,LC,UL}/RZ/Five SMARC EVKs.
> =20
> All the patches are cherry-picked from the mainline.

> Maxime Ripard (1):
>   clk: Add trace events for rate requests
>=20
> Stephen Boyd (2):
>   clk: Move no reparent case into a separate function
>   clk: Introduce clk_hw_determine_rate_no_reparent()

I believe we don't need these in 5.10. I'm okay with this version
as-is, but if someone says these are intrusive and we should use 5.10
versions that don't need these, I'll understand that.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/4zPeIQ+QDtA15RZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZV5uUAAKCRAw5/Bqldv6
8gHXAKCarIb9ed31ff+kU0sKvvPCV7gTMACeK0agAOy0EOqZuK9tyUpmuARZ8l0=
=QXUx
-----END PGP SIGNATURE-----

--/4zPeIQ+QDtA15RZ--

