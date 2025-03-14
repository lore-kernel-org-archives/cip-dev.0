Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B22AC282EC
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 10:06:44 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.10415.1741946802124710785
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Mar 2025 03:06:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=MOVIHwfr;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4A0810382F09;
	Fri, 14 Mar 2025 11:06:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741946799; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ODP/ExbyrhKlFYroRbKcmZe2tEpzEnL9jH+Yz7LOkGw=;
	b=MOVIHwfrY/qr0AkmyVHOdlTpZJGihF6SOsnYXwwFBN8nvdtZ2jzc6mkuJJfuD0k0qUCx/Z
	VSiTRUwjiTyIVGPa9BxLIY3ryzEuJnpXY4y3KNHgeC2meffgoYNaOzluKqO6xs+49PPtqi
	joTxkya0uYM6P21L+PyFj3dMyugy6nqM8xexd9uMoal4XPNQysIpM2bIj4oz14ZKJFRSmk
	9Dm3dJKYmJQBfJDvE+Y/d4MaF+Mt031WtPlU8ncVvhR0muBgNtzNF/Stx4XDi44ppPdKm+
	fZayfCgNPpsVEz4uJW8lDrF8HMemP2TnQ+wrFuxtSzzknCYoGr06z02voI/JUw==
Date: Fri, 14 Mar 2025 11:06:33 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/85] soc: renesas: Add RZ/G3E support
Message-ID: <Z9P/qUzPfn368iGo@duo.ucw.cz>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <Z9K4sW1iyC+0lJCg@duo.ucw.cz>
 <Z9LHJC92Bp3HxjT2@tom-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v1SbQ75auyyWu5ha"
Content-Disposition: inline
In-Reply-To: <Z9LHJC92Bp3HxjT2@tom-desktop>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 10:06:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18206


--v1SbQ75auyyWu5ha
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > What is RZ/G3E? Is it new generation of something? Is it used
> > somewhere?
>=20
> The RZ/G3E device is a general-purpose microprocessor with a quad-core CA=
-55,
> single core CM-33, Ethos-U55 NPU, Mali-G52 3-D Graphics and other periphe=
rals.
>=20
> Here the first introduction to the kernel: [1]

Ok, thanks for pointer, that is useful.

What is relation between RZ/G3E and rzg2l? Because early patches seem
to be for rzg2l support, not RZ/G3E. Splitting those preparations up
would be good.

> > Why is it important? Why is it important for -cip?
> >=20
> > Does this add complete support? Or just enough to boot?
>=20
> At the moment mainline supports only boot. So same backported here.
> Going foward will add complete support.

Ok, 85 patches in the series is really a bit hard to work with. It
seems dts is merged quite early in the series, so that should be good
place to split stuff. Could we get smaller series (perhaps 15
patches?) with only stuff that's already in 6.12?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--v1SbQ75auyyWu5ha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9P/qQAKCRAw5/Bqldv6
8izqAKCF7upvsj2Ej2VaqU/sM6u60amyiACfWGqD51k0zodsHWKTbRIIfbGVtFg=
=UeRu
-----END PGP SIGNATURE-----

--v1SbQ75auyyWu5ha--

