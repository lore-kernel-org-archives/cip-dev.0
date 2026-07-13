Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8F1C43458
	for <webhook@archiver.kernel.org>; Mon, 13 Jul 2026 21:13:25 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6258.1783977200173089322
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jul 2026 14:13:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=bz4LftyO;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E10A0119395;
	Mon, 13 Jul 2026 23:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1783977197;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=cv9t9IVjwbysHYwa2yBB84olFkEBKBOqYMtTc4yNTfU=;
	b=bz4LftyOr2EYcFpzZvEmHk6iG02gVet6Xa2hKqd72QY+qQhP9rMPINm8p8Y+GDUO2PP6gY
	5tVVoIlbxlY9mUfFOWZrczcdl4Qw0xNRM5iuXZfF9ySwS0vsZzkW6/smUVIN6uzn3CQDlM
	OcAVf6WN2u/r/aZVwmYh/Iro/0fRxaxzQagWFgG/IjtDDd/9MKBrl2fxKt4UP1KFAa0/Xt
	8CGaHV+wfVtJlLEM2IKrsJSoEsFP2Pc4MZANBWp9bPd5IDhPLQd3en7mCVIiDvx/0J+1dP
	pAPQ71Mfn3UrwJvUKhpCjjzKVKPyr9CHa0MKjGCR0NW3nG7eZ9Pv/Y3l7vEj/A==
Date: Mon, 13 Jul 2026 23:13:15 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/4] arm64: dts: renesas: Add max-frequency to
 SDHI nodes
Message-ID: <alVU63qWvQGTM7Xb@duo.ucw.cz>
References: <20260713120354.29288-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3/7rPgMUjP9vnq7b"
Content-Disposition: inline
In-Reply-To: <20260713120354.29288-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jul 2026 21:13:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23569


--3/7rPgMUjP9vnq7b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add the max-frequency property set to
> 133333333 Hz (133.33 MHz) to both SDHI0 and SDHI1 MMC controller nodes in
> the RZ/G2{L,LC,UL}/RZ/V2L device tree.
>=20
> This change results in approximately 33% performance improvement as
> it sets the SD clk to 100 MHz instead of the max 133 MHz.
>=20
> All the patches in this series are cherry-picked from mainline.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--3/7rPgMUjP9vnq7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCalVU6wAKCRAw5/Bqldv6
8v0pAKDBlv6EomI9BqJoWOh0WNvxR/5pJgCgoiUJvXHbHKGYXyvk6IMCwEthtzY=
=DTcx
-----END PGP SIGNATURE-----

--3/7rPgMUjP9vnq7b--

