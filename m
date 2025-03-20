Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57134C28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 08:59:07 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.3067.1742461146099003928
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Mar 2025 01:59:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=VOdg5FRz;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0AC1101E91CA;
	Thu, 20 Mar 2025 09:58:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742461144; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=J4J7p56B11qV1r/xoWNwHJrVL8KOcVZuLCWskB2vAvM=;
	b=VOdg5FRzOnBWVVJ2+3gGf4OQIDpECdVHrZUGxPoM2eMekskaWcBTgprb8+mHCY1Fw31Vt2
	RAfKQdNo4qQYiPfI0RdHqC/bg15ij6KybtMVLUeNyIc+39YvibVybbeW7u30S3q1OI7fuh
	x58SxdwFpYM/0Mt35Zufg75WCIx5ZnID3XA2VFEUxvREyUWrFaA2NkirTtuBcwjDqWiWK4
	7rdQZFaJmhkNLIrd/zSn4frZjgCTwrJe1/lVZaoiIkV5ATSHTabS9LE7Z4Wo4kz4aI4T2G
	xwvcudX8oWifkZC6H9mzePjjCqJar1tjTL9i23p0SGgxazbr28Pr+CamomykcQ==
Date: Thu, 20 Mar 2025 09:58:57 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 08/85] clk: renesas: rzv2h: Add selective
 Runtime PM support for clocks
Message-ID: <Z9vY0Qu0COR469mD@duo.ucw.cz>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <20250312112302.1605750-9-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JpnRwnX10YYr5F+2"
Content-Disposition: inline
In-Reply-To: <20250312112302.1605750-9-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 08:59:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18288


--JpnRwnX10YYr5F+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> +static bool rzv2h_cpg_is_pm_clk(struct rzv2h_cpg_pd *pd,
> +				const struct of_phandle_args *clkspec)
> +{
> +	if (clkspec->np !=3D pd->genpd.dev.of_node || clkspec->args_count !=3D =
2)
> +		return false;
> +
> +	switch (clkspec->args[0]) {
> +	case CPG_MOD: {
> +		struct rzv2h_cpg_priv *priv =3D pd->priv;
> +		unsigned int id =3D clkspec->args[1];
> +		struct mod_clock *clock;
> +
> +		if (id >=3D priv->num_mod_clks)
> +			return false;
> +
> +		if (priv->clks[priv->num_core_clks + id] =3D=3D ERR_PTR(-ENOENT))
> +			return false;
> +
> +		clock =3D to_mod_clock(__clk_get_hw(priv->clks[priv->num_core_clks + i=
d]));
> +
> +		return !clock->no_pm;
> +	}
> +
> +	case CPG_CORE:
> +	default:
> +		return false;
> +	}
> +}

Are there more entries likely to be added to the switch? If not, I
guess this should be

      if (clkspec->args[0] !=3D CPG_MOD)
      	     return false;

and then getting rid of the switch.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JpnRwnX10YYr5F+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9vY0QAKCRAw5/Bqldv6
8rsEAKCU+VzkKjgcHi/hc4gLruxbrlanJgCeLLQcBa4bcCIRdOVl6FUhYOM64Gs=
=JGX5
-----END PGP SIGNATURE-----

--JpnRwnX10YYr5F+2--

