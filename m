Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FBFC2A09B
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 11:34:00 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.62119.1767612830534419864
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jan 2026 03:33:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=CFdt+kxR;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E803810014B;
	Mon,  5 Jan 2026 12:33:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767612828;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fNRcVdjGhRjzj13woAKHzYFnx6sWB+YPtFSMhdv9phk=;
	b=CFdt+kxRm4Y/5oPkHP0k6wjzGTMLM7wzn1eRbB2p14AGYA36euGNvar+wiiIK6F7On9KdJ
	CO0NMsw0AXlaZxIYkDTEV3lbBxa6pQlTaoEmtr0lsSg/RHpp9y+Hcsr4W8APTY/CiPnqkh
	TRUJUwNTOUV1Ol9+sMT3tlH8RE8uq2RirFtg4Dw1UIsLxvxYQtei2sXx1YJg/lI2sOzyMY
	pXw+WMGaw8JUuGpz4VKCYsIwEN3hifHaRYT40KTImVZjI8wv2HJiEVOa4fu8EXD1qwbGAv
	3zJD+melUe9qsMphp37W2EwER2A5mtKcY2mXwc06TLTpIwrGpDFMxfjgYxuM4g==
Date: Mon, 5 Jan 2026 12:33:43 +0100
From: Pavel Machek <pavel@nabladev.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 05/17] watchdog: rzv2h: Add support
 for RZ/T2H
Message-ID: <aVuhl9TJVs6rlwNT@duo.ucw.cz>
References: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251231170026.17006-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dWypypS2mPl7nx8B"
Content-Disposition: inline
In-Reply-To: <20251231170026.17006-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jan 2026 11:34:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21308


--dWypypS2mPl7nx8B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Minor nit below:

> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c
> +static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
> +				 struct rzv2h_wdt_priv *priv)
> +{
> +	int ret;
> +
> +	priv->wdtdcr =3D devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(priv->wdtdcr))
> +		return PTR_ERR(priv->wdtdcr);
> +
> +	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	rzt2h_wdt_wdtdcr_count_stop(priv);
> +
> +	ret =3D pm_runtime_put(&pdev->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}

I believe this can be simply "return pm_runtime_put()".

Best regards,
							Pavel
--=20
In cooperation with Nabla.

--dWypypS2mPl7nx8B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVuhlwAKCRAw5/Bqldv6
8vEoAJ9nInpZcg9PFxIQjtI5zDtGXRBYwgCfVG68AJnJ/QTIKbb8QDmI2Jm2wSg=
=MxhD
-----END PGP SIGNATURE-----

--dWypypS2mPl7nx8B--

