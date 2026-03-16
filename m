Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21008F013D2
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 08:38:15 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46059.1773650284963870450
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 01:38:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=NpC0bDKH;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5CD6510D21F;
	Mon, 16 Mar 2026 09:38:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773650282; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=EHKYfFxMTBkwxIawHKoVItBIGjlX6HwMWX6T5Wh57mY=;
	b=NpC0bDKHg81V1W1fbtNeei+Fm7x2nMf+rCnbRdKeq4pxBJhHx5BMEVtmBGQLCFX1J9HhP1
	O1d/AY7jN61c4aC/1CG6KnxHjqefoFRy6iXOt6AHAFzXImtn0m7to+BUwfx939fYxmvpHa
	EyohRGIvtWzD+F0GFMpMm1wMdvOP21b40+jaTZt+oEnd+9+II2sWZF1aqCChguSn4tW+Ar
	hmQeo7Fsy1QQ5IcC5CST3JR9xe9GxQuEirz8R1o1LAfAB0vBht3mxcOcoyEmcvQk3R8Gad
	+wn7ppYoubCI4MDfHNZebRawGzry7OTjAUwzi4+8C5QHgvX38/C9s7ofTZJQxQ==
Date: Mon, 16 Mar 2026 09:37:59 +0100
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v5.10.251-cip70-rt31 (rt146)
Message-ID: <abfBZ8yV0zv3c1dy@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OCzGA770yLYq22Tk"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 08:38:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22375


--OCzGA770yLYq22Tk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--OCzGA770yLYq22Tk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabfBZwAKCRAw5/Bqldv6
8oPRAKC0UTUIEr67ln18b8ia++a6aPh5AwCfRnKFHmd1ChFwzn8eR7JU7frsxAc=
=jc7g
-----END PGP SIGNATURE-----

--OCzGA770yLYq22Tk--

