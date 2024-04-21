Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0D2C4345F
	for <webhook@archiver.kernel.org>; Sun, 21 Apr 2024 14:19:04 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.32756.1713709136248322403
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Apr 2024 07:18:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C17831C0080; Sun, 21 Apr 2024 16:18:54 +0200 (CEST)
Date: Sun, 21 Apr 2024 16:18:54 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 17/53] clk: renesas: rzg2l: Add support for
 RZ/G3S PLL
Message-ID: <ZiUgTsFF7W7+wvqW@duo.ucw.cz>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
 <20240419081742.3496709-18-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="76LWhycXn6w4n5xZ"
Content-Disposition: inline
In-Reply-To: <20240419081742.3496709-18-claudiu.beznea.uj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 21 Apr 2024 14:19:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15715


--76LWhycXn6w4n5xZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -714,11 +719,43 @@ static const struct clk_ops rzg2l_cpg_pll_ops =3D {
> +static unsigned long rzg3s_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
> +						   unsigned long parent_rate)
> +{
=2E..
> +	val =3D readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
> +
> +	pr =3D 1 << FIELD_GET(RZG3S_DIV_P, val);
> +	/* Hardware interprets values higher than 8 as p =3D 16. */
> +	if (pr > 8)
> +		pr =3D 16;

What does "p" mean in the above comment. Should it say "pr"?

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--76LWhycXn6w4n5xZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZiUgTgAKCRAw5/Bqldv6
8upsAJ9hVdKMUGaxXiPPVJSnSNFFNaYdjwCff+DkTdNvRsgFogAudrCA6/tuar8=
=vPRH
-----END PGP SIGNATURE-----

--76LWhycXn6w4n5xZ--

