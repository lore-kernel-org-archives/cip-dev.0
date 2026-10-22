Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1142.1792699333669997605
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2026 13:02:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=MfehPErU;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9DE52104F6D;
	Thu, 22 Oct 2026 22:02:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792699327;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fbyjyBeZNIOQhHr/Au5IuS8JVcPRc1pMvuloioCbQOE=;
	b=MfehPErU/35wtyNpIqZBAK2IpU+1QYVt0bdspHM7tTwzWZWjpRwVgUnHon9zAmaiiAuxWa
	TljZweL1QTL3Dk0Wcn7gxfUlWBKL9Sq60svvwHL73gDYFlFcbVOzWYdKgQ2e118v16IKRc
	37f69BMxHQN+ilEiPfspL0Cj/PHdCA4Jrl9XIJWC44BO3gSFYmWOpq/4DWV4zsQcXRoYWl
	q+5ic2cK5pkwxA9ouzWjajXpefnHYudwgcafi5iuhcmAk6cCuMXHCt737Cq1NV+xa/7YPb
	k/1E3uBGCZebsMDVFxHhOtcSrgBMHOY+8cz7MJJBr1h57+jbZHGbinRXdNPZ5g==
Date: Thu, 22 Oct 2026 22:02:04 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju Das <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a08g046l48-smarc:
 Enable rsci{1,2,3} nodes
Message-ID: <atprvF6_zDyUihQD@duo.ucw.cz>
References: <20261022134021.217964-1-biju.das.au@gmail.com>
 <20261022134021.217964-5-biju.das.au@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u13IDYk1bNs5PYQr"
Content-Disposition: inline
In-Reply-To: <20261022134021.217964-5-biju.das.au@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 20:02:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24516


--u13IDYk1bNs5PYQr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> [ Upstream commit 4fb32d9e4836c33ea9861f7c3e57beab6f546eb1 ]
>=20
> Enable rsci{1,2,3} device nodes for the RZ/G3L SMARC EVK.
>=20
> ---
>  .../boot/dts/renesas/r9a08g046l48-smarc.dts   | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts b/arch/ar=
m64/boot/dts/renesas/r9a08g046l48-smarc.dts
> index c1c36f7529597..5289efd1a430a 100644
> --- a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
> +++ b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
> @@ -134,6 +138,30 @@ i2c3_pins: i2c3 {
>  			 <RZG3L_PORT_PINMUX(2, 1, 4)>; /* RIIC3_SDA */
>  	};
> =20
> +	rsci1_pins: rsci1 {
> +		pinmux =3D <RZG3L_PORT_PINMUX(D, 4, 5)>, /* RSCI1_RXD_MISO_SCL */
> +			 <RZG3L_PORT_PINMUX(D, 5, 5)>, /* RSCI1_TXD_MOSI_SDA */
> +			 <RZG3L_PORT_PINMUX(D, 6, 6)>, /* RSCI1_CTS */
> +			 <RZG3L_PORT_PINMUX(D, 7, 5)>; /* RSCI1_SS_CTS#_RTS# */
> +		bias-pull-up;
> +	};

I just want to verify power-souce is not required here?


> +	rsci2_pins: rsci2 {
> +		pinmux =3D <RZG3L_PORT_PINMUX(7, 6, 5)>, /* RSCI2_RXD_MISO_SCL */
> +			 <RZG3L_PORT_PINMUX(7, 7, 5)>, /* RSCI2_TXD_MOSI_SDA */
> +			 <RZG3L_PORT_PINMUX(8, 0, 6)>, /* RSCI2_CTS */
> +			 <RZG3L_PORT_PINMUX(8, 1, 5)>; /* RSCI2_SS_CTS#_RTS# */
> +		bias-pull-up;
> +		power-source =3D <1800>;
> +	};

Best regards,
								Pavel

--u13IDYk1bNs5PYQr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCatprvAAKCRAw5/Bqldv6
8tzRAKDBCCx0IFLbbHRHCqvuzL2erzYfWACcCDJ81hK4xPbIuRPQJoPNjMA4DJU=
=ffDp
-----END PGP SIGNATURE-----

--u13IDYk1bNs5PYQr--
