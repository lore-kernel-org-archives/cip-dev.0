Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749E4C88E4C
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 10:06:57 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35850.1789121204689156857
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 03:06:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=QIfc5EKG;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 61ECC10330B;
	Fri, 11 Sep 2026 12:06:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789121198;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UZbJyzzwvmZwMqM6AfuWqgOHeVlwtBRDNiB4pF9gB3Q=;
	b=QIfc5EKGLBb8jiw5sGi9JoejOvn/W0Kr9bmerZXv9ICatwUz2x1ZRcOSEyn2GmZHkwlmK1
	st7/YZMIapQ+UCCGUet6QudMbEln0cEdXTPuLAmZIF/CWxuwaZ1HCnKYbNlKfR4McpZ1V3
	PjtHqPp/Xf/tewUzhqhMW5YUNe7lXqYhZBedlOJAJ6C68ITIYKQGeif/cJazesdh4pzwNC
	NRYTvJ+e7UjsACf3ckUVamgyIJO21xxia1eVMiMY4j9V8ztY7ltscZI7AKmnWeABDUtFpX
	6VvRerrxd9zW+SyNrPFUWnHEH6/hANtFoJh+k1sFJhGjP/03mvA2pbQR4df1UQ==
Date: Fri, 11 Sep 2026 12:06:34 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 3/8] dmaengine: sh: rz-dmac: fix device leak
 on probe failure
Message-ID: <aqPSqkVhPqfT7pD3@duo.ucw.cz>
References: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260911081132.11879-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GmXfTJKjeI80bYRD"
Content-Disposition: inline
In-Reply-To: <20260911081132.11879-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 10:06:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24127


--GmXfTJKjeI80bYRD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Johan Hovold <johan@kernel.org>
>=20
> commit 9fb490323997dcb6f749cd2660a17a39854600cd upstream.
>=20
> Make sure to drop the reference taken when looking up the ICU device
> during probe also on probe failures (e.g. probe deferral).

Ok, but you need to do the put_device when devm_add_action_or_reset()
fails...?

> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -885,6 +892,10 @@ static int rz_dmac_parse_of_icu(struct device *dev, =
struct rz_dmac *dmac)
>  		return -ENODEV;
>  	}
> =20
> +	ret =3D devm_add_action_or_reset(dev, rz_dmac_put_device, &dmac->icu.pd=
ev->dev);
> +	if (ret)
### <- here?
> +		return ret;
> +
>  	dmac_index =3D args.args[0];

Best regards,
										Pavel

--GmXfTJKjeI80bYRD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaqPSqgAKCRAw5/Bqldv6
8ikrAJ0asTzSmF2UCmgIVtn428QB1cUcmwCfQ/uDvMbC9l/z1Qbipz7ehSbelGY=
=Dztw
-----END PGP SIGNATURE-----

--GmXfTJKjeI80bYRD--

