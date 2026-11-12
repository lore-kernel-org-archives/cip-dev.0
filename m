Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4820.1794513331061301632
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 11:55:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=cr90giqo;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A5D710CE5A;
	Thu, 12 Nov 2026 20:55:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794513324;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mx4of0oyW/SVr5o+hYoOlqZOE/L7J35xBhci3TyIKIc=;
	b=cr90giqodtbSmF7dsopq9OPEw6zzOXXL6lgf9NLJCRDAMqiaIOm00Zn5QFjLV11Z5/2kww
	kLLxZr6AVg8DFFLDVCtmYm9k6ZfbRd1e+iatjUGxz/iG5sx4rnV1lkcV61i5g434UQPYnv
	yA9yXSWcgOxjgwP2/2AG2jF6IQQS4KhAROq/0VPfFaOZeALzAZ2NNdheF2zEBNgzsm8hcB
	wguVTAtqRv+tXRgk5YpqWrhqvv/CSXmOMH9cW8kDv63jPq8eGpCco0WNJNXIpuLDchvt/n
	XhSa3KtayiRVYusj7uUf7L9zMvjG2quE25HRta/+waXuRphxXlc1CIXoSWbOiw==
Date: Thu, 12 Nov 2026 20:55:22 +0100
From: Pavel Machek <pavel@nabladev.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 09/24] drm: renesas: rz-du: Add
 support for RZ/T2H SoC
Message-ID: <avYZqkO1GWX-t2oZ@duo.ucw.cz>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261109121451.6042-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uILO8I20X1H6OYuI"
Content-Disposition: inline
In-Reply-To: <20261109121451.6042-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 19:55:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24791


--uILO8I20X1H6OYuI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 4f2e625f3d5d27242f0f18ba106b9442d29a51ad upstream.
>=20
> The RZ/T2H (R9A09G077) SoC includes a DU with a DPI interface,
> supporting resolutions up to WXGA with two RPFs for layer blending.
> Unlike earlier RZ/G2L SoCs, RZ/T2H requires explicit assertion of a
> DPI output-enable signal (DU_MCR0_DPI_EN) during CRTC startup.

> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> @@ -217,8 +218,12 @@ static void rzg2l_du_crtc_put(struct rzg2l_du_crtc *=
rcrtc)
>  static void rzg2l_du_start_stop(struct rzg2l_du_crtc *rcrtc, bool start)
>  {
>  	struct rzg2l_du_device *rcdu =3D rcrtc->dev;
> +	u32 val =3D DU_MCR0_DI_EN;
> =20
> -	writel(start ? DU_MCR0_DI_EN : 0, rcdu->mmio + DU_MCR0);
> +	if (start && rzg2l_du_has(rcdu, RZG2L_DU_FEATURE_DPIO_OE))
> +		val |=3D DU_MCR0_DPI_EN;
> +
> +	writel(start ? val : 0, rcdu->mmio + DU_MCR0);
>  }
>

This is quite strange code. We prepare "val", then discards it in case
of "start =3D=3D false". I'd suggest dropping "start &&" from the if
condition, or perhaps more refactoring.

Best regards,
								Pavel

--uILO8I20X1H6OYuI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavYZqgAKCRAw5/Bqldv6
8jYQAJ9gd7v4Msubrkj0eoZXQ3/AuIwlKgCfcpDKqesNWwjBtExxlypwS4spSQI=
=Lilx
-----END PGP SIGNATURE-----

--uILO8I20X1H6OYuI--
