Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C11EB8FAF
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 12:20:52 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.6939.1694002847896075561
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 05:20:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 98E651C000E; Wed,  6 Sep 2023 14:20:45 +0200 (CEST)
Date: Wed, 6 Sep 2023 14:20:45 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 15/20] drm: renesas: Add RZ/G2L DU Support
Message-ID: <ZPhunaDDoniJB6Fe@duo.ucw.cz>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
 <20230905160737.167877-16-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wHOeFYQjh3hwIIe/"
Content-Disposition: inline
In-Reply-To: <20230905160737.167877-16-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 12:20:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12989


--wHOeFYQjh3hwIIe/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The LCD controller is composed of Frame Compression Processor (FCPVD),
> Video Signal Processor (VSPD), and Display Unit (DU).
>=20
> It has DPI/DSI interfaces and supports a maximum resolution of 1080p
> along with 2 RPFs to support the blending of two picture layers and
> raster operations (ROPs).
>=20
> The DU module is connected to VSPD. Add RZ/G2L DU support for RZ/G2L
> alike SoCs.

Few remarks are below. I understand that we are not going to apply the
patch today, but...

> +static int rzg2l_du_crtc_get(struct rzg2l_du_crtc *rcrtc)
> +{
> +	int ret;
> +
> +	/*
> +	 * Guard against double-get, as the function is called from both the
> +	 * .atomic_enable() and .atomic_flush() handlers.
> +	 */
> +	if (rcrtc->initialized)
> +		return 0;
=2E.
> +	rzg2l_du_crtc_setup(rcrtc);
> +	rcrtc->initialized =3D true;
> +
> +	return 0;

If this gets called from two places at once, do we need some kind of
locking or atomic operation here?

> +static void rzg2l_du_crtc_crc_init(struct rzg2l_du_crtc *rcrtc)
> +{
> +	const char **sources;
> +	unsigned int count;
> +	int i =3D -1;
> +
> +	/* Reserve 1 for "auto" source. */
> +	count =3D rcrtc->vsp->num_planes + 1;
> +
> +	sources =3D kmalloc_array(count, sizeof(*sources), GFP_KERNEL);
> +	if (!sources)
> +		return;
> +
> +	sources[0] =3D kstrdup("auto", GFP_KERNEL);
> +	if (!sources[0])
> +		goto error;
=2E..
> +error:
> +	while (i >=3D 0) {
> +		kfree(sources[i]);
> +		i--;
> +	}
> +	kfree(sources);
> +}

As we can't propagate the error, should we at least WARN() here?

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

WARN()?

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

WARN()?

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wHOeFYQjh3hwIIe/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZPhunQAKCRAw5/Bqldv6
8kV8AJ9bhC5rJpTmBgz8HjFVpVMA1heibACgqHtWs97yzOCLw7KL9JtaUEXLjxI=
=UYI/
-----END PGP SIGNATURE-----

--wHOeFYQjh3hwIIe/--

