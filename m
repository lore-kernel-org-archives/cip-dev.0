Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A19C36000
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 20:11:07 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.2915.1742587866036119135
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 13:11:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Rz3GgSYG;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 65570101E90A8;
	Fri, 21 Mar 2025 21:11:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742587863; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=l4HzokC6+RkiSvRCMgFNXVwT5u+RWNUfxVPZQqmihfI=;
	b=Rz3GgSYGAB8v1FDV5YwZmY2ay8/TB4Ld8h4XU324sopVRJbpjBA6wmmKKX2iZbceGNjvmR
	rSeYEXzCLTeq0lqIlZIZnsxRIQYNCZ7O8flxwMbY8WivQkpJ13J2Om02LSJYPRwqE3HWt2
	Wsmq4rx8Ihqws+ky5N9XgHdPpMfCgMg5oyUmZAYV0htiDvcmJiIa14Nj5PiaswtOFpdlR6
	0JQhqP0/BD+WvmpWEr9SwDq6Lsh/QCx+GDX5sMYoRho9z47PdmRtt4B3o4EpggcGMm6ECl
	W+D7HcPH5ca6oIsvy+/wQTbb8r1nEoTtQszHaoZEiITMTPSqCkBcSnBz/++D9w==
Date: Fri, 21 Mar 2025 21:10:58 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 13/21] clk: renesas: rzv2h: Add MSTOP support
Message-ID: <Z93H0jNRuKYCShoZ@duo.ucw.cz>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
 <20250321110021.3612805-14-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Oz6ENn0zY3xxe1Eo"
Content-Disposition: inline
In-Reply-To: <20250321110021.3612805-14-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 20:11:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18330


--Oz6ENn0zY3xxe1Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> commit 9b6e63a777ea5fb85bf24f9cb5ba902eed4f1f2f upstream.
>=20
> Add MSTOP support to control buses for the individual units on RZ/V2H.
> Use per-bit (instead of group-based) configuration and atomic counters,
> to ensure precise control over individual MSTOP bits, and to prevent
> issues with shared dependencies between module clocks.
>

> +++ b/drivers/clk/renesas/rzv2h-cpg.c
> @@ -64,6 +68,7 @@
>   * @resets: Array of resets
>   * @num_resets: Number of Module Resets in info->resets[]
>   * @last_dt_core_clk: ID of the last Core Clock exported to DT
> + * @mstop_count: Array of mstop values
>   * @rcdev: Reset controller entity
>   */
>  struct rzv2h_cpg_priv {
> @@ -78,6 +83,8 @@ struct rzv2h_cpg_priv {
>  	unsigned int num_resets;
>  	unsigned int last_dt_core_clk;
> =20
> +	atomic_t *mstop_count;
> +

So this one is interesting. There's atomic_t,

> +static void rzv2h_mod_clock_mstop_enable(struct rzv2h_cpg_priv *priv,
> +					 u32 mstop_data)
> +{
> +	unsigned long mstop_mask =3D FIELD_GET(BUS_MSTOP_BITS_MASK, mstop_data);
> +	u16 mstop_index =3D FIELD_GET(BUS_MSTOP_IDX_MASK, mstop_data);
> +	unsigned int index =3D (mstop_index - 1) * 16;
> +	atomic_t *mstop =3D &priv->mstop_count[index];
> +	unsigned long flags;
> +	unsigned int i;
> +	u32 val =3D 0;
> +
> +	spin_lock_irqsave(&priv->rmw_lock, flags);
> +	for_each_set_bit(i, &mstop_mask, 16) {
> +		if (!atomic_read(&mstop[i]))
> +			val |=3D BIT(i) << 16;
> +		atomic_inc(&mstop[i]);
> +	}

but then it seems to be accessed under spinlock in all cases. Is
atomic_t needed? If so, comment why we still need the atomic would be
nice.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Oz6ENn0zY3xxe1Eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ93H0gAKCRAw5/Bqldv6
8qimAJ9sKLX84BTBFgMK6NyrPpanp22D7QCgsGK8lJWGYB1g2JIrupTlnDlSeYE=
=cT89
-----END PGP SIGNATURE-----

--Oz6ENn0zY3xxe1Eo--

