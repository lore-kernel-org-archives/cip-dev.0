Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6598D44C46
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 13:08:53 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35286.1768482525665145924
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 05:08:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=PpYlT6HU;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0009B10D66D;
	Thu, 15 Jan 2026 14:08:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768482523;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=0ZWVlZ/zZ3BOSUhcyYANjv2/aOsFyWhykNjFSyGIoY0=;
	b=PpYlT6HUcsSSrGBIr/M3IFS5LWDz58aaX6Oeh5TxIkGPxIhrvVIBC199z1M1iaIkkB1GyG
	V9238vP0Qah9InXBF3Of0zj/hevg+NaH6qEOy+kORqWqcFd43Vb2POXSNpBQrSbjCJVr6A
	qVbXcoHFydYiuT9kMpgEG688hP+s294rCXWuKGzJKuEgEoec8Vd9JOJSulXPn9XXDePUJN
	2cAuPKF6Wb8A4hUkr7X1/xh9oKHPy6L/ZiL3zn0ZqHBTLeLWRCBisnbLmE667MLKT9rKD8
	SGXnvCBTPAK4rHxzzc46pHDK+rYJBXj/fNftjQ41onpufTImaUUEASsxRlkAIA==
Date: Thu, 15 Jan 2026 14:08:39 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/4] Add RZ/V2N I2C support
Message-ID: <aWjm1902KAC3sQ9S@duo.ucw.cz>
References: <20260114125359.8668-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gErBi6Nws0D85ZF/"
Content-Disposition: inline
In-Reply-To: <20260114125359.8668-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 13:08:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21625


--gErBi6Nws0D85ZF/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds I2C support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

Thank you, applied.

Best regards,
							Pavel
--=20
In cooperation with Nabla.

--gErBi6Nws0D85ZF/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWjm1wAKCRAw5/Bqldv6
8ralAJ9YthzALafih1HOlW418AiBh4BOGQCgvwq6zZd0xyqLEKfeauENb89dcmo=
=Y7Su
-----END PGP SIGNATURE-----

--gErBi6Nws0D85ZF/--

