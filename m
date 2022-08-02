Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A60C00140
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 16:54:13 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.8843.1659459250047835458
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 09:54:10 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A03C01C0004; Tue,  2 Aug 2022 18:54:07 +0200 (CEST)
Date: Tue, 2 Aug 2022 18:54:07 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>, nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 10/24] clk: renesas: rzg2l-cpg: Add support
 for RZ/V2L SoC
Message-ID: <20220802165407.GB9523@duo.ucw.cz>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
 <20220802110850.1496057-11-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <20220802110850.1496057-11-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 16:54:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9024


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit a1bcf50a99dd1e40f0c6a963bd4f12547a89d4cd upstream.
>=20
> The clock structure for RZ/V2L is almost identical to the RZ/G2L SoC.
> The only difference being that RZ/V2L has additional registers to
> control clocks and resets for the DRP-AI block.
>=20
> Reuse r9a07g044-cpg.c, as the clock IDs and reset IDs are the same
> between RZ/G2L and RZ/V2L, and add a separate r9a07g054_cpg_info to take
> care of the DRP-AI clocks/resets.

Ok, so this reuse is quite interesting.


> +++ b/drivers/clk/renesas/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_CLK_R8A77995)		+=3D r8a77995-cpg-mssr.o
>  obj-$(CONFIG_CLK_R8A779A0)		+=3D r8a779a0-cpg-mssr.o
>  obj-$(CONFIG_CLK_R9A06G032)		+=3D r9a06g032-clocks.o
>  obj-$(CONFIG_CLK_R9A07G044)		+=3D r9a07g044-cpg.o
> +obj-$(CONFIG_CLK_R9A07G054)		+=3D r9a07g044-cpg.o
>  obj-$(CONFIG_CLK_SH73A0)		+=3D clk-sh73a0.o

They share the same source file, but the file will be different basen
on config options.

If you enable CONFIG_CLK_R9A07G044, you get g044 support but not g054
support.

If you enable CONFIG_CLK_R9A07G054, you get both g044 and g054
support, you can't disable g044.

This is quite strange, but probably not a problem. For symmetry, I'd
not mind conditional compilation of g044 parts; or perhaps even better
get rid of condtional compilation of g045 parts -- I don't believe
space savings are significant.

Best regards,
								Pavel


> index 46359afef0d4..bdfabb992a20 100644
> --- a/drivers/clk/renesas/r9a07g044-cpg.c
> +++ b/drivers/clk/renesas/r9a07g044-cpg.c
> +
> +#ifdef CONFIG_CLK_R9A07G054
> +const struct rzg2l_cpg_info r9a07g054_cpg_info =3D {
> +	/* Core Clocks */
> +	.core_clks =3D core_clks.common,
> +	.num_core_clks =3D ARRAY_SIZE(core_clks.common) + ARRAY_SIZE(core_clks.=
drp),
> +	.last_dt_core_clk =3D LAST_DT_CORE_CLK,
> +	.num_total_core_clks =3D MOD_CLK_BASE,
> +
> +	/* Critical Module Clocks */
> +	.crit_mod_clks =3D r9a07g044_crit_mod_clks,
> +	.num_crit_mod_clks =3D ARRAY_SIZE(r9a07g044_crit_mod_clks),
> +
> +	/* Module Clocks */
> +	.mod_clks =3D mod_clks.common,
> +	.num_mod_clks =3D ARRAY_SIZE(mod_clks.common) + ARRAY_SIZE(mod_clks.drp=
),
> +	.num_hw_mod_clks =3D R9A07G054_STPAI_ACLK_DRP + 1,
> +
> +	/* Resets */
> +	.resets =3D r9a07g044_resets,
> +	.num_resets =3D R9A07G054_STPAI_ARESETN + 1, /* Last reset ID + 1 */
>  };
> +#endif
> diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-=
cpg.c
> index edd0abe34a37..486d0656c58a 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -952,6 +952,12 @@ static const struct of_device_id rzg2l_cpg_match[] =
=3D {
>  		.compatible =3D "renesas,r9a07g044-cpg",
>  		.data =3D &r9a07g044_cpg_info,
>  	},
> +#endif
> +#ifdef CONFIG_CLK_R9A07G054
> +	{
> +		.compatible =3D "renesas,r9a07g054-cpg",
> +		.data =3D &r9a07g054_cpg_info,
> +	},
>  #endif
>  	{ /* sentinel */ }
>  };
> diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-=
cpg.h
> index 5729d102034b..ce657beaf160 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.h
> +++ b/drivers/clk/renesas/rzg2l-cpg.h
> @@ -203,5 +203,6 @@ struct rzg2l_cpg_info {
>  };
> =20
>  extern const struct rzg2l_cpg_info r9a07g044_cpg_info;
> +extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
> =20
>  #endif
> --=20
> 2.25.1
>=20

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYulWrwAKCRAw5/Bqldv6
8lmAAKCTQ7oOBwg9OCspfOZomL4eTZeLpwCcDFZmoc4nh11bKF1o+fAgJ2NOSTA=
=76ml
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--

