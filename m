Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21458C282DE
	for <webhook@archiver.kernel.org>; Sun, 16 Mar 2025 19:14:04 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.35576.1742152439344414446
 for <cip-dev@lists.cip-project.org>;
 Sun, 16 Mar 2025 12:14:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=JYKr21U4;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC32A103D1FFE;
	Sun, 16 Mar 2025 20:13:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742152436; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=GqwfqdcSrlphHQo+lmtm0dj/9yDJ4KMNSxD0Tgar2II=;
	b=JYKr21U4g9TNCzT8f3IlyOORn8j5HjFh3tWNGcKSOtu+t2a5tO8TFZsCI+IRf4nl0LzolY
	E/RZIfh6czOJNRfq8zXJKctbSxRRHL1QcFJdSyCb8JhlcdyBECXevJnSAid2vbGQUumrFE
	QnScMHxj+79Cum7T6fe3ntT5ZCviiF9vH7zmiPVdzLY2Jzrh9/v/rGTqeGXsn6sfpvQCnI
	q+3MarUYAsQ/ku1xR+zogr4YxPu1SjKk/8+j/XELnPv9GFLn3mPs1QjQMTWTQm1LbAB1xW
	aP6KuSlH3Gjz+y9vBRLWhyrKBEI6R/lfUjBZSLY9jWAeLi2fqQjVOZGMGHPbSw==
Date: Sun, 16 Mar 2025 20:13:50 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/85] soc: renesas: Add RZ/G3E support
Message-ID: <Z9ci7jj/Dne7qADQ@duo.ucw.cz>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <Z9K4sW1iyC+0lJCg@duo.ucw.cz>
 <Z9LHJC92Bp3HxjT2@tom-desktop>
 <Z9P/qUzPfn368iGo@duo.ucw.cz>
 <Z9QTPtKb5Y3E3vqP@tom-desktop>
 <Z9QVjxYJH4OSm0sP@tom-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t59aZezAqZeeKzkW"
Content-Disposition: inline
In-Reply-To: <Z9QVjxYJH4OSm0sP@tom-desktop>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 16 Mar 2025 19:14:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18219


--t59aZezAqZeeKzkW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > What is relation between RZ/G3E and rzg2l? Because early patches seem
> > > to be for rzg2l support, not RZ/G3E. Splitting those preparations up
> > > would be good.
> >=20
> > Thanks for your comment.
> >=20
> > RZ/G3E and RZ/G2L SoC have some similar IP's.
>=20
> Sorry, to be more precise:=20
> RZ/G3E, RZ/V2H and RZ/G2L SoC have some similar IP's.

Thank you. One day I'd like to understand that naming scheme and how
different SoCs are related to each other.

> > Fully agree.
> > I will split backporting in smaller patchset as you suggested.
> > Thanks.

Thank you. I went through the series up-to 23 or so, and it looked
mostly good.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--t59aZezAqZeeKzkW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9ci7gAKCRAw5/Bqldv6
8pFlAKCxHdaIzygchnrK44rCaGR901dccgCgqISzuoArAy3X9R4WjAAPcoTVKhE=
=YGCA
-----END PGP SIGNATURE-----

--t59aZezAqZeeKzkW--

