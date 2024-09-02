Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103CDCD13CF
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 10:02:08 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.35197.1725271322317027137
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Sep 2024 03:02:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3CA891C009A; Mon,  2 Sep 2024 12:01:59 +0200 (CEST)
Date: Mon, 2 Sep 2024 12:01:58 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 12/30] media: platform: Add Renesas RZ/G2L CRU
 driver
Message-ID: <ZtWNFuw70nkB37EK@duo.ucw.cz>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
 <20240805164342.211857-13-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iUw9TAPyQ5Girp4m"
Content-Disposition: inline
In-Reply-To: <20240805164342.211857-13-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Sep 2024 10:02:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16840


--iUw9TAPyQ5Girp4m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Mon 2024-08-05 17:43:05, Biju Das wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit 07fc05bd0a797dcc34620869933993e1cbf56b98 upstream.
>=20
> Add v4l driver for Renesas RZ/G2L Camera data Receiving Unit.
>=20
> Based on a patch in the BSP by Hien Huynh
> <hien.huynh.px@renesas.com>

> index 000000000000..9533e4069ecd
> --- /dev/null
> +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> @@ -0,0 +1,1057 @@
=2E..
> +static int rzg2l_cru_start_streaming_vq(struct vb2_queue *vq, unsigned i=
nt count)
> +{
> +	struct rzg2l_cru_dev *cru =3D vb2_get_drv_priv(vq);
> +	int ret;
> +
> +	/* Release reset state */
> +	ret =3D reset_control_deassert(cru->aresetn);
> +	if (ret) {
> +		dev_err(cru->dev, "failed to deassert aresetn\n");
> +		return ret;
> +	}
> +
> +	ret =3D reset_control_deassert(cru->presetn);
> +	if (ret) {
> +		reset_control_assert(cru->aresetn);
> +		dev_err(cru->dev, "failed to deassert presetn\n");
> +		return ret;
> +	}

Should this just goto the end, where you already have the error handling?

> +	ret =3D request_irq(cru->image_conv_irq, rzg2l_cru_irq,
> +			  IRQF_SHARED, KBUILD_MODNAME, cru);
> +	if (ret) {
> +		dev_err(cru->dev, "failed to request irq\n");
> +		goto assert_resets;
> +	}
> +
> +	/* Allocate scratch buffer. */

"buffer." -> "buffer", for consistency with rest (and yes, this is
really a nit).

=2E..
> +out:
> +	if (ret)
> +		dma_free_coherent(cru->dev, cru->format.sizeimage, cru->scratch,
> +				  cru->scratch_phys);
> +free_image_conv_irq:
> +	free_irq(cru->image_conv_irq, cru);
> +
> +assert_resets:
> +	reset_control_assert(cru->presetn);

Add label here and jump to it?

> +	reset_control_assert(cru->aresetn);
> +
> +	return ret;
> +}
> +
> +static void rzg2l_cru_stop_streaming_vq(struct vb2_queue *vq)
> +{
> +	struct rzg2l_cru_dev *cru =3D vb2_get_drv_priv(vq);
> +
> +	rzg2l_cru_stop_streaming(cru);
> +
> +	/* Free scratch buffer */
> +	dma_free_coherent(cru->dev, cru->format.sizeimage,
> +			  cru->scratch, cru->scratch_phys);
> +
> +	free_irq(cru->image_conv_irq, cru);
> +	reset_control_assert(cru->presetn);
> +

Do we need reset_control_assert(cru->aresetn); here?

> +	return_unused_buffers(cru, VB2_BUF_STATE_ERROR);
> +}

> +static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
> +				   struct v4l2_pix_format *pix)
> +{
=2E..
> +	/* Limit to CRU capabilities */
> +	v4l_bound_align_image(&pix->width, 320, RZG2L_CRU_MAX_INPUT_WIDTH, 1,
> +			      &pix->height, 240, RZG2L_CRU_MAX_INPUT_HEIGHT, 2, 0);

320 -> RZG2L_CRU_MIN_INPUT_WIDTH ? (240 -> HEIGHT)?

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--iUw9TAPyQ5Girp4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZtWNFgAKCRAw5/Bqldv6
8tHfAKCryfPi08K4g3BJYu0IiR5y68IoDgCfXSv7xVZne8jQRtGgpdQZODh/OUk=
=R6il
-----END PGP SIGNATURE-----

--iUw9TAPyQ5Girp4m--

