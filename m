Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7799ECF884D
	for <webhook@archiver.kernel.org>; Fri,  4 Oct 2024 15:50:05 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.25663.1728057000310877731
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Oct 2024 08:50:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D43661C0082; Fri,  4 Oct 2024 17:49:58 +0200 (CEST)
Date: Fri, 4 Oct 2024 17:49:58 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/15] Full duplex audio + RZ/G2UL DU support
Message-ID: <ZwAOpkSPkq5MvvoJ@duo.ucw.cz>
References: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DetA0ift8AZy0zUU"
Content-Disposition: inline
In-Reply-To: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Oct 2024 15:50:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17007


--DetA0ift8AZy0zUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aim to add support for
> 1) RZ/G2UL display
> 2) Audio full duplex
>=20
> All the patches are cherry-picked from the mainline

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--DetA0ift8AZy0zUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwAOpgAKCRAw5/Bqldv6
8qXtAKC+4YVxN8pdctscYMwFv8A28mQd1ACgqbFSQ78xWZzPOsnysGuLBv8oZpY=
=4Yha
-----END PGP SIGNATURE-----

--DetA0ift8AZy0zUU--

