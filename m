Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F51C433F5
	for <webhook@archiver.kernel.org>; Tue,  1 Feb 2022 11:10:35 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.47446.1643713833871891466
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Feb 2022 03:10:34 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9E6941C0B81; Tue,  1 Feb 2022 12:10:31 +0100 (CET)
Date: Tue, 1 Feb 2022 12:10:30 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 19/27] arm64: dts: renesas: rzg2l-smarc-som:
 Enable serial NOR flash
Message-ID: <20220201111030.GC30077@amd>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220131121903.8620-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <20220131121903.8620-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Feb 2022 11:10:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7553


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit c81bd70f47cef36f88074d119e6e49cf92707fdb upstream.
>=20
> Enable mt25qu512a flash connected to QSPI0.
>=20

> +		partitions {
> +			compatible =3D "fixed-partitions";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +
> +			boot@0 {
> +				reg =3D <0x00000000 0x2000000>;
> +				read-only;
> +			};
> +			user@2000000 {
> +				reg =3D <0x2000000 0x2000000>;
> +			};

This confused me for a while. Some of hex numbers are 7 digits, some
are 8. Making it consistent at 8 digits would be good. (Or maybe=20
using 0x0 so it is clear we are not aiming for 8 digits).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmH5FSYACgkQMOfwapXb+vJqWwCgwGmcrgybwnaq1GU9/9NW7y4C
wdEAnRw5Fdv+MO4PS11flL2/mC86Xq2g
=969T
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--

