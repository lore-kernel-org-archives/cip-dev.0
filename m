Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39D6C433F5
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 10:11:02 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4468.1639735860923079113
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 02:11:02 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 36DD61C0B81; Fri, 17 Dec 2021 11:10:55 +0100 (CET)
Date: Fri, 17 Dec 2021 11:10:54 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 05/24] clk: renesas: Add CPG core wrapper for
 RZ/G2L SoC
Message-ID: <20211217101053.GA17079@amd>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211216125446.15451-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20211216125446.15451-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 10:11:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7170


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit ef3c613ccd68a78727b817c3dacf4a68d1ffc67f upstream.
>=20
> Add CPG core wrapper for RZ/G2L family.
>=20
> Based on a patch in the BSP by Binh Nguyen
> <binh.nguyen.jz@renesas.com>.

Some comments below.

> +static struct clk * __init
> +rzg2l_cpg_pll_clk_register(const struct cpg_core_clk *core,
=2E..
> +	pll_clk =3D devm_kzalloc(dev, sizeof(*pll_clk), GFP_KERNEL);
> +	if (!pll_clk) {
> +		clk =3D ERR_PTR(-ENOMEM);
> +		return NULL;
> +	}

I believe this wanted to return clk? But I'd recommend just directly
returning the ERR_PTR().

> +static struct clk
> +*rzg2l_cpg_clk_src_twocell_get(struct of_phandle_args *clkspec,
> +			       void *data)
=2E..
> +	if (IS_ERR(clk))
> +		dev_err(dev, "Cannot get %s clock %u: %ld", type, clkidx,
> +			PTR_ERR(clk));

Is "\n" missing?

> +static void __init
> +rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
> +			   const struct rzg2l_cpg_info *info,
> +			   struct rzg2l_cpg_priv *priv)
> +{
> +	struct mstp_clock *clock =3D NULL;
=2E..
> +	parent =3D priv->clks[mod->parent];
> +	if (IS_ERR(parent)) {
> +		clk =3D parent;
> +		goto fail;
> +	}
> +
> +	clock =3D devm_kzalloc(dev, sizeof(*clock), GFP_KERNEL);
> +	if (!clock) {
> +		clk =3D ERR_PTR(-ENOMEM);
> +		goto fail;
> +	}
=2E..
> +fail:
> +	dev_err(dev, "Failed to register %s clock %s: %ld\n", "module",
> +		mod->name, PTR_ERR(clk));
> +	kfree(clock);

Should this be devm_kfree? (And is devm_kfree(NULL) ok?)

> +static bool rzg2l_cpg_is_pm_clk(const struct of_phandle_args *clkspec)
> +{
> +	if (clkspec->args_count !=3D 2)
> +		return false;
> +
> +	switch (clkspec->args[0]) {
> +	case CPG_MOD:
> +		return true;
> +
> +	default:
> +		return false;
> +	}
> +}

"return clkspec->args[0] =3D=3D CPG_MOD" would be simpler way to say this.

> +static int __init rzg2l_cpg_probe(struct platform_device *pdev)
> +{
=2E..
> +	error =3D rzg2l_cpg_reset_controller_register(priv);
> +	if (error)
> +		return error;
> +
> +	return 0;
> +}

You can just return error unconditionally.

> +static const struct of_device_id rzg2l_cpg_match[] =3D {
> +	{ /* sentinel */ }
> +};

It matches nothing? Aha, id is added in next patch.

> +/**
> + * Definitions of CPG Core Clocks
> + *
> + * These include:
> + *   - Clock outputs exported to DT
> + *   - External input clocks
> + *   - Internal CPG clocks
> + */

This is not kerneldoc -> should not be marked with /**.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmG8Yi0ACgkQMOfwapXb+vLkkQCfaCF4omnAipEUMgokn/nlEgSM
hj4An3ZC5xKR9/ym8YPcSJKfJMSQXPtg
=sDPO
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

