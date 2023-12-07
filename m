Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361C6C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 19:41:30 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.93893.1701978084473995681
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 11:41:24 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0DF301C0080; Thu,  7 Dec 2023 20:41:22 +0100 (CET)
Date: Thu, 7 Dec 2023 20:41:21 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/25] Add RZ/G2L DSI support
Message-ID: <ZXIf4e9bSPxmOTn2@duo.ucw.cz>
References: <20231207142502.401651-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m0Rl/Cn6hnFTaIrT"
Content-Disposition: inline
In-Reply-To: <20231207142502.401651-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 19:41:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13905


--m0Rl/Cn6hnFTaIrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add RZ/G2L DSI support on
> RZ/{G2L,GLC,V2L} SMARC EVKs.
> =20
> All the patches are cherry-picked from the mainline, except [1] and [2]
>=20
> Without [1] DU is giving probe failure as the encoder is not
> able to find all the connected bridges due to the framework changes
> between mainline and 5.10 kernel. So just restructured the bridge handlin=
g.
>=20
> IA55 IRQ driver is not backported to 5.10, so defining it in dts is
> giving warnings, so drop IRQs in patch[2].
>=20
> Please don't apply patch#18 to patch#25 as it is added for testing
> purpose.

Ok, so series looks good to me. I did not review the [HACK] patches
closely. I can apply if it tests ok and if there are no other
comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--m0Rl/Cn6hnFTaIrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXIf4QAKCRAw5/Bqldv6
8jz+AJ449bUZDfq1lfZMlyWSfdzaFlfgeACghWlrqmIq3VXN7+M+q10MBpRuG1k=
=eVIQ
-----END PGP SIGNATURE-----

--m0Rl/Cn6hnFTaIrT--

