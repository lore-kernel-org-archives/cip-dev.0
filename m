Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26837D5CC96
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 11:17:32 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.12380.1730287041802045348
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Oct 2024 04:17:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 948E91C00A3; Wed, 30 Oct 2024 12:17:19 +0100 (CET)
Date: Wed, 30 Oct 2024 12:17:19 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/27] Add CRU and CSI support for Renesas
 RZ/G2L
Message-ID: <ZyIVv8qZPtDzqtDn@duo.ucw.cz>
References: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fn5TdUoRW35H/YKz"
Content-Disposition: inline
In-Reply-To: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Oct 2024 11:17:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17112


--Fn5TdUoRW35H/YKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add support for CRU and CSI drivers for the
> Renesas RZ/G2L SoC.
>=20
> All the patches have been cherry-picked from upstream kernel.

I attempted to test these, and got build errors:

  DTC     arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dtb
10221
  DTC     arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtb
10222
Error: arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi:41.1-5 Labe=
l or path cru not found
10223
Error: arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi:45.1-6 Labe=
l or path csi2 not found
10224
FATAL ERROR: Syntax error parsing input tree
10225
make[2]: *** [scripts/Makefile.lib:326: arch/arm64/boot/dts/renesas/r9a07g0=
54l2-smarc.dtb] Error 1
10226
make[2]: *** Waiting for unfinished jobs....
10227
  DTC

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1519754167

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Fn5TdUoRW35H/YKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZyIVvwAKCRAw5/Bqldv6
8rROAJ4xblEZo8MPhZXez2pugaZV+ihRVwCeJTXwDux0LERIpfAnxZLedLYNeig=
=9oOj
-----END PGP SIGNATURE-----

--Fn5TdUoRW35H/YKz--

