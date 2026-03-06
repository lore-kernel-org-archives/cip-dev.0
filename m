Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EA7F01835
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 13:22:58 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.68840.1772803374394838099
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 05:22:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Tbfz93Uj;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F0BF103E27;
	Fri,  6 Mar 2026 14:22:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772803371;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4voRX+mM1kTlUBmhGaMLBf7y0doyLHc4vt937fDkSr8=;
	b=Tbfz93UjI7UtaIsnFCC5uqkZk7qshncJZuvTjYVjNE1zx27xNibFpeBos2M9v2/0yItLSg
	9c2LSajgYLY6zt0u1FN0HMI/bjJlOxEAatVFDKdlosHc33mJ/Xp1jcw8J2EdDNs1g/ToSK
	nkUJTHaGCEonCBebCxW5S8niLddbtL+S6j/JFiCpG2mfHsly79NDbXI7oOGkuOkfUcyXf4
	zJPpnM1Nt+aYc22I9+0YNISQ7l+3hU4En/m9DqxJxMRPxdCy7kv6DkX4scy7+KNGVBxHaz
	zu3qwzL7p16Ng5pS2Fz1gyRogjLSqB8dEwggOKlFIrKVGTD0OqemfCibopZf4w==
Date: Fri, 6 Mar 2026 14:22:47 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 0/9] i3c: renesas: Add suspend/resume support
Message-ID: <aarVJ8MH8tL8Sf7X@duo.ucw.cz>
References: <20260303092140.12732-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jqma/4mV0sG9vZlp"
Content-Disposition: inline
In-Reply-To: <20260303092140.12732-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 13:22:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22101


--jqma/4mV0sG9vZlp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This series enable I3C on RZ/G3E SoM and adds suspend/resume support to the
> Renesas I3C controller driver into linux-cip-6.1.y.

Thank you, applied.

Best regards,
									Pavel

--jqma/4mV0sG9vZlp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaarVJwAKCRAw5/Bqldv6
8srNAJ9eJKqExr6cPN+NMSebm3Hki7C4BACfSUfKTq/If2YU+NBoz0d2nfzuubQ=
=OPQR
-----END PGP SIGNATURE-----

--jqma/4mV0sG9vZlp--

