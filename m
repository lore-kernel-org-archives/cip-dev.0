Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FE6C36000
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 20:08:47 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.2876.1742587717173256764
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 13:08:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=erSZJudC;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C612F10206773;
	Fri, 21 Mar 2025 21:08:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742587715; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=XqUHPjJwYJHPpu6Wcs+pivYB8TyLpeCEy28c/GQlhto=;
	b=erSZJudCYwC7iy/8WzXNIrNJOtVyXyoy9gWraxTrOU2/HFYidE7ldMXV7+Phd733q1TyyJ
	ltUJzGWACxkESKnVPqBBRH5Wy9afpKEQH7yCOlUFtvdzOaUwKn7qXuU9UIAn3L71F+WJhv
	JQUSNDZVNaVTVKUY/8Fs807YRxsJb9pfGASAmnAOYRtKhg+lD4+VrMNW+PufXCIM2rCjUU
	T9LWboJJK5R4+n51WF6RR/5JEueXP0q5EmKvGx99D5Bf8IOgSpBXGRzRVT/ejlfseqzjh7
	wz6CK7LcjV4edC+VbEquPUVL7wpmJ85j6aMW5mY0PxuUfmF60Ag6zi/w5zZlZg==
Date: Fri, 21 Mar 2025 21:08:28 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 05/21] clk: renesas: Add family-specific clock
 driver for RZ/V2H(P)
Message-ID: <Z93HPMEut+5uQsjS@duo.ucw.cz>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
 <20250321110021.3612805-6-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DExBhGl3FVWI/bmd"
Content-Disposition: inline
In-Reply-To: <20250321110021.3612805-6-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 20:08:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18329


--DExBhGl3FVWI/bmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit dd22e56217495e2d392ded86a1e11a908e424e64 upstream.
>=20
> Add family-specific clock driver for RZ/V2H(P) SoCs.

> +#include "rzv2h-cpg.h"
> +
> +#ifdef DEBUG
> +#define WARN_DEBUG(x)		WARN_ON(x)
> +#else
> +#define WARN_DEBUG(x)		do { } while (0)
> +#endif

Normally, we use DEBUG for enabling debug prints, they should not
modify behaviour.

> +static void __init
> +rzv2h_cpg_register_core_clk(const struct cpg_core_clk *core,
> +			    struct rzv2h_cpg_priv *priv)
> +{
> +	struct clk *clk =3D ERR_PTR(-EOPNOTSUPP), *parent;
> +	unsigned int id =3D core->id, div =3D core->div;
> +	struct device *dev =3D priv->dev;
> +	const char *parent_name;
> +	struct clk_hw *clk_hw;
> +
> +	WARN_DEBUG(id >=3D priv->num_core_clks);
> +	WARN_DEBUG(PTR_ERR(priv->clks[id]) !=3D -ENOENT);

Are you sure this is safe to do? if id is more than num_core_clock,
we'll still proceed and do out-of-array read/write.

If this truly can not happen, that's okay, but...

=2E..
> +	dev_dbg(dev, "Core clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
> +	priv->clks[id] =3D clk;
> +	return;

> +static void __init
> +rzv2h_cpg_register_mod_clk(const struct rzv2h_mod_clk *mod,
> +			   struct rzv2h_cpg_priv *priv)
> +{
> +	struct mod_clock *clock =3D NULL;
> +	struct device *dev =3D priv->dev;
> +	struct clk_init_data init;
> +	struct clk *parent, *clk;
> +	const char *parent_name;
> +	unsigned int id;
> +	int ret;
> +
> +	id =3D GET_MOD_CLK_ID(priv->num_core_clks, mod->on_index, mod->on_bit);
> +	WARN_DEBUG(id >=3D priv->num_core_clks + priv->num_mod_clks);
> +	WARN_DEBUG(mod->parent >=3D priv->num_core_clks + priv->num_mod_clks);
> +	WARN_DEBUG(PTR_ERR(priv->clks[id]) !=3D -ENOENT);

Same here.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--DExBhGl3FVWI/bmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ93HPAAKCRAw5/Bqldv6
8s+IAJoDDpAagclyf0fdAB7ZUkH1sHS9ngCeMcYFpsRF+3cMbWNTt2jzI/MMe4Q=
=fs29
-----END PGP SIGNATURE-----

--DExBhGl3FVWI/bmd--

