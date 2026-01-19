Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7441D29C3C
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 15:54:51 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38108.1768838083184426347
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 07:54:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=h2szv/B1;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0E2B106508;
	Mon, 19 Jan 2026 16:54:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768838081;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wDfxAzMhlPmPy9MjgyPZoTIxH0Musese/aqgOZBLCCA=;
	b=h2szv/B1JQMIJMcNJMtJDJ5rXtQ1+0RngK45RDE1/65zgh4BK6nr7eQzyLpJ5UAn2lydHw
	XvhnSrldphPhpYc3c6iHgNDpt1PKSFF5JvJNKb+JsM4feo1UKSuzk+cZpOD0oqTkgY+Qly
	lGqeqbXEGYnMxz+W6OvbwhscLhqaLr8RVUnk4LAfIX+D6IC3R7Duo0JWKAubnD6l5GO1UE
	wSuL9yAZRhI9Zq8avShmiCADBtT7TJmzhGKLk6ogJhI+eFzN+VURrDfJDDc8KMpRLfl/L9
	5AxDXaLV7LU77fjAH89lMOulCY7H2h8+dkOn4qSnM8eycZWYBknMmTytlj17+Q==
Date: Mon, 19 Jan 2026 16:54:39 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 0/5] Add RZ/V2N XSPI support
Message-ID: <aW5Tv2kw6k3mDA7C@duo.ucw.cz>
References: <20260119125403.32197-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sOZ1Q095Q7JHFsDu"
Content-Disposition: inline
In-Reply-To: <20260119125403.32197-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 15:54:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21672


--sOZ1Q095Q7JHFsDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds XSPI support for the Renesas RZ/V2N SoC and enables the
> MT25QU512ABB8E12 flash device used on the RZ/V2N EVK board.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--sOZ1Q095Q7JHFsDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaW5TvwAKCRAw5/Bqldv6
8mRqAJ48umgfzi00Ld1QmI1FCEZ+gGMd9wCdGiM6WJ2J25NO6Ax1yTkd49RL+yg=
=r5GY
-----END PGP SIGNATURE-----

--sOZ1Q095Q7JHFsDu--

