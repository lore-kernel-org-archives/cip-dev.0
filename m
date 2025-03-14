Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FAAC282EC
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 10:12:24 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.10627.1741947134247811360
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Mar 2025 03:12:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Rel2N49X;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 965E2103BB5FD;
	Fri, 14 Mar 2025 11:12:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741947132; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ZaUhnfMWUm3a12F1LI6LmeTUgvY79Jfbzc7S+e3B6Go=;
	b=Rel2N49XKGcuLA6k86US+1McX4h5hyj8GJbsR3USsgzb2WEINTX+oLaxAE3jsvbBxeen8I
	QhfnT2dHN94E6BqqK5CrIMkv5J00lBby096yQZ/OOzqA016eWX1ZlsdM6ezDWVgmHa6Zpn
	lVddFzAXDjG5RJsjUW2SLTyllE3MGBO/4jyBFVom48qO3tWwgH/519801koQux8MSc667o
	xaDPQCZhNm35LLSgeriVH2vlvZFvxEpMe/7gwUPuALGKgn7D5aAn1eR703Kv7Sqknj/Si8
	7cUTBwqkDENkRdw8zm1TBcuUxb+9IZSvyiiC6MSAx9wAhznD3j4FjTLwhR1VSw==
Date: Fri, 14 Mar 2025 11:12:06 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 05/85] clk: renesas: Add family-specific clock
 driver for RZ/V2H(P)
Message-ID: <Z9QA9rwuXCuVbOXp@duo.ucw.cz>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <20250312112302.1605750-6-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JC3A0iCqzum6BN9B"
Content-Disposition: inline
In-Reply-To: <20250312112302.1605750-6-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 10:12:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18209


--JC3A0iCqzum6BN9B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit dd22e56217495e2d392ded86a1e11a908e424e64 upstream.
>=20
> Add family-specific clock driver for RZ/V2H(P) SoCs.

So RZ/V2H... seems to be something different than "RZ/G3E" SoC. Good
place to split the series?

> --- /dev/null
> +++ b/drivers/clk/renesas/rzv2h-cpg.c
> +static int rzv2h_cpg_assert(struct reset_controller_dev *rcdev,
> +			    unsigned long id)
> +{
> +	struct rzv2h_cpg_priv *priv =3D rcdev_to_priv(rcdev);
> +	unsigned int reg =3D GET_RST_OFFSET(priv->resets[id].reset_index);
> +	u32 mask =3D BIT(priv->resets[id].reset_bit);
> +	u8 monbit =3D priv->resets[id].mon_bit;
> +	u32 value =3D mask << 16;
> +
> +	dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id, reg);
> +
> +	writel(value, priv->base + reg);
> +
> +	reg =3D GET_RST_MON_OFFSET(priv->resets[id].mon_index);
> +	mask =3D BIT(monbit);
> +
> +	return readl_poll_timeout_atomic(priv->base + reg, value,
> +					 value & mask, 10, 200);
> +}
> +
> +static int rzv2h_cpg_deassert(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct rzv2h_cpg_priv *priv =3D rcdev_to_priv(rcdev);
> +	unsigned int reg =3D GET_RST_OFFSET(priv->resets[id].reset_index);
> +	u32 mask =3D BIT(priv->resets[id].reset_bit);
> +	u8 monbit =3D priv->resets[id].mon_bit;
> +	u32 value =3D (mask << 16) | mask;
> +
> +	dev_dbg(rcdev->dev, "deassert id:%ld offset:0x%x\n", id, reg);
> +
> +	writel(value, priv->base + reg);
> +
> +	reg =3D GET_RST_MON_OFFSET(priv->resets[id].mon_index);
> +	mask =3D BIT(monbit);
> +
> +	return readl_poll_timeout_atomic(priv->base + reg, value,
> +					 !(value & mask), 10, 200);
> +}

Assert&deassert are fairly similar, can you share the code.

(This and the other cleanups are not critical, will not block merge,
but may be worth fixing in mainline).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JC3A0iCqzum6BN9B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9QA9gAKCRAw5/Bqldv6
8jYbAKCYeGdHtrXNGAcwZS5ALY7P5lxrxQCeNiv5nk8eRgM6ZHFhgj3VPqiYiZM=
=T337
-----END PGP SIGNATURE-----

--JC3A0iCqzum6BN9B--

