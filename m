Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A850FD5329
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 09:53:00 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.92168.1772185978578889210
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Feb 2026 01:52:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=BPzMZYQE;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 85F211110B0;
	Fri, 27 Feb 2026 10:52:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772185975;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=t8NYe26QPKWT+0oVVUvx1AD95hUCZNPlDPoc3c6t93c=;
	b=BPzMZYQEHn4nFB1u35UfYD3i7TRK4Vzi3Ry7rNf2XNqS1MZV8+vi9qpek0CjucZnKTup89
	oTtkX0whTBBsAEWoM7oN3tL0COPLVDNhyqYVbYZMuduIYZMGQ+uSBxUAs2j/fWM57LN8aj
	cP5EIgrTEr2AeZXYg+lxftTca51VSFgnvkrpP0uZuX8LizuYOJTBTfzUepx5qFm627lu3Z
	iiRybLKm+a+t0e+iq1VmKWS4+BoRbFD0Niavs1jsCtNtem6NYtARHjTRz72aOmqJzWRJkn
	cu3pA/nt7wzX6hQo2LcxoWzU7L4MqBVHgS0oSrTiEqLGRyyJ8PuD41fZP3UY6A==
Date: Fri, 27 Feb 2026 10:52:52 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/8] RZ/G2L SSI Improvements
Message-ID: <aaFpdGfNb62Dddwb@duo.ucw.cz>
References: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="40/Yx0FYyUOVSUa3"
Content-Disposition: inline
In-Reply-To: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Feb 2026 09:53:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22023


--40/Yx0FYyUOVSUa3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Add support for 24, 32 bit sample format width. Also fix
> channel swap issue.

Similar to 5.10, this looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--40/Yx0FYyUOVSUa3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaaFpcwAKCRAw5/Bqldv6
8j0zAJ9rbSOJknWLVKgQK6Y4mVcXzgrC8gCeK/wH19U48TYqV9RCCB1QMUKDPPg=
=4krI
-----END PGP SIGNATURE-----

--40/Yx0FYyUOVSUa3--

