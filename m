Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ECAEB64DD
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 10:31:48 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.183929.1692268301070440694
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 03:31:41 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A371B1C0004; Thu, 17 Aug 2023 12:31:37 +0200 (CEST)
Date: Thu, 17 Aug 2023 12:31:36 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/2] Enable PMU support for RZ/{G2L,G2LC,V2L}
 SoCs
Message-ID: <ZN33CJ7BSK8XRPHV@duo.ucw.cz>
References: <20230816070315.3078-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0TALFaA4SRhdeX2r"
Content-Disposition: inline
In-Reply-To: <20230816070315.3078-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 10:31:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12750


--0TALFaA4SRhdeX2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to enable PMU support for RZ/{G2L,G2LC,V2L}
> SoCs.
> =20
> All the patches are cherry-picked from the mainline.

Applied, see 6.1 thread.

BR,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0TALFaA4SRhdeX2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZN33CAAKCRAw5/Bqldv6
8iYIAJ9VUYI5+7v8uesj7hrgcYRuFb3t6gCdHEjWMuUKdPWCXUFSV4iM2szcMI4=
=4hG/
-----END PGP SIGNATURE-----

--0TALFaA4SRhdeX2r--

