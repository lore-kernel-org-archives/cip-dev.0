Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3A5D29C3F
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 16:00:41 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38242.1768838439824689293
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 08:00:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Rtl1Kxdh;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C92E3108861;
	Mon, 19 Jan 2026 17:00:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768838437;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=bazmbvxSBJxqA05vXNjpNbF6DSjQbY7VzXnThRfavSQ=;
	b=Rtl1KxdhQXjxhq7UJPpcvkBNxcosfUkpmD+3pqDo5hgGwmtXb/S0cduSoF+yEY0Dx93JGW
	oEre6tgX7ghGcn6cks4HEhUnSfiOdarzI/ESXPg0u9pDxDnyf4ghgceskjNnRjZMZcPBen
	Et9NuTkFsUUCk12rT+6w7QxOV9NBI4t7He4adr2UcKmKPGAE6VXqlk2+6e6esb4hhC+865
	o9/N/vpUKez1rfrnFwEEv/H+ipAXPXtVeTrPZpj7ofnPpJv4QCDMCXtL1qq81Y7vN2hXRq
	N+I1OsdgmRPfO5MJYWicKJmonrTUzpyYjPpylHvfsSGnmKLOoz2w8PF3xKsWew==
Date: Mon, 19 Jan 2026 17:00:34 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/6] Add RZ/V2N USB2.0 support
Message-ID: <aW5VIp5PQdEvoR8S@duo.ucw.cz>
References: <20260119125147.32175-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0qM7tQvVmX6q2zX/"
Content-Disposition: inline
In-Reply-To: <20260119125147.32175-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 16:00:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21673


--0qM7tQvVmX6q2zX/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds USB2.0 support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--0qM7tQvVmX6q2zX/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaW5VIgAKCRAw5/Bqldv6
8ijNAJ9HcO/ThBECrtt0I/sZFF3BmctsSgCdHv19FxXlyI+/02R9tfXYThjbXf4=
=K9eQ
-----END PGP SIGNATURE-----

--0qM7tQvVmX6q2zX/--

