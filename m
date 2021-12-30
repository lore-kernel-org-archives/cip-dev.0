Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A14FC433EF
	for <webhook@archiver.kernel.org>; Thu, 30 Dec 2021 11:02:31 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.63531.1640862149811355357
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Dec 2021 03:02:30 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 449EA1C0B77; Thu, 30 Dec 2021 12:02:28 +0100 (CET)
Date: Thu, 30 Dec 2021 12:02:27 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 21/31] arm64: dts: renesas: rzg2l-smarc:
 Enable audio
Message-ID: <20211230110227.GC9799@amd>
References: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211229101530.22783-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <20211229101530.22783-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Dec 2021 11:02:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7313


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> commit e396d6103343ff95874444bd8a67f031eafe0e38 upstream.
>=20
> Enable audio on RZ/G2L SMARC EVK by linking SSI0 with WM8978
> audio CODEC.

> +++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
> @@ -8,6 +8,19 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
> =20
> +/*
> + * SSI-WM8978
> + *
> + * This command is required when Playback/Capture
> + *
> + *	amixer cset name=3D'Left Input Mixer L2 Switch' on
> + *	amixer cset name=3D'Right Input Mixer R2 Switch' on
> + *	amixer cset name=3D'Headphone Playback Volume' 100
> + *	amixer cset name=3D'PCM Volume' 100%
> + *	amixer cset name=3D'Input PGA Volume' 25

"These commands are required for Playback/Capture".

> @@ -30,6 +66,14 @@
>  	};
>  };
> =20
> +&audio_clk1{
> +	clock-frequency =3D <11289600>;
> +};
> +
> +&audio_clk2{
> +	clock-frequency =3D <12288000>;
> +};
> +

I'd expect spaces before {. (And yes, I'm picking nits here).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHNkcMACgkQMOfwapXb+vJ6PACfUYH0FmNIsrpJC4K5pMlZs2er
FOcAoJOoCX3ACLkSbqrIZGQUmT1O47Tc
=r9tp
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--

