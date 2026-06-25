Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58931CDE008
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 10:58:20 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8883.1782385095868344577
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2026 03:58:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=VhqPIfwT;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 300FA117AF0;
	Thu, 25 Jun 2026 12:58:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782385093;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ArBXXNrofDhE/kARBx6I/eO8zAi18tyW+QiaxteF8kk=;
	b=VhqPIfwTGywuDT3D88OVxxp51BchgmPovpZX0G4UBA4KwOkfqAdBT3nwK3ZEJzwVx35qZR
	YlK0XRmJyXGQhNUGLzk3Hv52eTkQ6DEfyhxf2gIfBytlTKTm6US+C+I1tl6yP278G5IOzB
	YYqpFjdC9pHYu0fJyjX1OSuV3dAgyUhknfIh98fzTcUL0LxSDh3GZ8bAQSyOYRV6fROCdR
	sOaI9xjEbLhyhbi1aqtyf7GDpxP9wIJ35twxrA+Z/yRKtz0S2k3Nh39TotwljgZdRBIMMp
	gsUJ8xvXCHjmIQhZheE1mSFFjWKTnzP4bgwUAqPQXa7yuvndmUHzSY0i9eZlng==
Date: Thu, 25 Jun 2026 12:58:08 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/24] Add RSPI support for RZ/G3E SoC
Message-ID: <aj0JwEn8u2zUtM5c@duo.ucw.cz>
References: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hIHM19KU1vXORdi6"
Content-Disposition: inline
In-Reply-To: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2026 10:58:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23280


--hIHM19KU1vXORdi6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds RSPI support for the Renesas RZ/G3E SoC, which
> features three RSPI controllers. The series also enables DMA support in
> the RSPI driver, and backports the necessary infrastructure changes
> into linux-6.12.y-cip.
>=20
> The series is structured as follows:
>  - Clock entries for the three RSPI instances on RZ/G3E SoC
>  - DT binding updates: document DMA properties and add RZ/G3E compatible
>  - Device tree nodes for RZ/G3E RSPI controllers and SMARC board enableme=
nt
>  - Driver improvements backported from mainline: DMA support, device-mana=
ged
>   APIs, bug fixes for clock setup and FIFO thresholds

There will likely be some minor comments, but this looks okay to me, too.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--hIHM19KU1vXORdi6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaj0JwAAKCRAw5/Bqldv6
8pOiAKCP5gdPmeLaGX4rkizhe7rSw6QM9gCgmc0eeS8ni0nNNErPAP+PRVhSWMk=
=MzhU
-----END PGP SIGNATURE-----

--hIHM19KU1vXORdi6--

