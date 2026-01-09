Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5695D26D9A
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 19:42:11 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18321.1767987728297360520
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 11:42:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=DMk+dU8P;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E268A10D18C;
	Fri,  9 Jan 2026 20:42:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767987726;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=V6W6zKcyg+3hTFm5yrABfV9Ly141Xb5+Cp0fCHmEEDo=;
	b=DMk+dU8PmZL9FNqRWrF58khm3/K4ivcxNK5KRKSsssIkZZIj897nRCPZQFjl2r7EfjqLEw
	a/ZJyt0rz8Fp1bkZa637E/2aUv+0jIa8Z4v2yJ+QyKVpBBohihn3J3ldWeTySCsrGOiSKB
	9kPX+sVgCVR04Q4mExWskfAteUqujoGvelt3GyVZOPGCcvJs2II7aMovByO6Smpbuq3rQg
	7Iiy3q1n0jP7hMFetTT/guZk4L5gHerkn4UsnMYyH9/TRupsChkQ1TucEM4cInnhiKcjTX
	S3yN7VOmY7XAVv6yDgK+F1HBzTUmDWlv+mApa1quB25HUn5a3Y+yaQeZzi7/1A==
Date: Fri, 9 Jan 2026 20:42:04 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/8] Add RZ/V2H RTC support
Message-ID: <aWFaDNRAqAPLTf41@duo.ucw.cz>
References: <20260109121718.46056-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r9+nrA3qpp4zNFGG"
Content-Disposition: inline
In-Reply-To: <20260109121718.46056-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 19:42:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21527


--r9+nrA3qpp4zNFGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds RTC support for the Renesas RZ/V2H SoC.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--r9+nrA3qpp4zNFGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWFaDAAKCRAw5/Bqldv6
8hkVAJwMKuhfMorc0Wnr+st7ew1xKSAGGwCfXSUTmHUHNgto0SlKFIHcuB4lnUY=
=Klk6
-----END PGP SIGNATURE-----

--r9+nrA3qpp4zNFGG--

