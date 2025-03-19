Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4E7C35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:28:30 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.4555.1742380106899225421
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:28:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=fu1IWjbs;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 61819101E91E6;
	Wed, 19 Mar 2025 11:28:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742380104; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=uNt0TzlSNWpmKrnVYcFZT0dsz8cMO01qk320CeMxw/Q=;
	b=fu1IWjbsrRPVKGXPAawq+9J2t6BJ0Y0+R82gkfMAgc9VE5reWBmcOVwJ0C/jyoD/wKlbDV
	kxZ84COi2JM5ZOEKRZjXu83lngO5yNomzWqjFiivN/m/6xGmIa216SiMAn8oDPvjpShHVj
	fK9z7UH0gGs81+F6ql5fNxUxca2gG4Z0diz9fyA9GzDRGNxODUNURV2+YekBwVmmp5K0uV
	Pwhgh9qfPrQs9xktklZBW4GzoLb3tQIeJMBP9v4J2VJ9mO0B0a0StsnpQ0F6rSjCo0zlM5
	BnxP1X5XYKMG+YoYxd/Q79hwMec3YVpZIKM0gYIFaYQObMTn+am0jWAa8bWn7g==
Date: Wed, 19 Mar 2025 11:28:20 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip v2 00/12] serial: sh-sci: Add support
 for RZ/G3E serial driver
Message-ID: <Z9qcRBPx38dI4QtV@duo.ucw.cz>
References: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
 <182E2D5440856AF6.20726@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r0iI+bgQFUhZnlAy"
Content-Disposition: inline
In-Reply-To: <182E2D5440856AF6.20726@lists.cip-project.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:28:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18276


--r0iI+bgQFUhZnlAy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This series add support for RZ/G3E SCIF interface to linux-6.1.y-cip ke=
rnel.
> > SCIF interface in Renesas RZ/G3E is similar to the one available in RZ/=
G2L.
> > This series add also some fixes found during SoC bring up stage.
> >=20
> > All patches are cherry-picked from mainline kernel.
>=20
> Okay, so I just reviewed v1 of this, and was ready to say that I'll
> apply it provided there are no other comments and it passes testing.
>=20
> Now you'll also have to tell me what is the difference between v1 and
> v2 :-).

Aha, missing SoB. I'd expect that information in 0/ of the series, but
you wrote it elsewhere. Still good.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--r0iI+bgQFUhZnlAy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9qcRAAKCRAw5/Bqldv6
8uopAKC8/dy+a1dviDoIDJm+LIGBkKMKowCcCbv15rEMFKf5sSPAwbjVhX8adyk=
=F7ic
-----END PGP SIGNATURE-----

--r0iI+bgQFUhZnlAy--

