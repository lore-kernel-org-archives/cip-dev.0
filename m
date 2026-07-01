Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CCCC43458
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 10:45:08 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42130.1782902704715447410
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Jul 2026 03:45:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=HHtdIEEp;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 545F1117A83;
	Wed,  1 Jul 2026 12:45:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782902702;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=AmGhCeYMJh+kbAFLbbsSUSvXPAuKRyxnydbYfzboEKo=;
	b=HHtdIEEpi2xjsp2nNQ54gXtONwt7lPgkzNBPfY/R4lbej/t9+fNdL5z7JFMolDPHjuuEQG
	oMvernZaPShwiw/IbWw1GBI+Ajp0hfED1S0W0Dew05CpClJ8GavefnJomy+fqxj35HRRY/
	l0dewS9CEgJZCJWGnsCqRFRY59v134N6xR5E2Rf8LLm0snKeHdMmaH326oAUFYo833BWCC
	XnCBzWSFbdeffyh17bgQZ31UAGFsSIPuvpvakMxFjglqne7S4r4c9HU3elYymi6Qi+0auu
	De0SEW1kGn/9eUAAU7E+hpVR0RGqTDbjGv4tbxqmAnmNcbPxWctdD76rvzUC6Q==
Date: Wed, 1 Jul 2026 12:45:01 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 00/39] Add RZ/G3L SMARC EVK support
Message-ID: <akTvrRZXQHsC6Nqj@duo.ucw.cz>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="heEPNI4jxi1EiQD3"
Content-Disposition: inline
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Jul 2026 10:45:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23367


--heEPNI4jxi1EiQD3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This patch series add minimal boot support for RZ/G3L SMARC EVK. All patches
> in this series are cherry-picked from mainline.

(I assume similar support for 6.1 and older is not being prepared?)

Best regards,
									Pavel

--heEPNI4jxi1EiQD3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCakTvrQAKCRAw5/Bqldv6
8iQZAJ9/XCyId6uLgWR5V5Gqyi0+KDvIIgCfYukIlHF67GLigZWdvc80WiDrMpA=
=YS+0
-----END PGP SIGNATURE-----

--heEPNI4jxi1EiQD3--

