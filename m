Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD004C4450A
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 07:56:54 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7741.1784188605248693456
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 00:56:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=I09LcbRa;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC16911A001;
	Thu, 16 Jul 2026 09:56:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784188603;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=X9S9J8Z4AMBoeIlduNLJEFsp2XFrebbs0K1xNGYpC+Q=;
	b=I09LcbRaUxBGZgPAvQZ5GmVqLorZsKKhQKIQ1S/gQNUrwXyGCTlkJYNoPGNL38qnaghCn8
	qPwkCXRn/XKu7duyVBLD6Ml6DHB8rYDPx1/LMzX2Pcq6WQjwOYoqmRXA+sGrJAAJOsR0y0
	79PkBRXnYS/vUBBkW3t1eKrCBW+E8UXyOqm2w0ozo78Kjx0xqyKovmStjV5CDzoXpBcSb/
	2rQasY2fjTJBMy01TCPS1hHj94LMj8taafgEIJJT/+DOGn6aww1d9xD0QDSBcxdS4QIRiS
	gZ5NhEBP5X/lbliA6Wty3zgsTpOR0gqsW837h4cKTLUZrWuZuEf96jCV9Cm6ZQ==
Date: Thu, 16 Jul 2026 09:56:41 +0200
From: Pavel Machek <pavel@nabladev.com>
To: pavel@nabladev.com
Cc: Biju <biju.das.au@gmail.com>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/23] Add support for RZ/G3L
 pincontrol
Message-ID: <aliOuduY4Em7AIBQ@duo.ucw.cz>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
 <18C26F8AB223D098.2287905@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bYI7lU59k/eFamj"
Content-Disposition: inline
In-Reply-To: <18C26F8AB223D098.2287905@lists.cip-project.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 07:56:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23610


--4bYI7lU59k/eFamj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to add pinctrl driver support for RZ/G3L SoC.
> >=20
> > All the patches from this series are cherry-picked from mainline except
> > the patch for dropping "syscon" fallback compatible from sysc/sys
> > nodes from RZ/G3S, RZ/G3E, RZ/V2H and RZ/V2N to match with the
> > documentation after backporting the commit ba5095ebbc7a ("mfd: syscon:
> > Allow syscon nodes without a "syscon" compatible") to 6.12.y-cip.
>=20
> I had some minor comments here, but those should be fixed in mainline,
> first, so they should not block the merge.

Aha, as noticed in patch 02/23 by Iwamatsu-san, this is actually wrong
backport, not mainline problem.

So can I ask for v2 of this, with=20

> Reviewed-by: Pavel Machek <pavel@nabladev.com>

added?

Thanks and best regards,
								Pavel

--4bYI7lU59k/eFamj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaliOuQAKCRAw5/Bqldv6
8iooAKCgfEQ2RqGyjOBVDlNG/aS38gWGKwCcC1AGBx/UDZMFB1UaqUQI/S85Uo4=
=CYpe
-----END PGP SIGNATURE-----

--4bYI7lU59k/eFamj--

