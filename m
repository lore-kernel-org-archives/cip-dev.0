Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427B7CD5BD0
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 21:15:43 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31033.1779916540304322304
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 14:15:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=iTZgquB4;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B54EC1169FD;
	Wed, 27 May 2026 23:15:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779916538;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wFINagLLPIQmNNeFTLq9d1lV/XWwAd53yKpqmQ9mX/0=;
	b=iTZgquB4Z7j9Q5fiU1FOgwgE9Wiy9+IxQbZvD5WNzyzJKWTqwEmA4Qjp+iuEdJ/ONJlMQy
	I2sHjPHAeFCTDuE4kI1zvK74N2Jtnj8E60Spot4pPvkhFaaR5lGeNdll9Y/N2JIEqESXjr
	VTxB6D1UZzCQIRmhhfHMEiE6xvN+U+y2DCycDavj3ZIk6oJzBeFjLLOVn0Sp/OUSg1CBC4
	rqBZZt4eUIGOTdSs4CyecVRg0at1+NaPUFoLqi6c2qMSL/n7x+kbE9Ajbdm+7F9yc5yUps
	/pz9lMyug91HjKdE402C+XQYS3K7Q3srIycAg/cv5+iXQGziqtRtUm0SfFvVqg==
Date: Wed, 27 May 2026 23:15:36 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/9] i2c: riic: Driver enhancements
Message-ID: <ahde-JBeE7BGLuJh@duo.ucw.cz>
References: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zi9OysRgaeeIAG0N"
Content-Disposition: inline
In-Reply-To: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 21:15:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23027


--zi9OysRgaeeIAG0N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add I2C bus recovery support to the Renesas
> RIIC driver. Along with adding I2C bus recovery trivial cleanup patches=
=E2=80=8B
> have also been backported.
>=20
> All the patches have been cherry-picked from the upstream kernel.

This looks okay to me. Do you plan to do more backports to 5.10?

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--zi9OysRgaeeIAG0N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCahde+AAKCRAw5/Bqldv6
8hCvAJ9BlbMM4dkO0pqVvN7xN4JQSv5NkwCgmeuqPlnGCQgnA+Ub2JRkIC36FgE=
=yC6H
-----END PGP SIGNATURE-----

--zi9OysRgaeeIAG0N--

