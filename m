Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040F8C4332F
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 19:38:39 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1622.1668022716405235163
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Nov 2022 11:38:37 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C37D41C09D7; Wed,  9 Nov 2022 20:38:33 +0100 (CET)
Date: Wed, 9 Nov 2022 20:38:33 +0100
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/3] SDHI Fixes/enhancements
Message-ID: <Y2wBubdJED5D8qGC@duo.ucw.cz>
References: <20221108125630.3853219-1-biju.das.jz@bp.renesas.com>
 <Y2qkTO5o6a05sDI4@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z2Adc3/c8mklpj8m"
Content-Disposition: inline
In-Reply-To: <Y2qkTO5o6a05sDI4@duo.ucw.cz>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 19:38:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9965


--Z2Adc3/c8mklpj8m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to add rounding error fixes for selecting
> > 533MHz SDHI source clk and avoid glitches when resetting.
>=20
> Series looks okay to me, and it looks like it will pass testing, too.
>=20
> If there are no other comments, I can apply it. (But I guess I'll wait
> for 5.10-cip kernel to be released, first, in order not to interfere
> with the release).

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Z2Adc3/c8mklpj8m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY2wBuQAKCRAw5/Bqldv6
8gAUAJ9MQbrHol46ZZzdUZoZtZlyaMiyfgCgoCumZxhH3rfJrEnanlRXV3EJZqQ=
=J3cr
-----END PGP SIGNATURE-----

--Z2Adc3/c8mklpj8m--

