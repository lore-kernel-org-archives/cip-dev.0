Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBB2C433EF
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 09:48:25 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.17389.1640166503906647816
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 01:48:24 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 915141C0B7C; Wed, 22 Dec 2021 10:48:21 +0100 (CET)
Date: Wed, 22 Dec 2021 10:48:20 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 04/22] pinctrl: renesas: Add RZ/G2L pin and
 gpio controller driver
Message-ID: <20211222094820.GC15186@amd>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211220133139.21624-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <20211220133139.21624-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 09:48:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7226


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add support for pin and gpio controller driver for RZ/G2L SoC.
>=20
> Based on a patch in the BSP by Hien Huynh <hien.huynh.px@renesas.com>.

> +static int rzg2l_map_add_config(struct pinctrl_map *map,
> +				const char *group_or_pin,
> +				enum pinctrl_map_type type,
> +				unsigned long *configs,
> +				unsigned int num_configs)
> +{
> +	unsigned long *cfgs;
> +
> +	cfgs =3D kmemdup(configs, num_configs * sizeof(*cfgs),
> +		       GFP_KERNEL);

Should we check for overflows here, too?

Best regards,
    							Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHC9GQACgkQMOfwapXb+vJ1LQCeMxnfN9c+rcKek0/qh/kNjmF1
+bEAmQHbmDh42SfZw69seMLIwBUKx9n8
=x4U0
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--

