Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4563E1077614
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 20:19:00 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23730.1773865138426563934
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2026 13:18:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=JPaQNhRc;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5250910D953;
	Wed, 18 Mar 2026 21:18:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773865135;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=GYRRs9oBgHMdjDoPRFlTYfuB1vuDtS7138AS0VffBrw=;
	b=JPaQNhRcSjQ+Z5k08Gx8+2zzRYSVWHsW5Szt3WPMHNk1IItQ5ECu0bmrpT68IbxqvDSpQG
	wz8jb+KqYEcUGyLZiT5jnnUQi2Ncc+ObVsCWAjrCqYQHrdwt19l5MPSqGCMXao6nRwSv/e
	KzvAcow7KYeAExtAMxMAz1Ha+iacdUynHWNywpYj0SKotUn4YICMkZEjTzVTWIWOwY77Dg
	gl7g4XlOVelpwD+pgL/VpJdRCcfmSH7yV259AXeph1IxyoqO/2p6k4PShDAfseE10ZJv2f
	+Lasj3rpQYq6ZlG4hhXTEwdvW5mNfWH0AxAoW+s0mWqj3RG5Dzewft0suovyrA==
Date: Wed, 18 Mar 2026 21:18:52 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/3] Add RZ/V2N DMAC support
Message-ID: <absIrGYqOEsFZjtj@duo.ucw.cz>
References: <20260316143417.76612-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DC8MLRY7n8D1ev5O"
Content-Disposition: inline
In-Reply-To: <20260316143417.76612-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 20:19:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22502


--DC8MLRY7n8D1ev5O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds DMAC support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

Thank you, applied.

Best regards,
							Pavel

--DC8MLRY7n8D1ev5O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabsIrAAKCRAw5/Bqldv6
8hUQAJ4uW99jZZgNMlAPXBIi+EyYZJzmHACeP/4KefZjy5dgCDfUrj/9uImFJLk=
=G/7R
-----END PGP SIGNATURE-----

--DC8MLRY7n8D1ev5O--

