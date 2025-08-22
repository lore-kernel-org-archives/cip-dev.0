Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1B4CA0EFC
	for <webhook@archiver.kernel.org>; Fri, 22 Aug 2025 11:32:13 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.7673.1755862332677194791
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Aug 2025 04:32:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=PXrx6sn8;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D45FE101F54F4;
	Fri, 22 Aug 2025 13:32:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1755862330; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=nDuSpZ0BioNb0vj3xgn27CZCSpPydlcv9/OTs7wgcLY=;
	b=PXrx6sn8krT1SeX6kEf+DRsmGcfs6DuQ7G0L3J7TlPt1uVC1uyhXFXLktweg9j/V+YaZY4
	fJKHHaOOElbUIU9eAcIXzpVDkkehk9ExWSMJa2VrbbT1W8a+RPrgRWIb1oKRBzU6AVBP/9
	xuNCjjQadCB7TGWPwTXBOxKjtY7WuJqCxuKuHa1t0OQpi7s3+VMxrtD8//7EIrcGD3+kMR
	Zoo7wUoHsh095A5u+udN+/Nm9Yrd1OpjXPTaH94FXc2A54+JaXG4Rza/fU4BOZZa5QGT+M
	8Re4OsyDJoXzcfOQnGKUpPm0WT8FyDYYuaW1sOs2gw6t3iD8saIja7aZBHPN7Q==
Date: Fri, 22 Aug 2025 13:32:06 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>, tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 40/55] media: rzg2l-cru: Add IRQ handler to OF
 data
Message-ID: <aKhVNiOn0BPPopjH@duo.ucw.cz>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
 <20250820160413.801341-41-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="leoP8AkU4gjL27ym"
Content-Disposition: inline
In-Reply-To: <20250820160413.801341-41-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Aug 2025 11:32:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19945


--leoP8AkU4gjL27ym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit 2d9e3eb740b7d256d0ee53a6a242f0ffc60b0c9b upstream.
>=20
> Add `irq_handler` to the `rzg2l_cru_info` structure and pass it as part of
> the OF data. This prepares for supporting RZ/G3E and RZ/V2H(P) SoCs, which
> require a different IRQ handler. Update the IRQ request code to use the
> handler from the OF data.
>=20
> Add `enable_interrupts` and `disable_interrupts` function pointers to the
> `rzg2l_cru_info` structure and pass them as part of the OF data. This
> prepares for supporting RZ/G3E and RZ/V2H(P) SoCs, which require different
> interrupt configurations.

Refactoring is okay, but this also changes constants. Please change it
is okay.

Best regards,
								Pavel

> +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> @@ -300,8 +300,7 @@ void rzg2l_cru_stop_image_processing(struct rzg2l_cru=
_dev *cru)
>  	spin_lock_irqsave(&cru->qlock, flags);
> =20
>  	/* Disable and clear the interrupt */
> -	rzg2l_cru_write(cru, CRUnIE, 0);
> -	rzg2l_cru_write(cru, CRUnINTS, 0x001F0F0F);
> +	cru->info->disable_interrupts(cru);
> =20
=2E..
> +void rzg2l_cru_disable_interrupts(struct rzg2l_cru_dev *cru)
> +{
> +	rzg2l_cru_write(cru, CRUnIE, 0);
> +	rzg2l_cru_write(cru, CRUnINTS, 0x001f000f);
> +}
> +
>  int rzg2l_cru_start_image_processing(struct rzg2l_cru_dev *cru)

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--leoP8AkU4gjL27ym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKhVNgAKCRAw5/Bqldv6
8mWnAKC8TswHISOBuX/SQmeC12aU4Q36MQCaA1kXz9PhUkKIPQmJFWpq7rUQNXc=
=jPNy
-----END PGP SIGNATURE-----

--leoP8AkU4gjL27ym--

