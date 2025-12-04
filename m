Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23D5D1F9B1
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 10:43:34 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40674.1764845011259300980
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 02:43:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=HgHnxtdL;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E51F106A9C52;
	Thu,  4 Dec 2025 11:43:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764845009; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=gcMwW/XJFS/QF5H4PScU6nJNysX/975Xr+/M+CYIVYk=;
	b=HgHnxtdLmsXEF1XS8gnpjAeCukd9LM1K0MfSwbwvJUdU/RoJrGlIj/4Q4a7TXib3qCNZri
	DO4xppCsdKAJDbB6vTEClf1Rc2zlVs7eKC9Ds+O2KvD/gDRBCrUL5H2adhdmjbuPTB4q1B
	a4bUSi20GgrGqNRthIz78BSBPC7eGrmZdM/ptUzjDG8NOfegXrUZI2pQX5VzX0ZfNTESZB
	qfEV/NZep4K5jgMr9CdpYUkU6B2LeuwNB4C1WOEXup6bmO9jIMKPvwy1x6kMnBCTF9yNcG
	UXH3tnqj3a0svSi6DG48EsS/StveQJk9zUBFjR2v41pEPlD3YHX9XUNdsW6KMA==
Date: Thu, 4 Dec 2025 11:43:26 +0100
From: Pavel Machek <pavel@denx.de>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 05/12] soc: renesas: rz-sysc: Add SoC
 identification for RZ/V2N SoC
Message-ID: <aTFlzjpLCnKUTDKK@duo.ucw.cz>
References: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
 <20251203153757.32977-6-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="51VbqksFvKX2hM3Z"
Content-Disposition: inline
In-Reply-To: <20251203153757.32977-6-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:43:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20841


--51VbqksFvKX2hM3Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit 3903b4701bc03d7d805c3df378a7fc2ff72cbef5 upstream.
>=20
> Add SoC identification for the RZ/V2N SoC using the System Controller
> (SYS) block.

So this is kind of strange driver: it gets hardware description,
prints it to dmesg, and that's it. No sysfs interface, no interface
for other kernel parts, no nothing.

Best regards,
								Pavel

> +++ b/drivers/soc/renesas/r9a09g056-sys.c
> +static void rzv2n_sys_print_id(struct device *dev,
> +			       void __iomem *sysc_base,
> +			       struct soc_device_attribute *soc_dev_attr)
> +{
> +	u32 prr_val, mode_val;
> +	u8 feature_flags;
> +
> +	prr_val =3D readl(sysc_base + SYS_LSI_PRR);
> +	mode_val =3D readl(sysc_base + SYS_LSI_MODE);
> +
> +	/* Check GPU, ISP and Cryptographic configuration */
> +	feature_flags =3D !(prr_val & SYS_LSI_PRR_GPU_DIS) ? SYS_RZV2N_FEATURE_=
G31 : 0;
> +	feature_flags |=3D !(prr_val & SYS_LSI_PRR_ISP_DIS) ? SYS_RZV2N_FEATURE=
_C55 : 0;
> +	feature_flags |=3D (mode_val & SYS_LSI_MODE_SEC_EN) ? SYS_RZV2N_FEATURE=
_SEC : 0;
> +
> +	dev_info(dev, "Detected Renesas %s %sn%d Rev %s%s%s%s%s\n", soc_dev_att=
r->family,
> +		 soc_dev_attr->soc_id, 41 + feature_flags, soc_dev_attr->revision,
> +		 feature_flags ?  " with" : "",
> +		 feature_flags & SYS_RZV2N_FEATURE_G31 ? " GE3D (Mali-G31)" : "",
> +		 feature_flags & SYS_RZV2N_FEATURE_SEC ? " Cryptographic engine" : "",
> +		 feature_flags & SYS_RZV2N_FEATURE_C55 ? " ISP (Mali-C55)" : "");
> +
> +	/* Check CA55 PLL configuration */
> +	if (FIELD_GET(SYS_LSI_MODE_STAT_BOOTPLLCA55, mode_val) !=3D SYS_LSI_MOD=
E_CA55_1_7GHZ)
> +		dev_warn(dev, "CA55 PLL is not set to 1.7GHz\n");
> +}
> +
> +static const struct rz_sysc_soc_id_init_data rzv2n_sys_soc_id_init_data =
__initconst =3D {
> +	.family =3D "RZ/V2N",
> +	.id =3D 0x867d447,
> +	.devid_offset =3D 0x304,
> +	.revision_mask =3D GENMASK(31, 28),
> +	.specific_id_mask =3D GENMASK(27, 0),
> +	.print_id =3D rzv2n_sys_print_id,
> +};
> +
> +const struct rz_sysc_init_data rzv2n_sys_init_data =3D {
> +	.soc_id_init_data =3D &rzv2n_sys_soc_id_init_data,
> +};

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--51VbqksFvKX2hM3Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaTFlzgAKCRAw5/Bqldv6
8qvkAKCz2myNFZyivuT0aqXdNXaUWKm6fwCgvqZIv4D/YrVqj15fTfJ1QbkqQUY=
=erAi
-----END PGP SIGNATURE-----

--51VbqksFvKX2hM3Z--

