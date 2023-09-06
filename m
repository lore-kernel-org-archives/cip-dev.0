Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE451EB8FA5
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 08:41:50 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4122.1693989709041383545
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 01:41:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 025941C000B; Wed,  6 Sep 2023 10:41:46 +0200 (CEST)
Date: Wed, 6 Sep 2023 10:41:45 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 03/20] drm: rcar-du: Add RZ/G2L DSI driver
Message-ID: <ZPg7STHDn4LbLy7f@duo.ucw.cz>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
 <20230905160737.167877-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7wBeypp5rG9e4Bey"
Content-Disposition: inline
In-Reply-To: <20230905160737.167877-4-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 08:41:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12980


--7wBeypp5rG9e4Bey
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 7a043f978ed1433bddb088a732e9bb91501ebd76 upstream.
>=20
> This driver supports the MIPI DSI encoder found in the RZ/G2L
> SoC. It currently supports DSI video mode only.

Tiny nits:


> --- /dev/null
> +++ b/drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c
=2E..
> +static int rzg2l_mipi_dsi_start_video(struct rzg2l_mipi_dsi *dsi)
> +{
> +	u32 vich1set0r;
> +	u32 status;
> +	int ret;
> +
> +	/* Configuration for Blanking sequence and start video input*/

" */".

> +++ b/drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi_regs.h
> @@ -0,0 +1,151 @@
> +/* DPHY Registers */
> +#define DSIDPHYCTRL0			0x00
> +#define DSIDPHYCTRL0_CAL_EN_HSRX_OFS	BIT(16)
> +#define DSIDPHYCTRL0_CMN_MASTER_EN	BIT(8)
> +#define DSIDPHYCTRL0_RE_VDD_DETVCCQLV18	BIT(2)
> +#define DSIDPHYCTRL0_EN_LDO1200		BIT(1)
> +#define DSIDPHYCTRL0_EN_BGR		BIT(0)
=2E..

> +/* HS Clock Set Register */
> +#define HSCLKSETR			0x104
> +#define HSCLKSETR_HSCLKMODE_CONT	(1 << 1)
> +#define HSCLKSETR_HSCLKMODE_NON_CONT	(0 << 1)
> +#define HSCLKSETR_HSCLKRUN_HS		(1 << 0)
> +#define HSCLKSETR_HSCLKRUN_LP		(0 << 0)

Mixing of BIT() and << looks kind of strange. Plus (0 << 0) is kind of
strange way to say 0. Not sure if this is worth fixing, but usually
people would not do special define for "NON_CONT" when it is 0 and
they already have "CONT" defined.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7wBeypp5rG9e4Bey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZPg7SQAKCRAw5/Bqldv6
8ouLAJ4+nBd8dB0s/4N6XTj28CZHHrd0jQCfW7LnW/ppI246JukRpG9fH3xT1sk=
=/ZSD
-----END PGP SIGNATURE-----

--7wBeypp5rG9e4Bey--

