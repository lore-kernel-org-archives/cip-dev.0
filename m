Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A687610D14A3
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 11:18:43 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48955.1774869521110296015
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Mar 2026 04:18:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=EunhaRKe;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6898410B9D7;
	Mon, 30 Mar 2026 13:18:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774869518;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ZT4Q5CxHYLXzgwK1Y+7Xpjjd6aTSfzkLu8ADKz3cs4Y=;
	b=EunhaRKeg81ClZLZcTJGE5bOxk6vjlMLdUlIe8bGY7Wyxhrogc+s2smv7qawnnKRuvkZRk
	CnT12vYad6cbMIl7CiiUJu+nDTHwwV+rBN1WQ+7F8O7q+YHdb2hiWTGnvw5gg30imYGsWA
	eLjaMboJUGoS3g8DdX5dwxyBaOtsgqY91t3DHNoMWy69v4FYsS609omKF7nNrXDT2ai91+
	05wpiikOkYAQu1uGufW8JyTeaxiivH00yDKGR4bUQYY9Vzzy2/lvmQ9sBUboQ646/ccbyh
	xLCvosluNCxh9s8PmWkvViVQybsXm+mdgiaex2gTi4l8Z+Cnfl9Ou8ItzRXnvA==
Date: Mon, 30 Mar 2026 13:18:34 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/39] Add Renesas RZ/G3E RSCI support
Message-ID: <acpcChgY6z5s-Z2A@duo.ucw.cz>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mpl+OPUacaLu99qe"
Content-Disposition: inline
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Mar 2026 11:18:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22606


--mpl+OPUacaLu99qe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Hi All,
>=20
> Add RZ/G3E RSCI support for FIFO and non-FIFO mode. RSCI IP found on
> RZ/G3E SoC is similar to one on RZ/T2H, but has 32-stage fifo. RZ/G3E has
> 6 clocks (5 module clocks + 1 external clock) compared to 3 clocks
> (2 module clocks + 1 external clock) on RZ/T2H, and it has multiple
> resets. It has 6 irqs compared to 4 on RZ/T2H. Add support for the hardwa=
re
> flow control.
>=20
> The device RZ/T2H is not present in 6.1, so squashed all the binding
> patches into single commit that document RZ/G3E RSCI.
>=20
> The set_rtrg() uses field_prep() and later replaced by PREP_MODIFY
> But field_prep() not present in 6.1. So squashed the commit.
>=20
> Replaced kfifo_*()->uart_circ_*() in rsci_transmit_chars() to make
> similar implementation with sci_transmit_chars() for fixing tx issue
> with 6.1 kernel.

I will have some minor comments here, but those should be fixed in
mainline, first, so they should not block the merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel

--mpl+OPUacaLu99qe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCacpcCgAKCRAw5/Bqldv6
8inUAKCMG1P2rpCZvUtCdqmKkYDRQG3vTACfXrDy1hbZd7fiN3LvcMoIBMRFfTg=
=uyHp
-----END PGP SIGNATURE-----

--mpl+OPUacaLu99qe--

