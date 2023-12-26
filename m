Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFB0C46CD3
	for <webhook@archiver.kernel.org>; Tue, 26 Dec 2023 18:37:33 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.86853.1703615846961210613
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Dec 2023 10:37:27 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7B0891C0050; Tue, 26 Dec 2023 19:37:25 +0100 (CET)
Date: Tue, 26 Dec 2023 19:37:24 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH RFC 28/30] riscv: dts: renesas: r9a07g043f: Add L2 cache
 node
Message-ID: <ZYsdZBWqFUjPaa3Q@duo.ucw.cz>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20231220230646.219816-29-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NOensHLMfbn8g8NT"
Content-Disposition: inline
In-Reply-To: <20231220230646.219816-29-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Dec 2023 18:37:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14198


--NOensHLMfbn8g8NT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit a38b1061d327c120844e5dc0217191b06ce3b25f upstream.
>=20
> Add L2 cache node for RZ/Five SoC.

This is minor, but..

> +++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> @@ -29,6 +29,7 @@ cpu0: cpu@0 {
>  			i-cache-line-size =3D <0x40>;
>  			d-cache-size =3D <0x8000>;
>  			d-cache-line-size =3D <0x40>;
> @@ -56,4 +57,15 @@ plic: interrupt-controller@12c00000 {
>  		resets =3D <&cpg R9A07G043_NCEPLIC_ARESETN>;
>  		interrupts-extended =3D <&cpu0_intc 11 &cpu0_intc 9>;
>  	};
> +
> +	l2cache: cache-controller@13400000 {
=2E..
> +		cache-size =3D <0x40000>;
> +		cache-line-size =3D <64>;

Sometimes using hex and sometimes dec for cache-line-size looks
strange.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NOensHLMfbn8g8NT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZYsdZAAKCRAw5/Bqldv6
8kmkAKCbLfbu2+sTm6Df9PVzLCvIPFoNcACfbBAGrQqWFvADK/I6KSTkas1H7K4=
=GFGx
-----END PGP SIGNATURE-----

--NOensHLMfbn8g8NT--

