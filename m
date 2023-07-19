Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81885EB64DA
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 12:40:06 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.12633.1689770398242214091
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jul 2023 05:39:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BEE811C0A97; Wed, 19 Jul 2023 14:39:56 +0200 (CEST)
Date: Wed, 19 Jul 2023 14:39:56 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 11/13] arm64: dts: renesas: rzg2l-smarc: Add
 support for enabling MTU3
Message-ID: <ZLfZnDPNEVejsj3/@duo.ucw.cz>
References: <20230718140608.119449-1-biju.das.jz@bp.renesas.com>
 <20230718140608.119449-12-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gPNtsykODRVLGwr+"
Content-Disposition: inline
In-Reply-To: <20230718140608.119449-12-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 12:40:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12423


--gPNtsykODRVLGwr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit fb9341ebc7df140813d4fbc4a29fddba55a90728 upstream.
>=20
> Add support for PMOD_MTU3 macro to enable MTU3 node on RZ/{G2,V2}L SMARC
> EVK.
>=20
> The MTU3a PWM pins are muxed with spi1 pins and counter external input
> phase clock pins are muxed with scif2 pins. Disable these IPs when
> PMOD_MTU3 macro is enabled.
>=20
> Apart from this, the counter Z phase clock signal is muxed with the
> SDHI1 cd signal. So disable SDHI1 IP, when the counter Z phase signal
> is enabled.

> +++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
> @@ -6,6 +6,27 @@
> +
> +#if (PMOD_MTU3 && PMOD1_SER0)
> +#error "Cannot set as PMOD_MTU3 and PMOD1_SER0 are mutually exclusive "
> +#endif
> +
> +#define MTU3_COUNTER_Z_PHASE_SIGNAL	0
> +
> +#if (!PMOD_MTU3 && MTU3_COUNTER_Z_PHASE_SIGNAL)
> +#error "Cannot set 1 to MTU3_COUNTER_Z_PHASE_SIGNAL as PMOD_MTU3=3D0"
> +#endif
> +
>  #include "r9a07g044l2.dtsi"
>  #include "rzg2l-smarc-som.dtsi"
>  #include "rzg2l-smarc-pinfunction.dtsi"
> diff --git a/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts b/arch/arm=
64/boot/dts/renesas/r9a07g054l2-smarc.dts
> index 3d01a4cf0fbe..b3e6016880dd 100644
> --- a/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
> +++ b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
> @@ -6,6 +6,26 @@
> +
> +#if (PMOD_MTU3 && PMOD1_SER0)
> +#error "Cannot set as PMOD_MTU3 and PMOD1_SER0 are mutually exclusive "
> +#endif
> +
> +#define MTU3_COUNTER_Z_PHASE_SIGNAL	0
> +#if (!PMOD_MTU3 && MTU3_COUNTER_Z_PHASE_SIGNAL)
> +#error "Cannot set 1 to MTU3_COUNTER_Z_PHASE_SIGNAL as PMOD_MTU3=3D0"
> +#endif
> +

These consistency checks are common, could they be done in a common
place?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--gPNtsykODRVLGwr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLfZnAAKCRAw5/Bqldv6
8v1pAJ9+xUaK0zgMbvobjgbCWbTVyehgQgCgjea1PbCBP1HhLQF1xpA0hwQKVCU=
=6JO2
-----END PGP SIGNATURE-----

--gPNtsykODRVLGwr+--

