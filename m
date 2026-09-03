Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3220C61DD3
	for <webhook@archiver.kernel.org>; Thu,  3 Sep 2026 19:31:37 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27.1788463887314293007
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2026 12:31:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=H50vl8dM;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5648C11AA2F;
	Thu, 03 Sep 2026 21:31:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788463880;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=babTFPqydd+pemeNhfQjWN2JQ7n41pWC5shX0w+utro=;
	b=H50vl8dMK5jLQSwW+WQ38F+m3WwJEEuzEFkoXpnyf8xKA2r5G/S5GWOrf5/OFQ0ba1a4wd
	yX0tu2Xg3VDcTGV5iU+nDPOmYaC6zV0pLr1PavtIVS8J4lndGNfWtZSPlpRC4OcHMbACky
	UfwwTrQG4EEAB+LcmkFF3bGPo80PYHGNXIqODL8wrRWPUOJSlOg+I96p2RWRBzs88yaxNA
	D/m9TKwCgvOIL+mYU08lrEXHcQlNQY6nc4PNOFVhbD39UEoZeyADB/9NNsJgC6q3bW9GPx
	dY7iLoBmDSRvvxF7rcUrqjL+9ii5gK5sjRTI1QIB7BDtqS8xBE2b9Z2sJ1pnwg==
Date: Thu, 3 Sep 2026 21:31:16 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 00/11] Add ICU error and software interrupt
 support for RZ/V2H and RZ/V2N
Message-ID: <apnLBGWeIWKIWJM0@duo.ucw.cz>
References: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PprUnFxRaT5Ty4Li"
Content-Disposition: inline
In-Reply-To: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Sep 2026 19:31:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24091


--PprUnFxRaT5Ty4Li
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi!

> This series adds support for error and software interrupts in the ICU
> driver for the Renesas RZ/V2H and RZ/V2N SoCs.
>=20
> Patches were cherry-picked from mainline kernel.

Thank you, applied.

Best regards,
								Pavel

--PprUnFxRaT5Ty4Li
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCapnLBAAKCRAw5/Bqldv6
8ld4AJ4lSuTzT0ZFoQXqh/kaKjf+5iaOUwCcD+AWDRc2mGJ4AI+SMKwn0khdKvY=
=Fh/U
-----END PGP SIGNATURE-----

--PprUnFxRaT5Ty4Li--

