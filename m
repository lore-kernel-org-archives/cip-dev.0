Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB65C54E5D
	for <webhook@archiver.kernel.org>; Tue, 19 Mar 2024 11:11:59 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.12652.1710846713305210103
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Mar 2024 04:11:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D007C1C006B; Tue, 19 Mar 2024 12:11:51 +0100 (CET)
Date: Tue, 19 Mar 2024 12:11:51 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 4.19.y-cip] memory: renesas-rpc-if: Clear HS bit during
 hardware initialization
Message-ID: <Zfly9+TwgPIBIhEg@duo.ucw.cz>
References: <20240315165231.31090-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4TIF6w9pYEfN03r1"
Content-Disposition: inline
In-Reply-To: <20240315165231.31090-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Mar 2024 11:11:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15364


--4TIF6w9pYEfN03r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 5192481f908e576be42bd39ec12979b79e11f7e0 upstream.
>=20
> According to the datasheet, HS bit should be specified to 1 when using
> DMA transfer. As DMA transfer is not supported, it should be cleared to
> 0.
>=20
> Previously, the driver relied on the HS bit being cleared by prior
> firmware but this is not always the case.
>=20
> Fix this by ensuring the bit is cleared during hardware
> initialization.

Thank you, applied.

Best regards,=09
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4TIF6w9pYEfN03r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfly9wAKCRAw5/Bqldv6
8n97AJjxKYLiMAQvkjrW56QHpIsr1zVCAJ463s7Sdp9huiYOLSYpZxgZ+skXng==
=rp/k
-----END PGP SIGNATURE-----

--4TIF6w9pYEfN03r1--

