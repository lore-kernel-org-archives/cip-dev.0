Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55803D2FEF8
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 22:30:31 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2107.1769553028647380900
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Jan 2026 14:30:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=cInYZlT6;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A9E510F57B;
	Tue, 27 Jan 2026 23:30:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1769553025;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vVZo3uVEFNZHly8xl3UPjFpbbkq64uP5TbkVVQxTN8U=;
	b=cInYZlT6tV9XPvYmcqzfRjkPGDHwx/wUaqWB+ooQ0sWXjSg8rWw8LWjK82341mdJG+TRuY
	no4VMPxCST7JkP4uPTmI3J3lJWuZptEqbGdII3Y7Dd34pBkwaAfEEB7NtjHqTr3uue+BS9
	yWuag/LEqhGleOBWruTYyeuFY36sHrF0bItsGorfYNRPnwz4VtLn2P0iJkuv+BtGuVPknX
	1DK1asTMxMraSTyBn7MONVJixfJcc6L00C9SDZDYbS2fpHvoDxzzyYzukWZyZ55j8llet0
	hs0sh+3a9l5UD5CWnTwI61Jplw2tYiHXIQTc9Ffqa34w0hDIsMO81sUWwLqTWg==
Date: Tue, 27 Jan 2026 23:30:21 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip v2 0/2] mmc: renesas_sdhi: Backport reset
 control
Message-ID: <aXk8fXVFlp36GMxt@duo.ucw.cz>
References: <20260127125723.3705611-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nDKZ9BS39crbhMOq"
Content-Disposition: inline
In-Reply-To: <20260127125723.3705611-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Jan 2026 22:30:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21729


--nDKZ9BS39crbhMOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series backports patches to control the reset signal of the Renesas
> SDHI IP during probe and suspend/resume.

Same as 6.12: looks good to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--nDKZ9BS39crbhMOq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaXk8fQAKCRAw5/Bqldv6
8oNYAJ9Y8iNXGEqD2TqXSdnO//SgJSXZsACbBAMvia+/P2PEdyvxKeTMcROPG8g=
=BSIo
-----END PGP SIGNATURE-----

--nDKZ9BS39crbhMOq--

