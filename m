Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33C0C36014
	for <webhook@archiver.kernel.org>; Tue,  1 Apr 2025 10:45:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.15849.1743504328223549426
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Apr 2025 03:45:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=UhzGZISj;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57D03101FF34A;
	Tue,  1 Apr 2025 12:45:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743504326;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=bwjanJ1511QUHn5FDvgF1ZRR3CLKutiF75ytaGlbYQM=;
	b=UhzGZISj/1w0FBogMc47bNh+181gATCSZyN4FKNV8OAjUoND6AUfPpPIFV+nPz7XjVlF6j
	r8J/5R0ckRDEwn3bWDj5vVDJFbNN5kYvhlKunykJYBl6ZRG9kJ6ZNXxYm4IxXDA7D9YrkV
	kal3LapFX1cPMz5ANGcG/B2j0fgnOgfW7qIgvo2zsUZ2/5TGCrx0Bi+QaqcWEungS0AlZG
	Sf1LKJO212LeC0Ad9UlIaNSZf6kqr611qhkeCoI4dLYH3AztD9J4RKzZQ8wMXqab1iuDMU
	/pk7Waw5zXwPmRmu+1gDyiJ5AbSNYv5xS3c/JxuyKs7uTZAdpAWko/dLgyu36Q==
Date: Tue, 1 Apr 2025 12:45:20 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 24/43] pinctrl: renesas: rzg2l:
 Clarify OEN read/write support
Message-ID: <Z+vDwLbzv2nE1d5R@duo.ucw.cz>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
 <20250331104514.79090-25-tommaso.merciai.xr@bp.renesas.com>
 <18322B8E923A9106.2063@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W+9TzaBY/JEI0lgt"
Content-Disposition: inline
In-Reply-To: <18322B8E923A9106.2063@lists.cip-project.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Apr 2025 10:45:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18453


--W+9TzaBY/JEI0lgt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: Paul Barker <paul.barker.ct@bp.renesas.com>
> >=20
> > commit 07dd08c39eb4b645a0e2f2440a54326b49944705 upstream.
> >=20
> > We currently support OEN read/write for the RZ/G3S SoC but not the
> > RZ/G2L SoC family (consisting of RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/V2L &
> > RZ/Five). The appropriate functions are renamed to clarify this and to
> > match the callback names.
> >=20
> > We should also only set the oen_read and oen_write function pointers for
> > the devices which support these operations. This requires us to check
> > that these function pointers are valid before calling them.
>=20
> Usual way to do this would be to introduce dummy functions just
> returning errors, and avoiding the check.
>=20
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -1359,6 +1361,8 @@ static int rzg2l_pinctrl_pinconf_set(struct pinct=
rl_dev *pctldev,
> > =20
> >  		case PIN_CONFIG_OUTPUT_ENABLE:
> >  			arg =3D pinconf_to_config_argument(_configs[i]);
> > +			if (!pctrl->data->oen_write)
> > +				return -EOPNOTSUPP;
>=20
> #define EOPNOTSUPP	122	/* Operation not supported on transport endpoint */
>=20
> Which is not exactly what is happening here. If userland can see this,
> -EINVAL may be better.

You are using both -EOPNOTSUPP and -ENOTSUPP in same function. At that
point, it is a clear no-no :-).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--W+9TzaBY/JEI0lgt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+vDwAAKCRAw5/Bqldv6
8gKMAKCsA6m0pSWyD/cdxY8rJMuFnjLHVACfSUHa7YTF3J5DE4ZbR2ru7Uys/w0=
=8ZY9
-----END PGP SIGNATURE-----

--W+9TzaBY/JEI0lgt--

