Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA68EE49A3
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 08:44:27 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.3881.1692693855786678584
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Aug 2023 01:44:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 90F871C000B; Tue, 22 Aug 2023 10:44:13 +0200 (CEST)
Date: Tue, 22 Aug 2023 10:44:13 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/15] RZ/G2{L,UL} Improvements
Message-ID: <ZOR1XcetJSzqlGzK@duo.ucw.cz>
References: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1AEohO3XadlrA9lr"
Content-Disposition: inline
In-Reply-To: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 08:44:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12816


--1AEohO3XadlrA9lr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series add improvements to RZ/G2{L,UL} SMARC EVKs.
> All the patches are cherry-picked from mainline.

Thanks for patches. They look ok to me, and I can apply them provided
they pass testing and there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1AEohO3XadlrA9lr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZOR1XQAKCRAw5/Bqldv6
8g3PAJ97/jWcAaLR+JB+VIyOJy/HKD+7egCfX4M0Cn7kMPko8PXpmfIZaO4CV4E=
=5PvJ
-----END PGP SIGNATURE-----

--1AEohO3XadlrA9lr--

