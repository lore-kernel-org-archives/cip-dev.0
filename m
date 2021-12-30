Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3319C433EF
	for <webhook@archiver.kernel.org>; Thu, 30 Dec 2021 11:15:09 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.63176.1640862904647169675
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Dec 2021 03:15:05 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 83F441C0B77; Thu, 30 Dec 2021 12:15:01 +0100 (CET)
Date: Thu, 30 Dec 2021 12:15:00 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 03/31] ASoC: sh: Add RZ/G2L SSIF-2 driver
Message-ID: <20211230111500.GD9799@amd>
References: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211229101530.22783-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline
In-Reply-To: <20211229101530.22783-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Dec 2021 11:15:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7314


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> commit 03e786bd43410fa93e5d2459f7a43e90ff0ae801 upstream.
>=20
> Add serial sound interface(SSIF-2) driver support for
> RZ/G2L SoC.
>=20
> Based on the work done by Chris Brandt for RZ/A SSI driver.

I'm not sure what the locking rules are here.

> --- /dev/null
> +++ b/sound/soc/sh/rz-ssi.c
> +static int rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
> +				  struct rz_ssi_stream *strm)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&ssi->lock, flags);
> +	ret =3D !!(strm->substream && strm->substream->runtime);
> +	spin_unlock_irqrestore(&ssi->lock, flags);
> +
> +	return ret;
> +}

Nit: I don't think !!() is useful here, as it is boolean expression
anyway.

But I notice that code is very careful to access strm->substream with
spinlock held.

> +static void rz_ssi_pointer_update(struct rz_ssi_stream *strm, int frames)
> +{
> +	struct snd_pcm_substream *substream =3D strm->substream;
> +	struct snd_pcm_runtime *runtime;
> +	int current_period;
> +
> +	if (!strm->running || !substream || !substream->runtime)
> +		return;

But here we do same checks, and this time without the spinlock?

> +static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream=
 *strm)
> +{
> +	struct snd_pcm_substream *substream =3D strm->substream;
> +	struct snd_pcm_runtime *runtime;
> +	u16 *buf;
> +	int fifo_samples;
> +	int frames_left;
> +	int samples =3D 0;
> +	int i;
> +
> +	if (!rz_ssi_stream_is_valid(ssi, strm))
> +		return -EINVAL;
> +
> +	runtime =3D substream->runtime;

Again, access without locking.=20

> +	/*
> +	 * If we finished this period, but there are more samples in
> +	 * the RX FIFO, call this function again
> +	 */
> +	if (frames_left =3D=3D 0 && fifo_samples >=3D runtime->channels)
> +		rz_ssi_pio_recv(ssi, strm);

Here we call ourselves recurively. Without checking the return
value.. but more importantly recursion is unwelcome in kernel due to
limited stack use.


> +static int rz_ssi_pio_send(struct rz_ssi_priv *ssi, struct rz_ssi_stream=
 *strm)
> +{
> +	struct snd_pcm_substream *substream =3D strm->substream;
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +	int sample_space;
> +	int samples =3D 0;
> +	int frames_left;
> +	int i;
> +	u32 ssifsr;
> +	u16 *buf;
> +
> +	if (!rz_ssi_stream_is_valid(ssi, strm))
> +		return -EINVAL;

Access without locking before verifying that stream is valid with the
lock. This is wrong.=20

> +static irqreturn_t rz_ssi_interrupt(int irq, void *data)
> +{
> +	struct rz_ssi_stream *strm =3D NULL;
> +	struct rz_ssi_priv *ssi =3D data;
> +	u32 ssisr =3D rz_ssi_reg_readl(ssi, SSISR);
> +
> +	if (ssi->playback.substream)
> +		strm =3D &ssi->playback;
> +	else if (ssi->capture.substream)
> +		strm =3D &ssi->capture;
> +	else
> +		return IRQ_HANDLED; /* Left over TX/RX interrupt */

You mark interrupt as handled even when it is not. Probably not a
problem w/o shared interrupts.

> +static int rz_ssi_probe(struct platform_device *pdev)
> +{
=2E..
> +	/* Error Interrupt */
> +	ssi->irq_int =3D platform_get_irq_byname(pdev, "int_req");
> +	if (ssi->irq_int < 0)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "Unable to get SSI int_req IRQ\n");
> +
> +	ret =3D devm_request_irq(&pdev->dev, ssi->irq_int, &rz_ssi_interrupt,
> +			       0, dev_name(&pdev->dev), ssi);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "irq request error (int_req)\n");
> +
> +	/* Tx and Rx interrupts (pio only) */
> +	ssi->irq_tx =3D platform_get_irq_byname(pdev, "dma_tx");
> +	if (ssi->irq_tx < 0)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "Unable to get SSI dma_tx IRQ\n");
=2E..

So you registered interrupt handlers...

> +
> +	ret =3D devm_request_irq(&pdev->dev, ssi->irq_tx, &rz_ssi_interrupt, 0,
> +			       dev_name(&pdev->dev), ssi);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "irq request error (dma_tx)\n");
> +
> +	ssi->irq_rx =3D platform_get_irq_byname(pdev, "dma_rx");
> +	if (ssi->irq_rx < 0)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "Unable to get SSI dma_rx IRQ\n");
> +
> +	ret =3D devm_request_irq(&pdev->dev, ssi->irq_rx, &rz_ssi_interrupt, 0,
> +			       dev_name(&pdev->dev), ssi);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "irq request error (dma_rx)\n");
> +
> +	ssi->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(ssi->rstc))
> +		return PTR_ERR(ssi->rstc);
> +
> +	reset_control_deassert(ssi->rstc);
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_resume_and_get(&pdev->dev);
> +
> +	spin_lock_init(&ssi->lock);
> +	dev_set_drvdata(&pdev->dev, ssi);

But only here you have data structures ready to handle the
interrupts. You won't see obvious problems w/o shared interrupts, but
I believe there are debugging modes that trigger this intentionally.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHNlLQACgkQMOfwapXb+vLcdACfTsinSbw9V3z4F05Q576Mo48t
VR8AoIHxNri13sDQyF5N2Duvb+QsL0zc
=u3Vn
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--

