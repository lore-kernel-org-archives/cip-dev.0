Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A973CC433EF
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 10:20:27 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.5370.1648722025805080007
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Mar 2022 03:20:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7A3D51C0B98; Thu, 31 Mar 2022 12:20:23 +0200 (CEST)
Date: Thu, 31 Mar 2022 12:20:22 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 21/39] mmc: renesas_sdhi: do hard reset if
 possible
Message-ID: <20220331102022.GE21513@amd>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220330185454.10887-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
In-Reply-To: <20220330185454.10887-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Mar 2022 10:20:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7899


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit b4d86f37eacb724690d0d300576b82806bc743d5 upstream.
>=20
> All recent SDHI instances can be reset via the reset controller. If one
> is found, use it instead of the open coded reset. This is to get a
> future-proof sane reset state.

> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1086,6 +1097,10 @@ int renesas_sdhi_probe(struct platform_device *pde=
v,
>  	if (ret)
>  		goto efree;
> =20
> +	priv->rstc =3D devm_reset_control_get_optional_exclusive(&pdev->dev, NU=
LL);
> +	if (IS_ERR(priv->rstc))
> +		return PTR_ERR(priv->rstc);
> +

I believe this needs to goto to appropriate error path, not return
directly.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJFgGYACgkQMOfwapXb+vLMfACfWgMZdQVC++kJI4lmQRN8H0Ab
NRAAn2sagtCj1uNgm1jYp8RpDEfmsV8i
=5Ujv
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--

