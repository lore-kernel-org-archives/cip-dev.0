Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4FEED7B95
	for <webhook@archiver.kernel.org>; Tue, 14 Apr 2026 09:31:08 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14801.1776159063565916153
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Apr 2026 02:31:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=S0cr3Xg2;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D91410CE86;
	Tue, 14 Apr 2026 11:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776159061;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ti8uYy/4bkBYbEj+0KOaNVyqopyedUBs51lT+DMGZ9E=;
	b=S0cr3Xg2HZL20vQvG+pNpOfGI1KkQhS060FXb9wXwpn50PUpgJaAfJu8RJIn3tXbW72+HR
	ppuiUsmrS3Z5WPXxFJE3wlUnv8Sr44fo26kCvxHPPVpZJm2khpqE2UKETkQoJmamwjq8Mq
	BxtwrCMzsJH0QW5LAyfuVQwRRGkAQn8mPX8hUFgYUIuH0KWvOUp5RqQ1xbevzYeK0jh+ZJ
	Euk1ZUt8MK2qfCmnI/Pay1ngbffhq7qfDphMdFE5IgCFwLe6PfS2q0Cfop213g7M60tkXf
	R9qCi94nE1/QpaGKinsHnqQ3NMyjvNJRGxUCvmRXAYn7DygQLyDiuQa+gFU7+A==
Date: Tue, 14 Apr 2026 11:30:56 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Chris Brandt <chris.brandt@renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: Re: [PATCH 6.1.y-cip 2/7] drm: renesas: rz-du: Implement MIPI DSI
 host transfers
Message-ID: <ad4JUH9p71MPyIlK@duo.ucw.cz>
References: <20260413171831.3091144-1-chris.brandt@renesas.com>
 <20260413171831.3091144-2-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5ydhdNtROy1ZfDvU"
Content-Disposition: inline
In-Reply-To: <20260413171831.3091144-2-chris.brandt@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Apr 2026 09:31:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22699


--5ydhdNtROy1ZfDvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 6f392f37165008cfb3f89d723aa019e372ee79b9 upstream.
>=20
> Add support for sending MIPI DSI command packets from the host to a
> peripheral. This is required for panels that need configuration before
> they accept video data.

> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +static ssize_t rzg2l_mipi_dsi_read_response(struct rzg2l_mipi_dsi *dsi,
> +					    const struct mipi_dsi_msg *msg)
> +{
> +	u8 *msg_rx =3D msg->rx_buf;
> +	u8 datatype;
> +	u32 result;
> +	u16 size;
> +
> +	result =3D rzg2l_mipi_dsi_link_read(dsi, RXRSS0R);
> +	if (result & RXRSS0R_RXPKTDFAIL) {
> +		dev_err(dsi->dev, "packet rx data did not save correctly\n");
> +		return -EPROTO;
> +	}
> +
> +	if (result & RXRSS0R_RXFAIL) {
> +		dev_err(dsi->dev, "packet rx failure\n");
> +		return -EPROTO;
> +	}
> +
> +	if (!(result & RXRSS0R_RXSUC))
> +		return -EPROTO;

This probably should do dev_err or dev_dbg before returning.

> @@ -1274,6 +1453,11 @@ static int rzg2l_mipi_dsi_probe(struct platform_de=
vice *pdev)
>  	if (ret < 0)
>  		goto err_pm_disable;
>=20
> +	dsi->dcs_buf_virt =3D dma_alloc_coherent(dsi->host.dev, RZG2L_DCS_BUF_S=
IZE,
> +					       &dsi->dcs_buf_phys, GFP_KERNEL);
> +	if (!dsi->dcs_buf_virt)
> +		return -ENOMEM;
> +
>  	return 0;
>

This probably should be { err =3D -ENOMEM; goto err_pm_disable; }

Thanks and best regards,
									Pavel

--5ydhdNtROy1ZfDvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCad4JUAAKCRAw5/Bqldv6
8hEyAJwOEJtKM0IkN40/8/S/5kRp+0xR9wCggva5ZCbmR6FmEvvx0GrEWQYwghY=
=9Ug+
-----END PGP SIGNATURE-----

--5ydhdNtROy1ZfDvU--

