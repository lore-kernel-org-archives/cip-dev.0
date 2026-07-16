Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37D2C4450A
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 07:47:24 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7636.1784188039827252652
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 00:47:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=SSFI+b+I;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0B1E5118471;
	Thu, 16 Jul 2026 09:47:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784188037;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=sGTlYKhgFaiKPqMbn2vjtihfOz/m/oj/pFUsE+VU0bs=;
	b=SSFI+b+Ib3NYfnjHkxB9juaYf18sibJkdihqU7CQJ3npwapUnTRRXAtsNRhfuX97W0Npgv
	88XFOSRwGg6Rw15bIZrOp56THDddHNDsPPEvG8veEsA09IvSVMaIu1ZYwnWI2Vf/deg7gD
	1R5pJahB+vtTUoehAFsIuBAVzXw04tPEJGXqy8/glszLdzMTkTC84ttDNl46R80W4/J5Ky
	DKGx+KvH/Pg6/d3tn3H49xLlhXUdGjtVsLwphLomkE188Z1yAU2Tra3tv35Bj78vg/dUxc
	XeeowStHkH3fO3FUQWG3MUXPD6IysyJxWx+j/QXOpThzI444ZcZm70yggkgtEg==
Date: Thu, 16 Jul 2026 09:47:12 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 09/39] soc: renesas: rz-sysc: Add SoC
 identification for RZ/G3L SoC
Message-ID: <aliMgPlRT8B8awZq@duo.ucw.cz>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
 <20260630114813.92739-10-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bBpVSGQHRUNeYZGd"
Content-Disposition: inline
In-Reply-To: <20260630114813.92739-10-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 07:47:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23609


--bBpVSGQHRUNeYZGd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> [ Upstream commit b1de9823fdc67a8e9cd0dcf1f6f0e9780d425d4e ]
>=20
> Add SoC identification for the RZ/G3L SoC using the System Controller
> (SYSC) block.

> +++ b/drivers/soc/renesas/r9a08g046-sysc.c
> @@ -0,0 +1,91 @@
> +
> +static bool rzg3l_regmap_readable_reg(struct device *dev, unsigned int r=
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
> +	case SYS_PCIE_PHY:
> +	case SYS_I2C0_CFG:
> +	case SYS_I2C1_CFG:
> +	case SYS_I2C2_CFG:
> +	case SYS_I2C3_CFG:
> +	case SYS_I3C_CFG:
> +	case SYS_PWRRDY_N:
> +	case SYS_IPCONT_SEL_CLONECH:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool rzg3l_regmap_writeable_reg(struct device *dev, unsigned int =
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
> +	case SYS_PWRRDY_N:
> +	case SYS_IPCONT_SEL_CLONECH:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

For the record, I believe one of these functions should be calling the
other one to lessen code duplication.

Best regards,
								Pavel

--bBpVSGQHRUNeYZGd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaliMgAAKCRAw5/Bqldv6
8tY7AJ9cqDTqS8SICY/3qNCMjTmnlfNYmACgpsFFATbmHU0T+IOR5rOud174Qh8=
=cDD/
-----END PGP SIGNATURE-----

--bBpVSGQHRUNeYZGd--

