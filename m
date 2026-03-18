Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DB510706E1
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 10:11:13 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10718.1773828671947357161
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2026 03:11:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=gv6ekHjA;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F0C310E417;
	Wed, 18 Mar 2026 11:11:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773828669;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=0mWoGtJulTDBnqFunZ8hoVmB4Yqbyb8Q2hCQSDNwfy8=;
	b=gv6ekHjALrW/pzfyFwDz9rKwN/T2PO1PsPGq3s/prcMUEhGGDru9Z570FxjtoxkUSFwFsP
	WftgNIJ9A1hQdNi1jm7hnYg81nbNxVU5fZeRKa+KgZp3tkEqD4jAU9dhaynld6E+VUKsDZ
	cxhbSBnBJO0hkiwVHiU0k+Wq5Y84pcx9YluuFqesLZPZhYfKMWzkCbaBCiM7ERIMFdgn+s
	mX+FeKFF2aRtwIox0FcWnxKDhT3vv1MUpbQj/OWSOrD+Va8VMnEPtDVlJvwYgZz+3YeM9K
	gUhGJHm/BgVW7Beyr9Ml4c6YLIaAuM6RdJkjNI3mYtxuE+4xuiX1qpJv9/peJw==
Date: Wed, 18 Mar 2026 11:11:04 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/11] Add Renesas RZ/G3E USB3.2 Gen1 Host
 Controller support
Message-ID: <abp6OA9YNPPSCOaq@duo.ucw.cz>
References: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wgjVy3pE2x9gTA69"
Content-Disposition: inline
In-Reply-To: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 10:11:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22499


--wgjVy3pE2x9gTA69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Hi All,
>=20
> Add Renesas RZ/G3E USB3.2 Gen1 Host Controller and PHY support. The
> USB3 HOST is compliant with the Universal Serial Bus 3.2
> Specification

I had some minor comments here, but those should be fixed in mainline,
first, so they should not block the merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--wgjVy3pE2x9gTA69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabp6OAAKCRAw5/Bqldv6
8j72AJ9KnJuvQt7p5nyDq9BfBmIZ8xJCqACgh8yZEb/RwHszbQUI9bKi1B6YPPE=
=nYi7
-----END PGP SIGNATURE-----

--wgjVy3pE2x9gTA69--

