Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEEECFC279
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 13:28:26 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11425.1763731696238427952
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Nov 2025 05:28:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=DvUWn5pC;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE72810078562;
	Fri, 21 Nov 2025 14:28:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763731694; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ORhFqu9ekMc7DymuY7+CF9NhhnscbWeU3vGubhx6SjM=;
	b=DvUWn5pCaJP8VHqXPbUfCex/cHzmZcxMwhtrfYAyHnWN75xUWEyzRhWZR02HjdCCOzfW5k
	crUmh8g5h4J1v4hmuMl9l4vxzukvOnY/S72sOsN8ttp5QsUe9/X6yN23zIMfm1EX3f6l1d
	CGMSsqs3+lcywcYThUeHD4tiOuSv7HJTO7lma4IpWCEzgvWAO4Sh5oVouEyl2gW4CiYN0H
	/s4/XvCAbbCzJPMq2sRsxLPQOH84niTPBwGC+BfYTk4xHYAO7G3bruXpfJ9aH3SrTjq1gA
	DO4a9Ckl32gRRBIWnwO9nAaCz4+2cu/6NrBzM1CPU7WD8QT6eEz6swqORp4iKg==
Date: Fri, 21 Nov 2025 14:28:07 +0100
From: Pavel Machek <pavel@denx.de>
To: ovidiu.panait.rb@renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 3/9] reset: Add USB2PHY port reset
 driver for Renesas RZ/V2H(P)
Message-ID: <aSBo5wqdWoMh4Ub1@duo.ucw.cz>
References: <20251120165726.18296-1-ovidiu.panait.rb@renesas.com>
 <20251120165726.18296-4-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5POO99FY+ewFfaBB"
Content-Disposition: inline
In-Reply-To: <20251120165726.18296-4-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 13:28:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20681


--5POO99FY+ewFfaBB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit e3911d7f865bbc704205f45333e491e4034942c7 upstream.
>=20
> Implement a USB2PHY port reset driver for the Renesas RZ/V2H(P) SoC.
> Enable control of USB2.0 PHY reset and power-down operations, including
> assert and deassert functionalities for the PHY.
>=20
> Leverage device tree (OF) data to support future SoCs with similar USB2PHY
> hardware but varying register configurations. Define initialization values
> and control register settings to ensure flexibility for upcoming
> platforms.

> +static int rzv2h_usb2phy_reset_probe(struct platform_device *pdev)
> +{
> +	const struct rzv2h_usb2phy_reset_of_data *data;
> +	struct rzv2h_usb2phy_reset_priv *priv;
> +	struct device *dev =3D &pdev->dev;
> +	int error;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	data =3D of_device_get_match_data(dev);
> +	priv->data =3D data;
> +	priv->dev =3D dev;
> +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);

Should this be dev_err_probe, so that user gets error message?

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5POO99FY+ewFfaBB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSBo5wAKCRAw5/Bqldv6
8qoEAJ42PE4nwLMByoviG6GnMLK5dId2gwCgw+1lQasEl/XNXYrvf1P3gGPn54k=
=ta9b
-----END PGP SIGNATURE-----

--5POO99FY+ewFfaBB--

