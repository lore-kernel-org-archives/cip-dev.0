Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49261C433EF
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 10:19:28 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4635.1639736362639332336
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 02:19:23 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 211C81C0B77; Fri, 17 Dec 2021 11:19:18 +0100 (CET)
Date: Fri, 17 Dec 2021 11:19:17 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 11/24] arm64: dts: renesas: Add initial DTSI
 for RZ/G2{L,LC} SoC's
Message-ID: <20211217101917.GB17079@amd>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211216125446.15451-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <20211216125446.15451-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 10:19:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7171


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 68a45525297b2e9afbd9bba807ddd2c9f69beee6 upstream.
>=20
> Add initial DTSI for RZ/G2{L,LC} SoC's.
>=20
> File structure:
> r9a07g044.dtsi  =3D> RZ/G2L family SoC common parts
> r9a07g044l1.dtsi =3D> RZ/G2L R9A07G044L1 SoC specific parts
> r9a07g044l2.dtsi =3D> RZ/G2L R9A07G044L2 SoC specific parts

I just want to double check:

> +		scif0: serial@1004b800 {
> +			compatible =3D "renesas,scif-r9a07g044";
> +			reg =3D <0 0x1004b800 0 0x400>;
> +			interrupts =3D <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "eri", "rxi", "txi",
> +					  "bri", "dri", "tei";

Are the last two interrupts supposed to be same?

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmG8ZCUACgkQMOfwapXb+vKn2gCdFqU0O8Jr/bGf30sWV53Zggzl
tusAmwU7/xCj69OWHW0LRO4fqRpfpiL4
=ypq4
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--

