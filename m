Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E687C433F5
	for <webhook@archiver.kernel.org>; Thu, 30 Dec 2021 20:07:28 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.2745.1640894845649945621
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Dec 2021 12:07:27 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id ADEA41C0B77; Thu, 30 Dec 2021 21:07:19 +0100 (CET)
Date: Thu, 30 Dec 2021 21:07:19 +0100
From: Pavel Machek <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 03/31] ASoC: sh: Add RZ/G2L SSIF-2 driver
Message-ID: <20211230200719.GA24469@duo.ucw.cz>
References: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211229101530.22783-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211230111500.GD9799@amd>
 <OSZPR01MB7019B90F14E42871D896F12BAA459@OSZPR01MB7019.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: 
 <OSZPR01MB7019B90F14E42871D896F12BAA459@OSZPR01MB7019.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Dec 2021 20:07:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7319


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +static int rz_ssi_pio_send(struct rz_ssi_priv *ssi, struct
> > > +rz_ssi_stream *strm) {
> > > +	struct snd_pcm_substream *substream =3D strm->substream;
> > > +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> > > +	int sample_space;
> > > +	int samples =3D 0;
> > > +	int frames_left;
> > > +	int i;
> > > +	u32 ssifsr;
> > > +	u16 *buf;
> > > +
> > > +	if (!rz_ssi_stream_is_valid(ssi, strm))
> > > +		return -EINVAL;
> >=20
> > Access without locking before verifying that stream is valid with the l=
ock. This is wrong.
> >=20
> rz_ssi_stream_is_valid() does lock/unlock to check stream validity.

Yes, but "struct snd_pcm_runtime *runtime =3D substream->runtime" above
already accessed that data without locking.

> > > +static int rz_ssi_probe(struct platform_device *pdev) {
> > ...
> > > +	/* Error Interrupt */
> > > +	ssi->irq_int =3D platform_get_irq_byname(pdev, "int_req");
> > > +	if (ssi->irq_int < 0)
> > > +		return dev_err_probe(&pdev->dev, -ENODEV,
> > > +				     "Unable to get SSI int_req IRQ\n");
> > > +
> > > +	ret =3D devm_request_irq(&pdev->dev, ssi->irq_int, &rz_ssi_interrup=
t,
> > > +			       0, dev_name(&pdev->dev), ssi);
> > > +	if (ret < 0)
> > > +		return dev_err_probe(&pdev->dev, ret,
> > > +				     "irq request error (int_req)\n");
> > > +
> > > +	/* Tx and Rx interrupts (pio only) */
> > > +	ssi->irq_tx =3D platform_get_irq_byname(pdev, "dma_tx");
> > > +	if (ssi->irq_tx < 0)
> > > +		return dev_err_probe(&pdev->dev, -ENODEV,
> > > +				     "Unable to get SSI dma_tx IRQ\n");
> > ...
> >=20
> > So you registered interrupt handlers...
> >=20
> > > +
> > > +	ret =3D devm_request_irq(&pdev->dev, ssi->irq_tx, &rz_ssi_interrupt=
, 0,
> > > +			       dev_name(&pdev->dev), ssi);
> > > +	if (ret < 0)
> > > +		return dev_err_probe(&pdev->dev, ret,
> > > +				     "irq request error (dma_tx)\n");
> > > +
> > > +	ssi->irq_rx =3D platform_get_irq_byname(pdev, "dma_rx");
> > > +	if (ssi->irq_rx < 0)
> > > +		return dev_err_probe(&pdev->dev, -ENODEV,
> > > +				     "Unable to get SSI dma_rx IRQ\n");
> > > +
> > > +	ret =3D devm_request_irq(&pdev->dev, ssi->irq_rx, &rz_ssi_interrupt=
, 0,
> > > +			       dev_name(&pdev->dev), ssi);
> > > +	if (ret < 0)
> > > +		return dev_err_probe(&pdev->dev, ret,
> > > +				     "irq request error (dma_rx)\n");
> > > +
> > > +	ssi->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> > > +	if (IS_ERR(ssi->rstc))
> > > +		return PTR_ERR(ssi->rstc);
> > > +
> > > +	reset_control_deassert(ssi->rstc);
> > > +	pm_runtime_enable(&pdev->dev);
> > > +	pm_runtime_resume_and_get(&pdev->dev);
> > > +
> > > +	spin_lock_init(&ssi->lock);
> > > +	dev_set_drvdata(&pdev->dev, ssi);
> >=20
> > But only here you have data structures ready to handle the interrupts. =
You won't see obvious problems
> > w/o shared interrupts, but I believe there are debugging modes that tri=
gger this intentionally.
> >=20
> But the devm_snd_soc_register_component() is after this so it should be O=
K I believe unless there is a spurious interrupt which will trigger the han=
dler.
>

I believe your code will do fine in usual configurations. But
reordering it should be quite easy, and there are kernel options like
"irqpoll", "irqfixup" and CONFIG_DEBUG_SHIRQ.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYc4RdwAKCRAw5/Bqldv6
8jBGAJ9B0TqhM9a80wmczJN24IfnuKQfqgCgqzuqiz6qEjpHNav4qd5L6fVD0pE=
=uPEX
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

