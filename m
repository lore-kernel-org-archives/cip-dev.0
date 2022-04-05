Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43B5C4167B
	for <webhook@archiver.kernel.org>; Tue,  5 Apr 2022 19:49:23 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.1249.1649185282896913246
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Apr 2022 12:01:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F405D1C0B66; Tue,  5 Apr 2022 21:01:18 +0200 (CEST)
Date: Tue, 5 Apr 2022 21:01:18 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 23/29] clk: renesas: r9a07g044: Rename
 CLK_PLL3_DIV4 macro
Message-ID: <20220405190118.GB27445@duo.ucw.cz>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220404123553.25851-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <20220404123553.25851-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Apr 2022 19:49:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8002


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Rename the macro CLK_PLL3_DIV4->CLK_PLL3_DIV2_2 to match the clock tree
> mentioned in the hardware manual(Rev.1.00 Sep, 2021).

Changelog says rename,

> @@ -106,9 +106,9 @@ static const struct cpg_core_clk r9a07g044_core_clks[=
] __initconst =3D {
>  	DEF_FIXED(".pll2_div2_10", CLK_PLL2_DIV2_10, CLK_PLL2_DIV2, 1, 10),
> =20
>  	DEF_FIXED(".pll3_div2", CLK_PLL3_DIV2, CLK_PLL3, 1, 2),
> +	DEF_FIXED(".pll3_div2_2", CLK_PLL3_DIV2_2, CLK_PLL3_DIV2, 1, 2),
>  	DEF_FIXED(".pll3_div2_4", CLK_PLL3_DIV2_4, CLK_PLL3_DIV2, 1, 4),
>  	DEF_FIXED(".pll3_div2_4_2", CLK_PLL3_DIV2_4_2, CLK_PLL3_DIV2_4, 1, 2),
> -	DEF_FIXED(".pll3_div4", CLK_PLL3_DIV4, CLK_PLL3, 1, 4),
>  	DEF_MUX(".sel_pll3_3", CLK_SEL_PLL3_3, SEL_PLL3_3,
>  		sel_pll3_3, ARRAY_SIZE(sel_pll3_3), 0, CLK_MUX_READ_ONLY),
>  	DEF_DIV("divpl3c", CLK_DIV_PLL3_C, CLK_SEL_PLL3_3,

but macro arguments are changed, so I want to make sure it was
intended.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYkyR/gAKCRAw5/Bqldv6
8pNjAJ40wqFigB21D6eWeyOujnJAsP3zZgCfSTlcdzVjjkuHOdLc4oLJzxlcWdc=
=38cP
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--

