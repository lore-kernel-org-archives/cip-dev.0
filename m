Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31214C433F5
	for <webhook@archiver.kernel.org>; Tue,  1 Feb 2022 11:11:37 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.47460.1643713895902789921
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Feb 2022 03:11:36 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 696AF1C0B81; Tue,  1 Feb 2022 12:11:32 +0100 (CET)
Date: Tue, 1 Feb 2022 12:11:31 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 25/27] arm64: dts: renesas: rzg2l-smarc:
 Enable SCIF2 on carrier board
Message-ID: <20220201111131.GD30077@amd>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220131121903.8620-26-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <20220131121903.8620-26-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Feb 2022 11:11:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7554


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 5a8aa63c9bca800e6049d90422abe5404227a703 upstream.
>=20
> SCIF2 interface is available on PMOD1 connector (CN7) on carrier board,
> This patch adds pinmux and scif2 node to carrier board dtsi file.


> +++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
> @@ -8,9 +8,13 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
> =20
> +/* comment the #define statement to disable SCIF2 (SER0) on PMOD1 (CN7) =
*/
> +#define PMOD1_SER0	1
> +

AFAICT this needs to be set to 0, not commented out.


> @@ -156,6 +167,23 @@
>  	status =3D "okay";
>  };
> =20
> +/*
> + * To enable SCIF2 (SER0) on PMOD1 (CN7)
> + * SW1 should be at position 2->3 so that SER0_CTS# line is activated
> + * SW2 should be at position 2->3 so that SER0_TX line is activated
> + * SW3 should be at position 2->3 so that SER0_RX line is activated
> + * SW4 should be at position 2->3 so that SER0_RTS# line is activated
> + */
> +#if PMOD1_SER0
> +&scif2 {
> +	pinctrl-0 =3D <&scif2_pins>;
> +	pinctrl-names =3D "default";
> +
> +	uart-has-rtscts;
> +	status =3D "okay";
> +};
> +#endif
> +
>  &usb2_phy0 {
>  	pinctrl-0 =3D <&usb0_pins>;
>  	pinctrl-names =3D "default";

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmH5FWMACgkQMOfwapXb+vJV6QCggnbx+CzylYQZqDudRjKuoOws
xt4AnjHHmQt4gSkOZfuapb27NAYHGYxw
=khBC
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--

