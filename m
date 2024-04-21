Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E8BC4345F
	for <webhook@archiver.kernel.org>; Sun, 21 Apr 2024 14:17:04 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.32730.1713709023981083507
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Apr 2024 07:17:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7EFE31C0080; Sun, 21 Apr 2024 16:17:02 +0200 (CEST)
Date: Sun, 21 Apr 2024 16:17:02 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 13/53] clk: renesas: rzg2l: Simplify
 .determine_rate()
Message-ID: <ZiUf3ofCxfqK2KJM@duo.ucw.cz>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
 <20240419081742.3496709-14-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GVfqi/0IbWrFPQDE"
Content-Disposition: inline
In-Reply-To: <20240419081742.3496709-14-claudiu.beznea.uj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 21 Apr 2024 14:17:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15714


--GVfqi/0IbWrFPQDE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>=20
> commit bbceb13ce2c7b084bbbf2463ac8ac2b1f2bd2949 upstream.
>=20
> rzg2l_cpg_sd_clk_mux_determine_rate() is the same as
> __clk_mux_determine_rate_closest(), so use the latter to save some LoC.

It is somewhat strange to use __ annotated function like this, but as
it is already mainline, I guess everything is ok.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--GVfqi/0IbWrFPQDE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZiUf3gAKCRAw5/Bqldv6
8jvHAKCpOkQ1PXNdQKOuuPoqw6f1lJ7yBwCgqu7Slniyxt1GZsczVP/R8Zw2MBo=
=SJ8D
-----END PGP SIGNATURE-----

--GVfqi/0IbWrFPQDE--

