Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6329D1268D
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 11:32:48 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.15588.1730806362677009768
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Nov 2024 03:32:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D60FC1C00B2; Tue,  5 Nov 2024 12:32:39 +0100 (CET)
Date: Tue, 5 Nov 2024 12:32:39 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 5.10.y-cip 11/28] media: platform: Add Renesas RZ/G2L
 CRU driver
Message-ID: <ZyoCV4ZzNVrcO3rg@duo.ucw.cz>
References: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20241101125746.33222-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FMj14vdOq2MD0w2M"
Content-Disposition: inline
In-Reply-To: <20241101125746.33222-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Nov 2024 11:32:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17173


--FMj14vdOq2MD0w2M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 07fc05bd0a797dcc34620869933993e1cbf56b98 upstream.
>=20
> Add v4l driver for Renesas RZ/G2L Camera data Receiving Unit.
>=20
> Based on a patch in the BSP by Hien Huynh
> <hien.huynh.px@renesas.com>

> +/**
> + * struct rzg2l_cru_dev - Renesas CRU device structure
> + * @dev:		(OF) device
> + * @base:		device I/O register space remapped to virtual memory
> + * @info:		info about CRU instance
> + *
=2E..
> + * @num_buf:		Holds the current number of buffers enabled
> + * @ip:			Image processing subdev info

Holds-> holds, Image->image, for consistency with the rest.

> +void rzg2l_cru_stop_image_processing(struct rzg2l_cru_dev *cru)
> +{
> +	u32 amnfifopntr, amnfifopntr_w, amnfifopntr_r_y;
> +	unsigned int retries =3D 0;
> +	unsigned long flags;
> +	u32 icnms;
> +
> +	spin_lock_irqsave(&cru->qlock, flags);
> +
> +	/* Disable and clear the interrupt */
> +	rzg2l_cru_write(cru, CRUnIE, 0);
> +	rzg2l_cru_write(cru, CRUnINTS, 0x001F0F0F);
=2E..
> +	/* Wait until the FIFO becomes empty */
> +	for (retries =3D 5; retries > 0; retries--) {
> +		amnfifopntr =3D rzg2l_cru_read(cru, AMnFIFOPNTR);
> +
> +		amnfifopntr_w =3D amnfifopntr & AMnFIFOPNTR_FIFOWPNTR;
> +		amnfifopntr_r_y =3D
> +			(amnfifopntr & AMnFIFOPNTR_FIFORPNTR_Y) >> 16;
> +		if (amnfifopntr_w =3D=3D amnfifopntr_r_y)
> +			break;
> +
> +		usleep_range(10, 20);

We are running with interrupts disabled here, we should use udelay(),
not sleep.

> +	}
> +
> +	/* Notify that FIFO is not empty here */
> +	if (!retries)
> +		dev_err(cru->dev, "Failed to empty FIFO\n");
> +
> +	/* Stop AXI bus */
> +	rzg2l_cru_write(cru, AMnAXISTP, AMnAXISTP_AXI_STOP);
> +
> +	/* Wait until the AXI bus stop */
> +	for (retries =3D 5; retries > 0; retries--) {
> +		if (rzg2l_cru_read(cru, AMnAXISTPACK) &
> +			AMnAXISTPACK_AXI_STOP_ACK)
> +			break;
> +
> +		usleep_range(10, 20);

Same here.

> +static int rzg2l_cru_open(struct file *file)
> +{
> +	struct rzg2l_cru_dev *cru =3D video_drvdata(file);
> +	int ret;
> +
> +	ret =3D mutex_lock_interruptible(&cru->lock);
> +	if (ret)
> +		return ret;
> +
> +	file->private_data =3D cru;
> +	ret =3D v4l2_fh_open(file);
> +	if (ret)
> +		goto err_unlock;
> +
> +	mutex_unlock(&cru->lock);
> +
> +	return 0;
> +
> +err_unlock:
> +	mutex_unlock(&cru->lock);
> +
> +	return ret;
> +}

This can be simplified. You already have "ret =3D 0" in the normal path,
so this can be deleted:

> +	if (ret)
> +		goto err_unlock;
> +
> +	mutex_unlock(&cru->lock);
> +
> +	return 0;

Best regards,
									Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FMj14vdOq2MD0w2M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZyoCVwAKCRAw5/Bqldv6
8vEJAKCrnq0rfW0ZCQ5b72MpwjlQvb+oNwCfb243lwy+UR33z7Ur3YFptex2jOg=
=EdOF
-----END PGP SIGNATURE-----

--FMj14vdOq2MD0w2M--

