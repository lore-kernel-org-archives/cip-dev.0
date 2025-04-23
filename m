Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C633C369CB
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 19:17:07 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.3261.1745435819091341520
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 12:16:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=TAmQMi1A;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3DC92102A8CAA;
	Wed, 23 Apr 2025 21:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745435817; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IPmbUe7SVk9W4yyrOgBA5f2HcaN/Aevdh6eaf+jzVxI=;
	b=TAmQMi1ANbE8Z7Ur8dYyMTrz+PEEqx6kpSkbnzQXTg+Ner1cnGGZtyfxdcIS/GDlbX+k5c
	NzS72w3hLJrjLnCZ8hLPY3ZdDqd0fgJgKZ3rIdmYcE6JAp0deg+o8Q4YWyJVJRt37lD4sa
	d3q+DCkhRCTZWHxS88ifmE0nGNBX0R4powvNhasaCG1w7SwPiu6NerTdHgCmUPh2o1MiUh
	AvpVSxdsg+zyebO4y10S3dnTT4XOBD0hQjNE7Q4liSgm8HNrgt0wBwdT50i7FpM7Q/lpoY
	R2aORsaTce7l7mAlQG5VeyqywM5AewzKMyrC02JS4dEQ5KaTDyvpP1FcsOWyQQ==
Date: Wed, 23 Apr 2025 21:16:52 +0200
From: Pavel Machek <pavel@denx.de>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/10] Add SYS and OPP support to
 Renesas RZ/V2H(P) SoC
Message-ID: <aAk8pDwlVkFcrtkn@duo.ucw.cz>
References: <20250423181400.13960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5gA1DZaPNjl3KWQ2"
Content-Disposition: inline
In-Reply-To: <20250423181400.13960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 19:17:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18581


--5gA1DZaPNjl3KWQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add SYS support to RZ/V2H SoC.
> The base driver was first added to RZ/G3S and later extended to
> RZ/V2H SoC hence Ive included changes for RZ/G3S too. Alsong side
> added the clock and reset entries for SYS and GIC and added OPP
> table to the RZ/V2H SoC DTSI.
>=20
> Note,
> - All the patches have been cherry-picked from v6.15-rc3.
> - I plan to send similar patch series for v6.1-cip

I had one minor comment, but that should not affect merge. I can merge
this if it passes testing and there are not other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5gA1DZaPNjl3KWQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAk8pAAKCRAw5/Bqldv6
8qNcAJ0Ws3MD4GyaTmRMphRkMKQPQYZF6gCcDdYmYGNulqq+z8jCqBZcU1xhOEo=
=KEPY
-----END PGP SIGNATURE-----

--5gA1DZaPNjl3KWQ2--

