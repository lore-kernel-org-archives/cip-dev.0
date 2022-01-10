Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2883C433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 18:38:10 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.35945.1641839889155525424
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 10:38:10 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 454DA1C0B76; Mon, 10 Jan 2022 19:38:04 +0100 (CET)
Date: Mon, 10 Jan 2022 19:38:03 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 5.10.y-cip 00/15] Add ADC/CANFD/IIC support for RZ/G2L
Message-ID: <20220110183803.GD3396@duo.ucw.cz>
References: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 18:38:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7438


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds Sound and ADC support for Renesas RZ/G2L SoC
> and enables RIIC/SOUND/CANFD/ADC on Renesas SMARC EVK.
>=20
> I have also included the missing driver patch for riic and kernel configs.
>=20
> All the patches have been cherry picked from v5.16-rc7.
>=20
> I have created a MR [0] for cip-kernel-config to support build testing and
> can be merged once this patch series is accepted.
>=20
> Note: I have kept the clock related patches for audio as this will avoid
> conflicts with the later patches.

Series looks okay to me. I did not test it but I assume it will pass.

I can test/apply it quickly if history modification and force push is
not required. I'd like confirmation from rest of the team before
inserting commit into history.

Best regards,
       	     	     	       	   	       	 	   	Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYdx9CwAKCRAw5/Bqldv6
8orZAJsGJy9nxdY0ZsJAUaoUplAHfbMEcwCeMT8L4l/ID62AsesffGfhl2UBDBI=
=9nx/
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--

