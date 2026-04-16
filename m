Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2CBF8D779
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 20:52:58 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26170.1776372771339770559
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 13:52:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=NAVWqCVM;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3500114132;
	Thu, 16 Apr 2026 22:52:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776372769;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=sEN/gNX35cZv6RMGcKJC7iRur22Gc5Nt70gXm4U+MUU=;
	b=NAVWqCVMAijhzGJRnFXt1HetM38x8HwIgJiOxXCwQIiQzfay2W20WQtzu9+8CUA1AnuLN4
	QCPqP1jBFcabYFujv7ODpfrXHIwjf7CQwy1KIbj/u5+DMGBFpWOwHokKfkge3ZMnPRoMP0
	CXjDnQjgZBA6zZL5wKA6+e+oUbTt41cMjHPYLBCD2g2Qoi9N4jSgFIYnRGP/SFMywow43E
	MYN1YvqNtn0cuUNd9H7ZAU+cWMqjha5vRbSfL0KWhlTN2/i3g0g7t4Gc5LCbxhwyWiHh8v
	dw0E+pWZP25aZR3echiKN1Q3R93H9v4qAXj7/cpU9D3CnGLPWE2IkxIAJnO/8w==
Date: Thu, 16 Apr 2026 22:52:47 +0200
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/8] Add RSPI support for RZ/V2H and
 RZ/V2N
Message-ID: <aeFMHzrKwjPxRe0t@duo.ucw.cz>
References: <20260415131919.95486-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m5CNOb0c6hb+MBxV"
Content-Disposition: inline
In-Reply-To: <20260415131919.95486-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 20:52:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22751


--m5CNOb0c6hb+MBxV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds RSPI support for the Renesas RZ/V2H and RZ/V2N SoCs.
>=20
> Patches were cherry-picked from mainline kernel.

I had some minor comments here, but those should be fixed in mainline,
first, so they should not block the merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--m5CNOb0c6hb+MBxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaeFMHwAKCRAw5/Bqldv6
8t1YAJ9VXTZowOPivB5TtvyjrON03Pz4KgCeLVGUeu8hDjmmhCPlngI579hK4T4=
=USex
-----END PGP SIGNATURE-----

--m5CNOb0c6hb+MBxV--

