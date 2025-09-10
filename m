Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972DECA101F
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 15:32:22 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.21781.1757518339517831409
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Sep 2025 08:32:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=OLuDYowm;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0E651038C108;
	Wed, 10 Sep 2025 17:32:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1757518337; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=lVcJ0Oxeb5c/dMz0MDXSJxS1EmSzuSfoRqm2lZ3XfhU=;
	b=OLuDYowmxgbf1+dtiYZaMrKAvFOEdWkanngheUjOGE/bsI29HhCZwxLuBUrBF6Z4wg9O7t
	xJZy167EY+tcpxi+t4UAtFb0tJ2r0Nv15H/qsTju0Cb0P5H2zk9OZUJAZ8aEzgxdH8MO4h
	W2lE/EqnuzGZfmXsZnVj58HVEgtJM2aj2tkg2QEu7crSNBcMe3cXRco4h9D3rGv5euWZ3N
	5mV9d1uRNlRUK0kU55sHyjjhkJo7fo+CQOI3kMH2l69/BhAN+NkfmHRAp6UaH+jZFm8N/z
	TfhJveqEKclyXANJUYQvDeRxvQbFcXysTBkvPEx56+4SWEWMF2YpNMu9wBXoQg==
Date: Wed, 10 Sep 2025 17:32:11 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg3s-smarc-som: Fix
 Ethernet aliases
Message-ID: <aMGZ+y/DTqGvFHcO@duo.ucw.cz>
References: <20250827035801.568246-1-claudiu.beznea.uj@bp.renesas.com>
 <20250827035801.568246-2-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xp4ZBZG+3JJ6ce2H"
Content-Disposition: inline
In-Reply-To: <20250827035801.568246-2-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Sep 2025 15:32:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20034


--Xp4ZBZG+3JJ6ce2H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit be4e4dd8a1994e5730dfdb8dfaf1f2418f8a199d upstream.
>=20
> Fix typos in the Ethernet aliases.  U-Boot uses the ethernetX (X=3D{0, 1,
> ..., N}) aliases to update the DTB with the MAC addresses.  The
> ethernetX or ethX aliases are not used by the Linux RAVB driver.

Thank you, applied.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Xp4ZBZG+3JJ6ce2H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaMGZ+wAKCRAw5/Bqldv6
8i2wAJwPxnX+Y8u3YaTYCOrdJzLvDrCxXQCgqUKn6sOswTfyrmqOtfZ+5eawq1E=
=5kR2
-----END PGP SIGNATURE-----

--Xp4ZBZG+3JJ6ce2H--

