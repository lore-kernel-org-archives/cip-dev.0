Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA618C624D4
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 16:57:45 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.439.1788368264667254115
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 09:57:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=JpWLnbXd;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 564AF11C6DC;
	Wed, 02 Sep 2026 18:57:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788368258;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=VMKEfmV8qxKpoOZ2fSco1VtK1jaYWz/+cRv3cZgHycE=;
	b=JpWLnbXdAENGPsQrXjfg6z2X4daMw2Q+NTU22YdpaG2/JJJQcj56/nIgL8YqxBM/xGOMwt
	0r0JJVL/aR6ZfvnvCR2LRJJfh0NEBtetBaxy07OXpTku+IXDKhQQqHFsTidlRZrjmKYidR
	OY+lXkm74MZJUGP2zi+bqQdMGOKOJDht9kUjk2XzFfN2JfnwneXKbiVquSVB+1/LFPMbZk
	zgaqTNdOyPwH/jqw9awpP50hl61ThJTEXzhVLCe4XWdEUgXaBpD9UZg1jTIedFwDZ8hj9w
	cS3Fw95hec7nIpzQkqpxyIdKZYDqsgnlBHH7YHXnase4LjR65jFNIsde5zm55A==
Date: Wed, 2 Sep 2026 18:57:30 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 03/11] irqchip/renesas-rzv2h: Use local device
 pointer in ICU probe
Message-ID: <aphVet4W9UIunoEv@duo.ucw.cz>
References: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
 <20260902092353.24648-4-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N1YVNoAuy8Cq1iyb"
Content-Disposition: inline
In-Reply-To: <20260902092353.24648-4-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 16:57:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24079


--N1YVNoAuy8Cq1iyb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit bbe78cb1399b4ba6b6d14943fb9dadefe9c17b5b upstream.
>=20
> Use a local struct device pointer in rzv2h_icu_probe_common() to avoid
> repeated dereferencing of pdev->dev.
>=20
> --- a/drivers/irqchip/irq-renesas-rzv2h.c
> +++ b/drivers/irqchip/irq-renesas-rzv2h.c
> @@ -625,14 +627,14 @@ static int rzv2h_icu_init_common(struct device_node=
 *node, struct device_node *p
> =20
>  	/*
>  	 * coccicheck complains about a missing put_device call before returnin=
g, but it's a false
> -	 * positive. We still need &pdev->dev after successfully returning from=
 this function.
> +	 * positive. We still need dev after successfully returning from this f=
unction.
>  	 */
>  	return 0;

I believe the search and replace went too far here. For reader,
original comment was more useful. But maybe it should say in english
what device we actually need.

Best regards,
							Pavel

--N1YVNoAuy8Cq1iyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaphVegAKCRAw5/Bqldv6
8oCvAJoCZBg3c6XE+2SeXcqE4F9fRFjivgCdE/QJiLQaoK3+SAwIHZglRXZxEK4=
=zgrr
-----END PGP SIGNATURE-----

--N1YVNoAuy8Cq1iyb--

