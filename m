Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECF9FD5333
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 10:08:20 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.92341.1772186891493466096
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Feb 2026 02:08:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Nz7k9MPQ;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 78506103D5E;
	Fri, 27 Feb 2026 11:08:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772186889;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dIq6xjV4SaNgUOevsk1agAna7VzWOVv8Z7oL8p6on5Q=;
	b=Nz7k9MPQZ27gKk9cqzX+ul7Fbc6SEvcHFoSVTksdwEE/9RBpomi1WSzL0WFUtepfTYBmY/
	Uzn+r8MYuW2Eai3lFkupoYyDg47NE4bM63gu9hDyyG6aHpfG+84xxvRG8G+zr7sNbTJ+Bj
	vwM0T8mOoYwimtVFyJ7rufiqCONADQADRWINEgIVkeloV2Ec/VnhPpR6aHrGv+mahMOf4N
	B7UbcadXScTJfg6tKJrSSgm4oM3c4lXRi1x2R0oA2hq2c18/2aBwonJJC5puyyioE8rsx5
	7d8l1VqcmfMWLHuqrDH5ymNfTlLfObvnvj8NXQWpFqjYq+dpym86uYvk8EMeDw==
Date: Fri, 27 Feb 2026 11:08:07 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 00/25] Add RZ/V2H display support
Message-ID: <aaFtB8hn3Zy5CMNA@duo.ucw.cz>
References: <20260225121003.129467-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6kqladoeZCIPWfYz"
Content-Disposition: inline
In-Reply-To: <20260225121003.129467-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Feb 2026 10:08:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22027


--6kqladoeZCIPWfYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds display support for the Renesas RZ/V2H SoC and EVK board.
>=20
> All patches were cherry-picked from mainline kernel.

So we have mHz, Hz and kHz in the same series. I would not mind if we
could be more consistent with units here.

But those are minor comments here and might be fixed in mainline,
first, so they should not block the merge.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel


--6kqladoeZCIPWfYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaaFtBwAKCRAw5/Bqldv6
8mmeAJ951zPtRc7ehJglsDC4uzrO+wjr2gCeOVXII748O01BhZPOJwC92O4sGSQ=
=p+AJ
-----END PGP SIGNATURE-----

--6kqladoeZCIPWfYz--

