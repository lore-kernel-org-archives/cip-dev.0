Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F65C61D97
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 21:05:02 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.40365.1700687093715304041
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 13:04:54 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5CF831C0075; Wed, 22 Nov 2023 22:04:51 +0100 (CET)
Date: Wed, 22 Nov 2023 22:04:50 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 05/11] clk: fixed: Remove Allwinner A10
 special-case logic
Message-ID: <ZV5s8nrOSGpcravo@duo.ucw.cz>
References: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
 <20231122142819.203737-6-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdukFQxd8Jr711Bq"
Content-Disposition: inline
In-Reply-To: <20231122142819.203737-6-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 21:05:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13653


--gdukFQxd8Jr711Bq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Samuel Holland <samuel@sholland.org>
>=20
> commit c33ed61249dc54e7cf2137c04462883560375b77 upstream.
>=20
> This compatible is part of the legacy sunxi clock support, and has not
> been used since commit 6b48644b1d29 ("ARM: gr8: Convert to CCU") in
> October 2016. Since supporting this compatible adds some overhead to
> generic clock code, let's clean it up.

> +++ b/drivers/clk/clk-fixed-factor.c
> @@ -203,16 +203,10 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(st=
ruct device *dev,
>  EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor);
> =20
>  #ifdef CONFIG_OF
> -static const struct of_device_id set_rate_parent_matches[] =3D {
> -	{ .compatible =3D "allwinner,sun4i-a10-pll3-2x-clk" },
> -	{ /* Sentinel */ },
> -};

This is still mentioned in
Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--gdukFQxd8Jr711Bq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZV5s8gAKCRAw5/Bqldv6
8p7yAJ4ikZfXDvvTd8AoYBEUIeGwxmyRyQCffVcom7tzB7n61UVM0rwU+0BD/U4=
=NFrX
-----END PGP SIGNATURE-----

--gdukFQxd8Jr711Bq--

