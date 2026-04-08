Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1753C1073C95
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 10:49:14 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.103403.1775645345534480862
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2026 03:49:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=PYNuwqkr;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 438E310D114;
	Wed,  8 Apr 2026 12:49:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775645343;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=kRbavymByG9QEbWQ7+QVqKLcpKSqp3NAVkmbpXKhtKM=;
	b=PYNuwqkrKN4ipbXdPkC++TP6IFuGgX4JVV8VJiE1k86lZRffgR4B1XKqdS29J2GFMx5EQO
	tG9cLSrw3fbOLsyV47pu1b+mI3vDa3Zmrtqf10OACcdz68Wxki4jTEkx2gls1xHQYjRSpt
	nw67aVOM4BMFcswf9kWamxx7HecTMw4sFgD1yWy5QcvJYKKWdDeAEFALjkeSIosoYxM1Wd
	C5+I0kso2Fwb5fKraZPUfD22T6hd0SDSIz8kNIwm8MuLZ8yrjLhfMe/iRSN/yAI+xLZ14q
	wLPuwtnwoin9pkFNKYKjWevBha8BARiVT+LmmaMVUvvrrshvrMazqEfrwe94hw==
Date: Wed, 8 Apr 2026 12:49:01 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/7] Add RZ/V2N TSU support
Message-ID: <adYynUqP_N4K2CfJ@duo.ucw.cz>
References: <20260408094150.66941-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uw5d9BwXuR4Hp6Js"
Content-Disposition: inline
In-Reply-To: <20260408094150.66941-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Apr 2026 10:49:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22654


--uw5d9BwXuR4Hp6Js
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds TSU support for the Renesas RZ/V2N SoC.
>=20
> All patches, except for patches 4/7 and 6/7, were cherry-picked
> from mainline kernel.
>=20
> The RZ/V2H binding patch (1/7) was missed during RZ/V2H TSU backporting,
> so it was added in this series.
>=20
> Patch 4/7 is needed to fix asynchronous aborts during unbind. See the MST=
OP
> series for more details:
> https://lore.kernel.org/cip-dev/20260115083451.1064048-1-claudiu.beznea.u=
j@bp.renesas.com/
>=20
> Patch 6/7 is a backport specific change that is needed to allow the
> thermal driver to read calibration data from the system controller.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--uw5d9BwXuR4Hp6Js
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCadYynQAKCRAw5/Bqldv6
8njhAKCpocdyX6vsNZUVP3/QJVyWNzAQZQCghUSy9ay7gAFJuvSsazzUQZwWOD8=
=JRx7
-----END PGP SIGNATURE-----

--uw5d9BwXuR4Hp6Js--

