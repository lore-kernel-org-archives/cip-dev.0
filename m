Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C4CC369D5
	for <webhook@archiver.kernel.org>; Sun, 27 Apr 2025 08:45:17 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.23407.1745743384614064527
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 01:43:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Je0bDoFR;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CCCAF102A8CA4;
	Sun, 27 Apr 2025 10:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745743382; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=aSoTZhrXVp4afeH+r91xmjCLXOgcsUdjTA2W1iKwrGI=;
	b=Je0bDoFR1usXC3Nvu/R4BGh0HKFFS2QJqizETbI3nMP2kM2FdlbpPRRRYM76eH9Xcd4T2m
	kPEqo7osgVREOs2+rSGTsfSmAcIrjiiLYY3HjzhM3rKonEId8M9jLX1t+ErMI0ntQVqmzl
	t+RySqy6prKpgtzn1I3NCsIcT6iqrejysyoqvium181YJS0TvcNX3iNkmuBPSLHN+BXs6R
	XNQCWTr5V6fS8lYIaS6PAagbeDqi49aENroP444FRJ4a8oQSk5i6Y1Dj3lMf7N9Y8reNnv
	FJU1y8lG0ZAtgPaPWYbgYAhsMAyoDmfTc4fuHgJyxCPkA+jWD+kKlveljt7ftg==
Date: Sun, 27 Apr 2025 10:42:58 +0200
From: Pavel Machek <pavel@denx.de>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/21] Add SYSC/MMC/GTM driver
 support for Renesas RZ/V2H(P) SoC
Message-ID: <aA3uEsY33BwuBPLG@duo.ucw.cz>
References: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iS3oqc1McHKhOI2h"
Content-Disposition: inline
In-Reply-To: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 08:45:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18649


--iS3oqc1McHKhOI2h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add below driver support to
> Renesas RZ/V2H(P) SoC:
> - eMMC/SDHI
> - GTM
> - SYSC

Thanks, applied.

AFAICT we are now up-to-date with Renesas patches. It may be worth
testing, and if we forgot to apply something, let us know.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--iS3oqc1McHKhOI2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaA3uEgAKCRAw5/Bqldv6
8kYSAJ9kkV6HugSjkG7jwg1ziwBqpzSLhwCgmsnOL6SDBWXVx4QQECdXqp8cDgs=
=sN4r
-----END PGP SIGNATURE-----

--iS3oqc1McHKhOI2h--

