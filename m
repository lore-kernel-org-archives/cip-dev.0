Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D8BC38A2D
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 08:41:02 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.5217.1666773659010966525
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Oct 2022 01:41:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C44481C0A0B; Wed, 26 Oct 2022 10:40:55 +0200 (CEST)
Date: Wed, 26 Oct 2022 10:40:55 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/12] RZ/G2{L,LC,UL}/RZ/V2L improvements
Message-ID: <20221026084055.GA13322@duo.ucw.cz>
References: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 08:41:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9842


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add DMA support to RSPI and enhancements
> like fixing interrupt types, MII support and fix RPM imabalance for
> RZ/G2{L,LC,UL}/RZ/V2L SoCs

1st patch seems to be just a preparation for something we'll not merge
in 5.10 -- not a bugfix and not a new hardware support. It is not
likely to break anything, still I believe we could avoid it.

> Uwe Kleine-K=F6nig (1):
>   mtd: hyperbus: Make hyperbus_unregister_device() return void

The rest of the series looks good, and I can apply it if it passes
testing and if there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY1jylwAKCRAw5/Bqldv6
8oDZAJ45emB+82WCjMYw1w7E0qrQ0oBxJwCfama0EZm5Lj8eftt1uA+p1aHoQI8=
=vxub
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

