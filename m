Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C8DC28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 13:06:35 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.17516.1661173590213016071
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Aug 2022 06:06:30 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BD3C71C0001; Mon, 22 Aug 2022 15:06:28 +0200 (CEST)
Date: Mon, 22 Aug 2022 15:06:28 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip] arm64: dts: renesas: r9a07g054l2-smarc:
 Correct SoC name in comment
Message-ID: <20220822130628.GB16642@duo.ucw.cz>
References: <20220822123346.24089-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <20220822123346.24089-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Aug 2022 13:06:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9297


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Chris Paterson <chris.paterson2@renesas.com>
>=20
> commit d1273f541ab409242e08da6bb836bb564021274c upstream.
>=20
> This dts is for the RZ/V2L SMARC EVK, not RZ/G2L.

A bit trivial, but looks ok to me. I can apply it if there are no
other comments.

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYwN/VAAKCRAw5/Bqldv6
8jfVAJ0TMKprh88qLdPmxNEO1vlL8w3fDQCfV48gW6FClZ7+eJU8Z8EwgJqVJY4=
=hm28
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--

