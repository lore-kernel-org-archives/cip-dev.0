Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490E5C4450A
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 18:30:59 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1011.1784053849901313017
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jul 2026 11:30:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=FrHdHuuY;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 01EEC119C2F;
	Tue, 14 Jul 2026 20:30:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784053847;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=odsy4xtzDY72oic89BsflilQHrS5Ck+o/Se5D+vOems=;
	b=FrHdHuuYlxeIYQVmB1rT6RlrKq3BzfpqfYUmqDIt4i0aCgZSV1MMLp3nfEFfPuFb9WA00q
	I3P2CkgjYJd8UyzZIC8S+vAqfPpeob8sZGtrpBk2BmHvaA+xtzytfO0TJ2SXk7LPxi6zBD
	4GgC78HE3flEkH2Zn2jwcBm5txYKCNzpDThV6U2tDmpl6N+uTNdDSgQj0Ws1Qo6lNL6/mm
	HdkqcyQd3x1+JUZOf0KOT5aPTnIHLAsjttBNloPFghSHzM1CV+i2Xpl5/W08rS4Po6CV1q
	reyOwpNFil9G+Wuv0DzoWHbjumfWTh6X0ofmvIctVfZ/yp6uhccYNO0MPySj4w==
Date: Tue, 14 Jul 2026 20:30:45 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 0/3] arm64: dts: renesas: Add max-frequency to
 SDHI nodes
Message-ID: <alaAVY8bLYA6GDiE@duo.ucw.cz>
References: <20260714101836.8039-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5+0HJyyDisPfTEap"
Content-Disposition: inline
In-Reply-To: <20260714101836.8039-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Jul 2026 18:30:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23583


--5+0HJyyDisPfTEap
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

--5+0HJyyDisPfTEap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCalaAVQAKCRAw5/Bqldv6
8hxlAJ4sIquW/LzdIZwIxahmTohfspQbXACeK2EAT15uzjhvD86EPzfFKA1UVJE=
=qEVa
-----END PGP SIGNATURE-----

--5+0HJyyDisPfTEap--

