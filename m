Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B722FC44501
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 10:32:20 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8742.1768991536614494877
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jan 2026 02:32:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=hIGnR8nL;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF96710EDE8;
	Wed, 21 Jan 2026 11:32:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768991534;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hAIrQhfxXwVJ23dS8TtxlT7wlBRCvGw9nmF4SohEZYk=;
	b=hIGnR8nL+KxzWmrA1Fa5Ve5U5B9lSOp6YQf6/Dl4KWQExU52iUUe3ONFtnLMCBfpv1KAyM
	/Rw7/Yy6bqOr+kV8bQTp9jlGdkUBMlS5aorCb7yojKJL9kiaR7I0lxfE6pse3Hq3WcYTJl
	rWeKdZS554wCfeLksrfWRxXzEmDUvDZoMTdMRPDjWpLpWrqS4OlPNszaYPH7/kwkypl3+/
	54a9j3QeONoFGObdz+zYlmefOYDchHdUskY1pUayTz0uVjs/FG9mZ2UXNmLGSa1doYfP2H
	e8u+BrIH06FbCHM768RJ0jSNdUPVflRebnJvPK6pL6OjJ3AATI0wWuI+v0h17w==
Date: Wed, 21 Jan 2026 11:32:09 +0100
From: Pavel Machek <pavel@nabladev.com>
To: uli@fpond.eu
Cc: claudiu beznea <claudiu.beznea@tuxon.dev>, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 6.12.y-cip v3 00/19] RZ/{G2L, G2LC, G2UL, G3S,
 Five, V2L}: Backport MSTOP support
Message-ID: <aXCrKeDCQcfKrZv1@duo.ucw.cz>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
 <1078868029.118356.1768880210995@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kAtMH9japIEppfdy"
Content-Disposition: inline
In-Reply-To: <1078868029.118356.1768880210995@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jan 2026 10:32:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21688


--kAtMH9japIEppfdy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Hi,
> >=20
> > Series backports the MSTOP (Module Stop) support for the Renesas
> > RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/G3S, RZ/Five, RZ/V2L SoCs.
>=20
> For the whole series:
> Reviewed-by: Ulrich Hecht <uli@fpond.eu>

Thank you, applied and pushed out. Could I get reviewed-by for 5.10
and 6.1 versions, too?

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--kAtMH9japIEppfdy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaXCrKQAKCRAw5/Bqldv6
8takAJ9I7U3oFQfL60afXYDHy9KSPd445QCfVjYy6K8uBu4DdML/7gzegsYsMeY=
=nyaz
-----END PGP SIGNATURE-----

--kAtMH9japIEppfdy--

