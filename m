Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81397C88E4A
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 10:12:27 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35931.1789121541161958083
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 03:12:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=eOl/wdLy;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE4821032E5;
	Fri, 11 Sep 2026 12:12:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789121535;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OLDABUosJb+pG9WL1z9PThthzltL9W6o01IARixFg7c=;
	b=eOl/wdLySFnds3bRa4Y9WR3ATh8+O9iErdkTrtsfCh1ujfvBNXDkv6aot/TGP5zsNj1z4R
	04HfYPXO0bO8U5dkDpltwZIv1jFjqPuSAnNaFhDGrtpYuoa5uI77POOr3nExWnwZDnXN0e
	yUYHvUzvcfM/BFbRjm5puHuvRkjvfnYm8eHNMLh8hMalxZ5Fv+4xeZX5JcUj7+RDcHlKYP
	3tM6K3Hnf1Erq0aWSGzz8FJubsSZyNCPb1HZcvzJ1aWzT02PQpx2HiAw4WLBTYS/xload0
	1Vz3ZY7ztrDRHypJPYHGKBHKPGHyykSufT5GObezdTY6xvBuA0IClPSPSYlzWQ==
Date: Fri, 11 Sep 2026 12:12:13 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 0/8] Add DMAC support for RZ/{T2H,N2H} SoCs
Message-ID: <aqPT_RBxXJlRX4co@duo.ucw.cz>
References: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LM61cHDJDnnjjZod"
Content-Disposition: inline
In-Reply-To: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 10:12:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24128


--LM61cHDJDnnjjZod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This patch series aims to add DMAC support to RZ/T2H and RZ/N2H
> SoCs. All the patches have been cherry-picked from upstream kernel.

I had a minor comments here, but that should be fixed in mainline,
first.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--LM61cHDJDnnjjZod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaqPT/QAKCRAw5/Bqldv6
8hbyAJ9OdgQVI5Sz/5bvXeeaWsem1M3OZgCgwnMKRLBvHrw3cS6v64vXEljmXEE=
=/FCO
-----END PGP SIGNATURE-----

--LM61cHDJDnnjjZod--

