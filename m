Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1991C433F5
	for <webhook@archiver.kernel.org>; Tue,  1 Feb 2022 11:08:29 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.47104.1643713707904030342
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Feb 2022 03:08:28 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 665CF1C0B81; Tue,  1 Feb 2022 12:08:26 +0100 (CET)
Date: Tue, 1 Feb 2022 12:08:25 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 16/27] memory: renesas-rpc-if: Add support for
 RZ/G2L
Message-ID: <20220201110825.GB30077@amd>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220131121903.8620-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20220131121903.8620-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Feb 2022 11:08:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7552


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit b04cc0d912eb80d3c438b11d96ca847c3e77e8ab upstream.
>=20
> SPI Multi I/O Bus Controller on RZ/G2L SoC is almost identical to
> the RPC-IF interface found on R-Car Gen3 SoC's.
>=20
> This patch adds a new compatible string for the RZ/G2L family so
> that the timing values on RZ/G2L can be adjusted.

> +int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
>  {
>  	u32 dummy;
> =20
>  	pm_runtime_get_sync(rpc->dev);

> +	if (rpc->type =3D=3D RPCIF_RZ_G2L) {
> +		int ret;
> +
> +		ret =3D reset_control_reset(rpc->rstc);
> +		if (ret)
> +			return ret;
> +		usleep_range(200, 300);
> +		rpcif_rzg2l_timing_adjust_sdr(rpc);
> +	}

Should pm_runtime_put() be called before returning failure to the
caller?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmH5FKkACgkQMOfwapXb+vIJWwCgwEQz5uLUXnYjpv3o/4uLpBRQ
Bc8AoK1GIaQ/JXNqUPmPgeqSSDztjD4Z
=heAd
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--

