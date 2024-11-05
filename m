Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EABD1268C
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 11:27:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.15505.1730806050869639534
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Nov 2024 03:27:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7EEA11C00B2; Tue,  5 Nov 2024 12:27:28 +0100 (CET)
Date: Tue, 5 Nov 2024 12:27:28 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 5.10.y-cip 10/28] media: platform: Add Renesas RZ/G2L
 MIPI CSI-2 receiver driver
Message-ID: <ZyoBIAONV1wUteVt@duo.ucw.cz>
References: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20241101125746.33222-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8M/cZ3R9F6Q4kLAg"
Content-Disposition: inline
In-Reply-To: <20241101125746.33222-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Nov 2024 11:27:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17172


--8M/cZ3R9F6Q4kLAg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 51e8415e39a962db2a753940fca18e9710c24902 upstream.
>=20
> Add MIPI CSI-2 receiver driver for Renesas RZ/G2L. The MIPI
> CSI-2 is part of the CRU module found on RZ/G2L family.
>=20
> Based on a patch in the BSP by Hien Huynh
> <hien.huynh.px@renesas.com>

> +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c

> +static int rzg2l_csi2_notify_bound(struct v4l2_async_notifier *notifier,
> +				   struct v4l2_subdev *subdev,
> +				   struct v4l2_async_subdev *asd)
> +{
> +	struct rzg2l_csi2 *csi2 =3D notifier_to_csi2(notifier);
> +
> +	csi2->remote_source =3D subdev;
> +
> +	dev_dbg(csi2->dev, "Bound subdev: %s pad\n", subdev->name);
> +
> +	return media_create_pad_link(&subdev->entity, RZG2L_CSI2_SINK,
> +				     &csi2->subdev.entity, 0,
> +				     MEDIA_LNK_FL_ENABLED |
> +				     MEDIA_LNK_FL_IMMUTABLE);
> +}
> +
> +static void rzg2l_csi2_notify_unbind(struct v4l2_async_notifier *notifie=
r,
> +				     struct v4l2_subdev *subdev,
> +				     struct v4l2_async_subdev *asd)
> +{
> +	struct rzg2l_csi2 *csi2 =3D notifier_to_csi2(notifier);
> +
> +	csi2->remote_source =3D NULL;
> +
> +	dev_dbg(csi2->dev, "Unbind subdev %s\n", subdev->name);
> +}

Are the dev_dbgs still needed?

> +static int rzg2l_csi2_parse_dt(struct rzg2l_csi2 *csi2)
> +{
> +	struct v4l2_fwnode_endpoint v4l2_ep =3D {
> +		.bus_type =3D V4L2_MBUS_CSI2_DPHY
> +	};
> +	struct v4l2_async_subdev *asd;
> +	struct fwnode_handle *fwnode;
> +	struct fwnode_handle *ep;
> +	int ret;
> +
> +	ep =3D fwnode_graph_get_endpoint_by_id(dev_fwnode(csi2->dev), 0, 0, 0);
> +	if (!ep) {
> +		dev_err(csi2->dev, "Not connected to subdevice\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D v4l2_fwnode_endpoint_parse(ep, &v4l2_ep);
> +	if (ret) {
> +		dev_err(csi2->dev, "Could not parse v4l2 endpoint\n");
> +		fwnode_handle_put(ep);
> +		return -EINVAL;
> +	}

Would it be better to propagate error (return ret) here?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8M/cZ3R9F6Q4kLAg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZyoBIAAKCRAw5/Bqldv6
8kJaAJUVpj/WHFKZxBu98eE2Kxg1qoM8AJ9Q2Xi8cbRH3HYPnh6/lyQF9RrPzA==
=hOBX
-----END PGP SIGNATURE-----

--8M/cZ3R9F6Q4kLAg--

