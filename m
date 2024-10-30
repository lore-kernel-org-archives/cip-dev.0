Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22441D5CC90
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 10:52:32 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12170.1730285549952860074
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Oct 2024 03:52:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 884CA1C00A3; Wed, 30 Oct 2024 11:52:27 +0100 (CET)
Date: Wed, 30 Oct 2024 11:52:27 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 17/27] media: platform: rzg2l-cru: rzg2l-csi2:
 Enclose the macro in parentheses
Message-ID: <ZyIP69IkF3ZrE4Jf@duo.ucw.cz>
References: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20241028200349.9620-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qpfd619NcOyk/RmT"
Content-Disposition: inline
In-Reply-To: <20241028200349.9620-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Oct 2024 10:52:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17111


--Qpfd619NcOyk/RmT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit e5f29bb9c4350dd9692f3b98eb8538dbbebccbaf upstream.
>=20
> Fix the below error reported by checkpatch:

I don't see this one in 6.1-cip. Can you submit it for that branch,
too?

(Are there others that are missing from 6.1?)

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Qpfd619NcOyk/RmT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZyIP6wAKCRAw5/Bqldv6
8mVvAJ4n0C9eNF58oBMHaOC+Kza6IrJsnQCcCU66SHcApUFqvnnriUPR8KEEMyU=
=BvR0
-----END PGP SIGNATURE-----

--Qpfd619NcOyk/RmT--

