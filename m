Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABDEC28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 09:03:07 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.2987.1742461382544229161
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Mar 2025 02:03:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=OoCC0P3A;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CF00101E91CA;
	Thu, 20 Mar 2025 10:02:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742461380; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QHg+qTsXE+7llbq0Op26Y1LBt1B8qjStfw7GXw2PBHQ=;
	b=OoCC0P3Ad45FmUY/I0+u43VXFn/xFGuF3WrdbkuczMI1MHY+jyqaeydDaevTXgGiHHD2+A
	AKQs0ZUcPg4WzfvvHaETzaACblb212u6Bs7eWD4jcZsLInDazJHUFTqTQXdME8tgemO2aR
	t/AwVj0vZyNZoVHzmMk+c4KOMynRCjX6rp6EcGZeURzDh+/bcG6aWJZ5iQ7j0SALC1AG2p
	v1nT3vwNbRddNG0l8nbpno+U/69VxmdGLzSMhrYq0IWpz6MlzuYj4Fn7OGfKZxP7opDMjY
	abBhxqvmfx3Z/WbW9twKz3nVby0F+KHrJ/V1Q4AHCoI97fiBgq9MvTPydBdbGA==
Date: Thu, 20 Mar 2025 10:02:55 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 13/85] clk: renesas: rzv2h: Add MSTOP support
Message-ID: <Z9vZv+yUxREwK8FC@duo.ucw.cz>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <20250312112302.1605750-14-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OPVODEaHzTVVYbg9"
Content-Disposition: inline
In-Reply-To: <20250312112302.1605750-14-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 09:03:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18289


--OPVODEaHzTVVYbg9
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
>=20
> Co-developed-by: Biju Das <biju.das.jz@bp.renesas.com>

> +++ b/drivers/clk/renesas/r9a09g057-cpg.c
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
> +	if (val)
> +		writel(val, priv->base + CPG_BUS_MSTOP(mstop_index));
> +	spin_unlock_irqrestore(&priv->rmw_lock, flags);
> +}
> +
> +static void rzv2h_mod_clock_mstop_disable(struct rzv2h_cpg_priv *priv,
> +					  u32 mstop_data)
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
> +		if (!atomic_read(&mstop[i]) ||
> +		    atomic_dec_and_test(&mstop[i]))
> +			val |=3D BIT(i) << 16 | BIT(i);
> +	}
> +	if (val)
> +		writel(val, priv->base + CPG_BUS_MSTOP(mstop_index));
> +	spin_unlock_irqrestore(&priv->rmw_lock, flags);
> +}

> @@ -555,6 +619,41 @@ rzv2h_cpg_register_mod_clk(const struct rzv2h_mod_cl=
k *mod,
> =20
>  	priv->clks[id] =3D clock->hw.clk;
> =20
> +	/*
> +	 * Ensure the module clocks and MSTOP bits are synchronized when they a=
re
> +	 * turned ON by the bootloader. Enable MSTOP bits for module clocks tha=
t were
> +	 * turned ON in an earlier boot stage.
> +	 */
> +	if (clock->mstop_data !=3D BUS_MSTOP_NONE &&
> +	    !mod->critical && rzv2h_mod_clock_is_enabled(&clock->hw)) {
> +		rzv2h_mod_clock_mstop_enable(priv, clock->mstop_data);
> +	} else if (clock->mstop_data !=3D BUS_MSTOP_NONE && mod->critical) {
> +		unsigned long mstop_mask =3D FIELD_GET(BUS_MSTOP_BITS_MASK, clock->mst=
op_data);
> +		u16 mstop_index =3D FIELD_GET(BUS_MSTOP_IDX_MASK, clock->mstop_data);
> +		unsigned int index =3D (mstop_index - 1) * 16;
> +		atomic_t *mstop =3D &priv->mstop_count[index];
> +		unsigned long flags;
> +		unsigned int i;
> +		u32 val =3D 0;
> +
> +		/*
> +		 * Critical clocks are turned ON immediately upon registration, and the
> +		 * MSTOP counter is updated through the rzv2h_mod_clock_enable() path.
> +		 * However, if the critical clocks were already turned ON by the initi=
al
> +		 * bootloader, synchronize the atomic counter here and clear the MSTOP=
 bit.
> +		 */
> +		spin_lock_irqsave(&priv->rmw_lock, flags);
> +		for_each_set_bit(i, &mstop_mask, 16) {
> +			if (atomic_read(&mstop[i]))
> +				continue;
> +			val |=3D BIT(i) << 16;
> +			atomic_inc(&mstop[i]);
> +		}
> +		if (val)
> +			writel(val, priv->base + CPG_BUS_MSTOP(mstop_index));
> +		spin_unlock_irqrestore(&priv->rmw_lock, flags);

If these three could somehow be shared, it would be nice.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OPVODEaHzTVVYbg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9vZvwAKCRAw5/Bqldv6
8h28AJ9p8qMxClCvCk3Gf+Xrom66t3syWACgkcKtOv3T88GdOBPQwVjoIImXNYs=
=S3o0
-----END PGP SIGNATURE-----

--OPVODEaHzTVVYbg9--

