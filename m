Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98651C3DA49
	for <webhook@archiver.kernel.org>; Tue, 30 Jul 2024 12:26:00 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.16131.1722342349795506588
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jul 2024 05:25:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6FD361C0099; Tue, 30 Jul 2024 14:25:46 +0200 (CEST)
Date: Tue, 30 Jul 2024 14:25:45 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/13] RZ/G2L enhancements
Message-ID: <ZqjbydefJD0vFgcz@duo.ucw.cz>
References: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bbblws7eH3A4tCP8"
Content-Disposition: inline
In-Reply-To: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jul 2024 12:26:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16683


--bbblws7eH3A4tCP8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aim to add below enhancements on RZ/G2L SoCs.
> 1) Add VBUS regulator to control vbus voltage
> 2) Update correct procedure for cleating Alarm
> 3) Fix lockdep assert warning on DMA driver

Looks good to me, both 5.10 and 6.1 versions. I can apply both if it
passes testing and there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bbblws7eH3A4tCP8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqjbyQAKCRAw5/Bqldv6
8mvmAKC/X5leys8OSA3laSdHQ0JtQNS28ACgl/Y4B4hn/x9hCAW/Pr5i/CtoYD8=
=+lF+
-----END PGP SIGNATURE-----

--bbblws7eH3A4tCP8--

