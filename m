Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F660C28B2F
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 10:14:14 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.10521.1741947244767301516
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Mar 2025 03:14:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=G8wt3e6o;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF75110382F1A;
	Fri, 14 Mar 2025 11:14:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741947242; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=2GNat42GM46jDPkCdPBr1+GZZlMUhO/GtRo2SZdnIuw=;
	b=G8wt3e6oq4dD94eUhjx2w1CkFBNrBi++mprBkpM8AL21DDhguDMmM0XOClNCSbTYb9NI7B
	FJLSpvXkPgklmIpZ15oBpTlTdWtwo38Ds2gpnwfx7VTxnmNyzQJqRg64ZAKX6RbRAHyKWn
	JIDI2iobPsShRvkaoVjPmODdOOzJNAYS1IsrgjdBWIsa/0elLzUEuU+2QtYt4Ake1vVL0L
	L9Ew6dsL/4/QowZI5bY3U2pB6jhGSQaDzCPRvvg9Snsg7AVw8ABQzLGbnbV31cr3UTWmtg
	hfgMcjVvZsoyXPvclAtq6RaRD8zCbA82V8H1eKfmLYWX7UrSxTanIOX4rKlj5A==
Date: Fri, 14 Mar 2025 11:13:58 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 07/85] clk: renesas: rzv2h: Add support for
 dynamic switching divider clocks
Message-ID: <Z9QBZo4GgtMjid0v@duo.ucw.cz>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <20250312112302.1605750-8-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FNFs0Yo/rCuOHWcA"
Content-Disposition: inline
In-Reply-To: <20250312112302.1605750-8-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 10:14:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18210


--FNFs0Yo/rCuOHWcA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit bc4d25fdfadfa80dc3ba690792b5220d50ea7b52 upstream.
>=20
> Add support for dynamic switching divider clocks.


> +++ b/drivers/clk/renesas/rzv2h-cpg.c

> +static int rzv2h_ddiv_set_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long parent_rate)
> +{
> +	struct clk_divider *divider =3D to_clk_divider(hw);
> +	struct ddiv_clk *ddiv =3D to_ddiv_clock(divider);
> +	struct rzv2h_cpg_priv *priv =3D ddiv->priv;
> +	unsigned long flags =3D 0;
> +	int value;
> +	u32 val;
> +	int ret;
> +
> +	value =3D divider_get_val(rate, parent_rate, divider->table,
> +				divider->width, divider->flags);
> +	if (value < 0)
> +		return value;
> +
> +	spin_lock_irqsave(divider->lock, flags);
> +
> +	ret =3D rzv2h_cpg_wait_ddiv_clk_update_done(priv->base, ddiv->mon);
> +	if (ret)
> +		goto ddiv_timeout;
> +
> +	val =3D readl(divider->reg) | DDIV_DIVCTL_WEN(divider->shift);
> +	val &=3D ~(clk_div_mask(divider->width) << divider->shift);
> +	val |=3D (u32)value << divider->shift;
> +	writel(val, divider->reg);
> +
> +	ret =3D rzv2h_cpg_wait_ddiv_clk_update_done(priv->base, ddiv->mon);
v-- from here
> +	if (ret)
> +		goto ddiv_timeout;
> +
> +	spin_unlock_irqrestore(divider->lock, flags);
> +
> +	return 0;
> +
^-- to here
> +ddiv_timeout:
> +	spin_unlock_irqrestore(divider->lock, flags);
> +	return ret;
> +}

Marked code can be simply deleted.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FNFs0Yo/rCuOHWcA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9QBZgAKCRAw5/Bqldv6
8rzcAKC2tPHiyibdLtoBWijBfHRI8XJrvACfXVt6PDYd9tn1R3c66/Lk5iYtXE8=
=lKwB
-----END PGP SIGNATURE-----

--FNFs0Yo/rCuOHWcA--

