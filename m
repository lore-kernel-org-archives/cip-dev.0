Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89941C3DA4A
	for <webhook@archiver.kernel.org>; Thu,  1 Aug 2024 14:28:17 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.69690.1722522495311624702
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Aug 2024 07:28:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 35B881C008E; Thu,  1 Aug 2024 16:28:12 +0200 (CEST)
Date: Thu, 1 Aug 2024 16:28:11 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/13] RZ/G2L enhancements
Message-ID: <Zqube6kqs386twly@duo.ucw.cz>
References: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7+QTAnk28NYV2Nqv"
Content-Disposition: inline
In-Reply-To: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Aug 2024 14:28:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16706


--7+QTAnk28NYV2Nqv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aim to add below enhancements on RZ/G2L SoCs.
> 1) Add VBUS regulator to control vbus voltage
> 2) Update correct procedure for cleating Alarm
> 3) Fix lockdep assert warning on DMA driver
>=20
> All the patches are cherry-picked from the mainline.

Thank you, applied.

Best regards,
    							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7+QTAnk28NYV2Nqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqubewAKCRAw5/Bqldv6
8i0kAJ98GgzQfxPGqsC+b5TM8/OHCFYvtgCfcjTi4qA0zRNsbosVG37cBxyN3bY=
=PTe6
-----END PGP SIGNATURE-----

--7+QTAnk28NYV2Nqv--

