Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4DDEB64DD
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 20:24:11 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2982.1688502241474106192
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jul 2023 13:24:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D555D1C0DFD; Tue,  4 Jul 2023 22:23:59 +0200 (CEST)
Date: Tue, 4 Jul 2023 22:23:59 +0200
From: Pavel Machek <pavel@denx.de>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH 5.10.y-cip 0/4] Add Renesas RZ/V2M PWC support
Message-ID: <ZKR/3wD7Lf4WVMQ7@duo.ucw.cz>
References: <20230703170211.15484-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gzOKKfB24IBIR8iP"
Content-Disposition: inline
In-Reply-To: <20230703170211.15484-1-fabrizio.castro.jz@renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 20:24:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12221


--gzOKKfB24IBIR8iP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> this series adds support for the PWC IP found inside the Renesas
> RZ/V2M SoC.

General-purpose output-only surprised me a bit, but it seems this is
the way to implement them.

Reviewed-by: Pavel Machek <pavel@denx.de>

I don't believe equivalent series is there in v6.1, and this one does
not apply, so I expect we'll get 6.1 version, too?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--gzOKKfB24IBIR8iP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZKR/3wAKCRAw5/Bqldv6
8speAKCrDtB2BEypU/3IomFzJJJfIaSBqQCfWYM0hiEpnSWFHvxMK4J7S6mSZ90=
=P64W
-----END PGP SIGNATURE-----

--gzOKKfB24IBIR8iP--

