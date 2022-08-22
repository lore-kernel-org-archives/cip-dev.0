Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340ABC28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 13:04:55 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.17856.1661173487748384028
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Aug 2022 06:04:48 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7B7581C0001; Mon, 22 Aug 2022 15:04:44 +0200 (CEST)
Date: Mon, 22 Aug 2022 15:04:43 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix reset status function
Message-ID: <20220822130443.GA16642@duo.ucw.cz>
References: <20220822112046.1067688-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20220822112046.1067688-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Aug 2022 13:04:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9296


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 02c96ed9e4cd1f47bfcd10296fec6b0b69d6b3c6 upstream.
>=20
> As per RZ/G2L HW(Rev.1.10) manual, reset monitor register value 0 means
> reset signal is not applied (deassert state) and 1 means reset signal
> is applied (assert state).
>=20
> reset_control_status() expects a positive value if the reset line is
> asserted. But rzg2l_cpg_status function returns zero for asserted
> state.
>=20
> This patch fixes the issue by adding double inverted logic, so that
> reset_control_status returns a positive value if the reset line is
> asserted.

Looks ok to me. I can apply it if it passes testing and there are no
other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYwN+6wAKCRAw5/Bqldv6
8kUhAJ43sLZpkp+c7aLN2LqNPoycVgUZ4gCgjsla/slf8Uejda2RqVPunmg0N+w=
=iEmD
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

