Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217D7C44529
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 11:36:50 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20581.1784633801581423032
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2026 04:36:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=kSu8QKTX;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69A60119A88;
	Tue, 21 Jul 2026 13:36:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784633799;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=D1PLZlbcMAa6+doYJHS1w+/+ZzcOBBLyHmfO4LTJt5Q=;
	b=kSu8QKTXccX+4W4vz3JB95jgSRTcfdW5T3IDPOrAXqDJubujgKdo973kYDbNoXecT4VbR7
	z+T0GyS1uELOOx6D4Up2+XYaiFph0HmsZZMAChrJCPO9BmN0aCIZ1G4IYtd8dSdo5Qkz0C
	Q6aMIobLCtzZdFh8SwE0gv5duly0vPIw/kvnuBPiSddMVi/CTYXqawZLFRM14R1gRmconD
	qOgPxGFUVWEq9wAzb41CzuahLqG40zgGSx2fbimremSeWjXiGn2KtoGvS9ZouSZsW59RNQ
	teCUBX1NlIcwm+uBYiCWsdgW+lwMiytCuoP6+5IE3ld+hLim+FOHqgOhoc1HlA==
Date: Tue, 21 Jul 2026 13:36:34 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/15] Add p3t1085 and p3t1755 support
Message-ID: <al9ZwtMlj69yMUDl@duo.ucw.cz>
References: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MlUiHAiQg5iHDs3n"
Content-Disposition: inline
In-Reply-To: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2026 11:36:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23696


--MlUiHAiQg5iHDs3n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This series adds p3t1085 and p3t1755 i3c sensors support into linux-6.12.y-cip
> kernel.

Thank you, applied and pushed out.

Best regards,
								Pavel

--MlUiHAiQg5iHDs3n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCal9ZwgAKCRAw5/Bqldv6
8pqTAKCxnyDJmy0nCybZoTdrceL1S+NAWACfZKIJHOT1+/mzWwtYCA7Wr8q3kS8=
=neXy
-----END PGP SIGNATURE-----

--MlUiHAiQg5iHDs3n--

