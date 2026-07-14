Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721D3C44507
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 18:33:09 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1052.1784053986274566169
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jul 2026 11:33:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=VLTGtYyY;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 793B1119C63;
	Tue, 14 Jul 2026 20:33:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784053984;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4xgyiPHp+VHUbUYj78R+4WpyTQqVHAFqYy7573JZL+U=;
	b=VLTGtYyY9pzJ2ARa3iRsBAo/QbHgwVeLrIU41tN1E7hithUs6yHYAXRd0ETkAK+mt1Vurz
	cQIOguSDs/pEe4Q8nWaY7sihJGUJUp4pCeKupmoGGYO4x1IhBFg+PGR0oKj+P11JC+hLwK
	4yAdIssLMFJ5sZslIQqSz3Wi2adHPpk6C70Y0AySqNydHHw6eFdcyCiao1hXF7UMGwGGQe
	3sbrfETOUFLkmrzYGl53iUQSXLQqrlPziUpAsu4n/ULwKmTz1tPikcyYN+6JKTegn/1R6z
	ugXkZx+osaOE0rjFosQzPOoCevBaXmJXpQB/nzrbvr3Flimyxn3IB0EqtBIN9A==
Date: Tue, 14 Jul 2026 20:33:02 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju Das <biju.das.au@gmail.com>
Cc: Pavel Machek <pavel@nabladev.com>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/4] arm64: dts: renesas: Add max-frequency to
 SDHI nodes
Message-ID: <alaA3oqvxVUSfTRO@duo.ucw.cz>
References: <20260713120354.29288-1-biju.das.jz@bp.renesas.com>
 <alVT-m89Z6_dQcF4@duo.ucw.cz>
 <CADT+UeC0nu5trmwT7A-w6i99TRKV3q2+g702zCw0GOaZ5qA2hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pL0omoQrgajKQ1dg"
Content-Disposition: inline
In-Reply-To: <CADT+UeC0nu5trmwT7A-w6i99TRKV3q2+g702zCw0GOaZ5qA2hg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Jul 2026 18:33:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23584


--pL0omoQrgajKQ1dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series aims to add the max-frequency property set to
> > > 133333333 Hz (133.33 MHz) to both SDHI0 and SDHI1 MMC controller node=
s in
> > > the RZ/G2{L,LC,UL}/RZ/V2L device tree.
> > >
> > > This change results in approximately 33% performance improvement as
> > > it sets the SD clk to 100 MHz instead of the max 133 MHz.
> > >
> > > All the patches in this series are cherry-picked from mainline.
> >
> > Ok, so as I understand it, we don't need this for 6.1-cip and others,
> > because it is already in mainline 6.1, so no backport is needed.
>=20
> We recently (7.2-rc1) upstreamed this patch.
>=20
> Yesterday, a job in Lava setup showed the problem in 5.10-y cip. So,
> just to fix that issue, I sent these patches
> Soon I will be sending patches for  6.1 and 6.12-cip.

Aha, one of patches was older and that confused me.

So 6.1 and 6.12 versions are just performance improvements, and 5.10
fixes a bug, too?

Thanks and best regards,
								Pavel

--pL0omoQrgajKQ1dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCalaA3gAKCRAw5/Bqldv6
8irsAJ9JC6Paf9J5qL8nMOGVLrx2VvFX4wCcDK7vjbCVbt+sCoUlGJ/n836xnkI=
=zhmw
-----END PGP SIGNATURE-----

--pL0omoQrgajKQ1dg--

