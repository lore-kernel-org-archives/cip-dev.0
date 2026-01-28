Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D4DD46BF7
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 19:35:54 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3342.1769628947182850437
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 11:35:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Fdcz8g7j;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6FF4F10EBBC;
	Wed, 28 Jan 2026 20:35:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1769628944;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=lRwhmbil46htNCeJxJFxLRBupujbxa0RYlfel11iaco=;
	b=Fdcz8g7jlYeMa4NKAB94csCHvt3XIkbolSTpuL1K3aAPnV7y7yKmHRcleYzWUZYJME2FQF
	1fBr3f1d1R57MJHpdAf0poQSrLdDqk0tFWJ0nr2mY6yOQsGMQ4HjhVFesb2zLoGnkC7pru
	uhKfV1bsuNYy4ZIR0Vu1j5talPwVITajBYJjg2whpQtOeHO1mBBPxNC+wa/fRtJnwawzG8
	H8+Jv7ZcWBKx9qBfcjQG9J/P/Nk/R0K5qcYtQrcptlvq8y2Z5Nory+I5eE9A7Cmlya4NPC
	9oGHBwegLI5o4KQCpI6hzP1XsEA9FFxg3XFSwCA8iYsBbG63QaPE6qYQPa6BuA==
Date: Wed, 28 Jan 2026 20:35:39 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 0/4] Add RZ/G3E DMAC support
Message-ID: <aXplC3yG/9jWolPQ@duo.ucw.cz>
References: <20260128155940.1445842-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FjlU6KDSOJwubYG6"
Content-Disposition: inline
In-Reply-To: <20260128155940.1445842-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 19:35:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21779


--FjlU6KDSOJwubYG6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds DMAC support for the Renesas RZ/G3E SoC into linux-cip
> 6.1.y-cip kernel. Backported also commit
> e57389d5547ee24b472ac5c8f8a7dc21b063ad73 upstream on top of this series.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--FjlU6KDSOJwubYG6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaXplCwAKCRAw5/Bqldv6
8sfuAJ90XjzEM1fxWtA5Ub649NTFFEdOaACgjgaLu3GLWwPF+R8UA6wH6SvNwBY=
=XiO5
-----END PGP SIGNATURE-----

--FjlU6KDSOJwubYG6--

