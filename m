Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111D8C4452B
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 21:00:55 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33909.1784667645204526193
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2026 14:00:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Oi+GgP5K;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3DF211AB87;
	Tue, 21 Jul 2026 23:00:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784667642;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Hr/kueMwF9bTAQ9GsFGlo/5wXILC7Pys2LhJoQ7GI6o=;
	b=Oi+GgP5K0QXfcrvvwft9dSawcE/ZlE2ap1+HZ9LPI1KFYHK7u7/OCtLrkH9yprAwqbR9HB
	9F22Nu8LXm6Vx86Oc+MqT33bVlSnZfGRPKz7kH+m7c1/kSzGQ/usGpQF7eOIghjItILPrO
	1+MoPxyemYsgz6662Xfar90hxbtubh3k58iRjKCBn1eHvrd0FttBzxjNS0mzUrlUseRvHN
	ReXn+TdYwKmVBa4i4kbVAFyHHuRAcBt3DFnUXEZm46IazFQJrI6+c05uLRErgHbKjBXhCx
	9RMyuNiOnz2j4j7RoTzWRsS7aJKnCuGLURRFzaXhWJjei6OZ2oYN0nXHy2Bobg==
Date: Tue, 21 Jul 2026 23:00:37 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/23] Add p3t1085 and p3t1755 support
Message-ID: <al_d9d0ftOXSnuSW@duo.ucw.cz>
References: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AFXebp3AfarUHpzE"
Content-Disposition: inline
In-Reply-To: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2026 21:00:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23702


--AFXebp3AfarUHpzE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This series adds p3t1085 and p3t1755 i3c sensors support into linux-6.1.y-cip
> kernel.

Thank you, applied and pushed out.

Best regards,
									Pavel

--AFXebp3AfarUHpzE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCal/d9QAKCRAw5/Bqldv6
8u24AJ9rKeh6y7ItnAlsiNum0Vje9ueuIQCfdvyplbqF0h898JSDC7VX64hBSCI=
=UUDb
-----END PGP SIGNATURE-----

--AFXebp3AfarUHpzE--

