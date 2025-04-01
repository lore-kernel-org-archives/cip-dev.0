Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954AEC36014
	for <webhook@archiver.kernel.org>; Tue,  1 Apr 2025 10:38:21 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.15749.1743503896677978666
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Apr 2025 03:38:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=gHsgsyGe;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CBDF310167199;
	Tue,  1 Apr 2025 12:38:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743503894; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=6Yo3QZYizOgexB1gXBH7K5HoSbmXEN+DysBQppil8qs=;
	b=gHsgsyGem1KtknUZC+mdSX/PzGqh5BPag3+JxzfsdVKiwa3RfYSbkYMk6fSTUBrI8G2mYc
	etmvpAplWuqX2OHLcWBTcW4zMMD9Jfx2QeGO7vlqwO7BjE7KzhiulAWxql9iSy3T7P5wQM
	1M+w+l6h8wWp6XWY8B++fok697jBMJyjZHqeNmItgIa8l1GON3/YxsWPFwTg20TCOfRL3W
	dbL86mYufmpck9CgPS0d0y6RpKcideyxEG2F5mzOIKKo133sfErHbV3f4K8tJtK8swWJli
	sLrM3szWxHF4BOKcbP/ZUu9GhCobXZb8usuDcMZQeWyIzGbWr+0+KaBxU5rjSw==
Date: Tue, 1 Apr 2025 12:38:09 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 24/43] pinctrl: renesas: rzg2l: Clarify OEN
 read/write support
Message-ID: <Z+vCEZ27cQqXdNvQ@duo.ucw.cz>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
 <20250331104514.79090-25-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E+s6OK6EkeMuzlKk"
Content-Disposition: inline
In-Reply-To: <20250331104514.79090-25-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Apr 2025 10:38:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18450


--E+s6OK6EkeMuzlKk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Paul Barker <paul.barker.ct@bp.renesas.com>
>=20
> commit 07dd08c39eb4b645a0e2f2440a54326b49944705 upstream.
>=20
> We currently support OEN read/write for the RZ/G3S SoC but not the
> RZ/G2L SoC family (consisting of RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/V2L &
> RZ/Five). The appropriate functions are renamed to clarify this and to
> match the callback names.
>=20
> We should also only set the oen_read and oen_write function pointers for
> the devices which support these operations. This requires us to check
> that these function pointers are valid before calling them.

Usual way to do this would be to introduce dummy functions just
returning errors, and avoiding the check.

> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -1359,6 +1361,8 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl=
_dev *pctldev,
> =20
>  		case PIN_CONFIG_OUTPUT_ENABLE:
>  			arg =3D pinconf_to_config_argument(_configs[i]);
> +			if (!pctrl->data->oen_write)
> +				return -EOPNOTSUPP;

#define EOPNOTSUPP	122	/* Operation not supported on transport endpoint */

Which is not exactly what is happening here. If userland can see this,
-EINVAL may be better.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--E+s6OK6EkeMuzlKk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+vCEQAKCRAw5/Bqldv6
8gCNAKC/z8L3nYq743COOq72ev5odhwUxwCdG5d7WRNxywzIPdDqEFNGHyWqcZc=
=rxCB
-----END PGP SIGNATURE-----

--E+s6OK6EkeMuzlKk--

