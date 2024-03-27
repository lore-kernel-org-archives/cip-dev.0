Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066CCC47DD9
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 11:53:27 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.35591.1711540406083837980
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 04:53:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 65C931C007E; Wed, 27 Mar 2024 12:53:23 +0100 (CET)
Date: Wed, 27 Mar 2024 12:53:22 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 00/13] Update IA55 driver
Message-ID: <ZgQIssu9wSgO/TxI@duo.ucw.cz>
References: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bYqEDe4QghGwQOoG"
Content-Disposition: inline
In-Reply-To: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 11:53:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15468


--bYqEDe4QghGwQOoG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series updates the Renesas IA55 IRQ driver with patches from
> mainline kernel. Along with it, a patch for Renesas pin controller driver
> was cherry-picked from mainline kernel.

This series looks good to me. A lot of that are cleanups, include
whitespace-only, but I guess they are localised to "your" code so we
can apply them.

I can apply it if it passes testing and there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bYqEDe4QghGwQOoG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgQIsgAKCRAw5/Bqldv6
8hbAAJ9HdSedFw3W52Zqj4cbktbrAgOPkACfYQD5keitLOUULB92X2kC0TBxO8Q=
=QHbm
-----END PGP SIGNATURE-----

--bYqEDe4QghGwQOoG--

