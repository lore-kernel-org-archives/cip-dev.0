Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CCBCA0EED
	for <webhook@archiver.kernel.org>; Fri, 22 Aug 2025 11:33:53 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.7692.1755862425719174805
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Aug 2025 04:33:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=ATUymbh0;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 308E71038C11E;
	Fri, 22 Aug 2025 13:33:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1755862423; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yKVwnkx8uVrz8ARNr3z6zFutB1k5/yQqf42qa8vT/Rs=;
	b=ATUymbh09FhuIWbj0wKPUv0PYP5fmxgP+bjC5CYf719skO9ix/3ht38+LUSUkAv5pHqN1A
	66DjmcEAzk6KP75BXzBWJ5O6apzHslkL53N+PNzZtnMAp/1jTmStS2eaNQh98dKiHWyPJW
	c/EKcG3wfqPE7jB8Dqie8cdJDkKU0n3D6IW6gP2g2Hvun2olX98i/d9IVfMEAeUM26RnCF
	32P/7/+oTK1uwUd6FuDoK1VsGWOIlPAAEvwDpO5HCmXaamUhiCYrHLuO4knk4O1QYUgOwZ
	BW87cu2ABerasbLKd0fN3tCaMzXURttgNlF5JpH+32lYNHFUwj2/QmUL799MuA==
Date: Fri, 22 Aug 2025 13:33:39 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>, tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 41/55] media: rzg2l-cru: Add function pointer
 to check if FIFO is empty
Message-ID: <aKhVkzicPtd8Al2K@duo.ucw.cz>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
 <20250820160413.801341-42-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LdHRMbpi5D6XBEJA"
Content-Disposition: inline
In-Reply-To: <20250820160413.801341-42-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Aug 2025 11:33:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19946


--LdHRMbpi5D6XBEJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit 446c645f7fe480a4420072728faa1f261530b984 upstream.
>=20
> Add a `fifo_empty` function pointer to the `rzg2l_cru_info` structure and
> pass it as part of the OF data. On RZ/G3E and RZ/V2H(P) SoCs, checking if
> the FIFO is empty requires a different register configuration.
>=20
> Implement `rzg2l_fifo_empty()` and update the code to use it from the
> function pointer.

> +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> @@ -290,9 +290,23 @@ static int rzg2l_cru_initialize_image_conv(struct rz=
g2l_cru_dev *cru,
>  	return 0;
>  }
> =20
> -void rzg2l_cru_stop_image_processing(struct rzg2l_cru_dev *cru)
> +bool rzg2l_fifo_empty(struct rzg2l_cru_dev *cru)
>  {
>  	u32 amnfifopntr, amnfifopntr_w, amnfifopntr_r_y;
> +
> +	amnfifopntr =3D rzg2l_cru_read(cru, AMnFIFOPNTR);
> +
> +	amnfifopntr_w =3D amnfifopntr & AMnFIFOPNTR_FIFOWPNTR;
> +	amnfifopntr_r_y =3D
> +		(amnfifopntr & AMnFIFOPNTR_FIFORPNTR_Y) >> 16;
> +	if (amnfifopntr_w =3D=3D amnfifopntr_r_y)
> +		return true;
> +
> +	return amnfifopntr_w =3D=3D amnfifopntr_r_y;
> +}

This adds strange code duplication (amnfifopntr_w =3D=3D amnfifopntr_r_y
twice), but that's fixed 43/, so I guess that's ok.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LdHRMbpi5D6XBEJA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKhVkwAKCRAw5/Bqldv6
8hxNAKClxMKRPMbl4DZunVhMOZ3ziuztHwCgjnkElXre+9Ux7CUullF26aus/Dc=
=8fIZ
-----END PGP SIGNATURE-----

--LdHRMbpi5D6XBEJA--

