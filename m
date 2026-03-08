Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59704F55138
	for <webhook@archiver.kernel.org>; Sun,  8 Mar 2026 09:08:51 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31428.1772960924877752523
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Mar 2026 01:08:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=J9zPSyAo;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBE7D10BEBC;
	Sun,  8 Mar 2026 10:08:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772960922;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3jQ8ovm8WAjcYs3lMvKpwX8XbDQeNvPdlkqzL8Xr6zo=;
	b=J9zPSyAoTBLybvZFurSRZgARrIR8fEjff4L4Rc5pcWYGK3JPb8sXxpHCDLNcvy1QyvRjIn
	HTQqLB8t05dRP+EPQuZSQXcpqazKH0kkoS0pCCTYQY0Z1iP3eydF7gerWlTNFb4WKCKkWN
	hwQ83uWsg2Zk/42Y2JqZb6oWPN/x069rzaY0MLbQwped5ti/FlFaWLD4VH4q7n7zJGOYTW
	4HI+Vf1MxJFWQoD9NMsv9BbRTBrLu/IlxqsHtlk3PCTukurl9BZsJTji79b8xAzsYbaws9
	+s0gDOi+2DGQ9Uor68mY4eWaKFJcKZ3FexCuvrcAgmoZheBygO++xP7VDpXAfg==
Date: Sun, 8 Mar 2026 10:08:38 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 0/8] Add RZ/V2N display support
Message-ID: <aa08lrSNv73YF5th@duo.ucw.cz>
References: <20260305153624.19793-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cilLd7ueTQkouKMF"
Content-Disposition: inline
In-Reply-To: <20260305153624.19793-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 08 Mar 2026 09:08:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22147


--cilLd7ueTQkouKMF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds display support for the Renesas RZ/V2N SoC and EVK
> board.
>=20
> All patches were cherry-picked from mainline kernel.
>=20
> Note: This series depends on:
> https://lore.kernel.org/cip-dev/20260225121003.129467-1-ovidiu.panait.rb@=
renesas.com/

Thank you, applied.

Best regards,
								Pavel

--cilLd7ueTQkouKMF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaa08lgAKCRAw5/Bqldv6
8rJvAKCrY6/YoL5lw+38Q3G1bo6Mf4SzJACZAQAOay1uKeyLn4j+wQAc9eU312Q=
=HqcC
-----END PGP SIGNATURE-----

--cilLd7ueTQkouKMF--

