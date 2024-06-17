Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5976C27C79
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 11:48:24 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.54260.1718624898088967958
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jun 2024 04:48:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 933D81C009A; Mon, 17 Jun 2024 13:48:15 +0200 (CEST)
Date: Mon, 17 Jun 2024 13:48:15 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 09/14] drm: renesas: Add RZ/G2L DU Support
Message-ID: <ZnAif+K0li5bb5YS@duo.ucw.cz>
References: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
 <20240614101308.40407-10-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4lK2v+WSgco2IPt4"
Content-Disposition: inline
In-Reply-To: <20240614101308.40407-10-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jun 2024 11:48:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16261


--4lK2v+WSgco2IPt4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 768e9e61b3b99191d8fe1aead6e71f551738b5c4 upstream.
>=20
> The LCD controller is composed of Frame Compression Processor (FCPVD),
> Video Signal Processor (VSPD), and Display Unit (DU).
>=20
> It has DPI/DSI interfaces and supports a maximum resolution of 1080p
> along with 2 RPFs to support the blending of two picture layers and
> raster operations (ROPs).
>=20
> The DU module is connected to VSPD. Add RZ/G2L DU support for RZ/G2L
> alike SoCs.


> +static void rzg2l_du_crtc_reset(struct drm_crtc *crtc)
> +{
> +	struct rzg2l_du_crtc_state *state;
> +
> +	if (crtc->state) {
> +		rzg2l_du_crtc_atomic_destroy_state(crtc, crtc->state);
> +		crtc->state =3D NULL;
> +	}
> +
> +	state =3D kzalloc(sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return;
> +
> +	__drm_atomic_helper_crtc_reset(crtc, &state->state);
> +}

I'd not mind some kind of error print / error handling here. They
asked for reset, and nothing happened due to out-of-memory.

> +static void rzg2l_du_vsp_plane_reset(struct drm_plane *plane)
> +{
> +	struct rzg2l_du_vsp_plane_state *state;
> +
> +	if (plane->state) {
> +		rzg2l_du_vsp_plane_atomic_destroy_state(plane, plane->state);
> +		plane->state =3D NULL;
> +	}
> +
> +	state =3D kzalloc(sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return;
> +
> +	__drm_atomic_helper_plane_reset(plane, &state->state);
> +}

Same here.

But these are really details and should not block merge.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4lK2v+WSgco2IPt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZnAifwAKCRAw5/Bqldv6
8rl1AJ49clRHm4Tj3n3toCm+9Mm7cdfkhQCgrjYmJHjqVfDu5ABACabZ5VAOKhU=
=aN8g
-----END PGP SIGNATURE-----

--4lK2v+WSgco2IPt4--

