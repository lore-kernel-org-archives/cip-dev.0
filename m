Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B31FE9A74A
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 09:26:35 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15631.1774344385365221228
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 02:26:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=gUMZ8SDm;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0523510CC2D;
	Tue, 24 Mar 2026 10:26:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774344383;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tXzODnvqRkMNnLoJ5MohlQESogY7eil9j3zTLWdSD74=;
	b=gUMZ8SDmtOlAxE0Qmgeq/MBeEQkPyQkpU7pGy5mTmjSv7ydgVZn3hsq4igHWbCHF1r004T
	HKyI8WMYA4HwII6PmKXWse0cKDQjKpHRlaDZYFJXki9boVSvVdq17EgFVxfltkGmwCA2qu
	rzFSZuLUBiPNcWKtGlcK3XmJ4SvL2josuExLIG33NTnGYDv86r5V38+1iV3eI1UWdmOV+2
	wBdZFKUJu4MedELCG9f0C/UgnDa/L0ytAmUfZtrW+I1p3DcLVVn2h660j8OMFFznht5w+t
	SfhWcYmGk0EuIe03q5B4ku2FqRj+nEaKfPmri8P7zbKLzwL0Xw3afEuh8zyA/g==
Date: Tue, 24 Mar 2026 10:26:21 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 05/28] soc: renesas: rz-sysc: Populate
 readable_reg/writeable_reg in regmap config
Message-ID: <acJYvRx1EYafqZD_@duo.ucw.cz>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
 <20260311110357.1938200-6-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HNadcxxI8i2M5z5l"
Content-Disposition: inline
In-Reply-To: <20260311110357.1938200-6-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 09:26:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22542


--HNadcxxI8i2M5z5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi1

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit c432180a7d95081353a96fd6d5bd75b0fc8a27c3 upstream.
>=20
> Not all system controller registers are accessible from Linux. Accessing
> such registers generates synchronous external abort. Populate the
> readable_reg and writeable_reg members of the regmap config to inform the
> regmap core which registers can be accessed. The list will need to be
> updated whenever new system controller functionality is exported through
> regmap.
>=20

> +++ b/drivers/soc/renesas/r9a08g045-sysc.c
> @@ -18,7 +37,57 @@ static const struct rz_sysc_soc_id_init_data rzg3s_sys=
c_soc_id_init_data __initc
>  	.specific_id_mask =3D GENMASK(27, 0),
>  };
> =20
> +static bool rzg3s_regmap_readable_reg(struct device *dev, unsigned int r=
eg)
> +{
> +	switch (reg) {
> +	case SYS_XSPI_MAP_STAADD_CS0:
> +	case SYS_XSPI_MAP_ENDADD_CS0:
> +	case SYS_XSPI_MAP_STAADD_CS1:
> +	case SYS_XSPI_MAP_ENDADD_CS1:
> +	case SYS_GETH0_CFG:
> +	case SYS_GETH1_CFG:
> +	case SYS_PCIE_CFG:
> +	case SYS_PCIE_MON:
> +	case SYS_PCIE_ERR_MON:
> +	case SYS_PCIE_PHY:
> +	case SYS_I2C0_CFG:
> +	case SYS_I2C1_CFG:
> +	case SYS_I2C2_CFG:
> +	case SYS_I2C3_CFG:
> +	case SYS_I3C_CFG:
> +	case SYS_USB_PWRRDY:
> +	case SYS_PCIE_RST_RSM_B:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool rzg3s_regmap_writeable_reg(struct device *dev, unsigned int =
reg)
> +{
> +	switch (reg) {
> +	case SYS_XSPI_MAP_STAADD_CS0:
> +	case SYS_XSPI_MAP_ENDADD_CS0:
> +	case SYS_XSPI_MAP_STAADD_CS1:
> +	case SYS_XSPI_MAP_ENDADD_CS1:
> +	case SYS_PCIE_CFG:
> +	case SYS_PCIE_PHY:
> +	case SYS_I2C0_CFG:
> +	case SYS_I2C1_CFG:
> +	case SYS_I2C2_CFG:
> +	case SYS_I2C3_CFG:
> +	case SYS_I3C_CFG:
> +	case SYS_USB_PWRRDY:
> +	case SYS_PCIE_RST_RSM_B:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

I'd not mind refactoring these two so that code could be shared.

Thanks and best regards,
								Pavel

--HNadcxxI8i2M5z5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCacJYvQAKCRAw5/Bqldv6
8i2xAJ9zezpomyC+svMUtBDX2QcZVUJtsgCgjd9wGwhSJYkfV9FbqGYHPwYHbFo=
=IWbl
-----END PGP SIGNATURE-----

--HNadcxxI8i2M5z5l--

