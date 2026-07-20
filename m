Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A66C44529
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 20:14:34 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6751.1784578464533999592
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jul 2026 13:14:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Ga13Rdxl;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D198111A91F;
	Mon, 20 Jul 2026 22:14:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784578461;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4IvL0TwKJCNNQFJPmRklKb0KH+OtsVzMh6oIEU2VL/Q=;
	b=Ga13Rdxlau08Fd83D8ywJ/fSd2kQcX3uOTIJJwvyhBcafwNOXpkWVXN+3tC9Nv9zS9lSqt
	9L3FoWQ00mJ521VrB+JLIuN4NrGhO07Xl8v7YedganL7YeWlANEPSITuvXALkKiAV2cKcg
	edLLwmMZ/OsvLUa/dc7z7zSxOOqv1e7mu7yBTC5rQBUhKrMAU5Jm9RhDAh3fjszLDWma78
	gPhPKw72dHvtJ6RbjNg9aFx0mKrHAj5+kB1rhujzlqCjQMM4Oz5P85AsyvB9Q7CyKo+oyK
	CAwpIQszsgNxd898jnRzkF/RKJyOfvAMvVroONjJobIOwTedYGfbG8s25jQ9Rw==
Date: Mon, 20 Jul 2026 22:14:16 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/23] Add p3t1085 and p3t1755 support
Message-ID: <al6BmH9GeFHX1hoY@duo.ucw.cz>
References: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KdkNPuiPqzKhU0qJ"
Content-Disposition: inline
In-Reply-To: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 20:14:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23686


--KdkNPuiPqzKhU0qJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi!

> This series adds p3t1085 and p3t1755 i3c sensors support into linux-6.1.y-cip
> kernel.

I see support being added, but not being used. Could you provide some
background information?

Anyway, I'll have some minor comments here, but those should be fixed
in mainline, first, so they should not block the merge.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
									Pavel

--KdkNPuiPqzKhU0qJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCal6BmAAKCRAw5/Bqldv6
8jSmAKCLzVauabb+Qx4d4nEqWb42oie/kQCeLN+2UzkV18TvehFcuT+SW5UpDG8=
=WU1q
-----END PGP SIGNATURE-----

--KdkNPuiPqzKhU0qJ--

