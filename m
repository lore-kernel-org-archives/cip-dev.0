Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326EAC36000
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 11:58:08 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.5648.1742471883712049899
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Mar 2025 04:58:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=MouqUsPr;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF55E101E90EB;
	Thu, 20 Mar 2025 12:57:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742471882; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UNh0Zh5qiQyJAKGbc0+zI/NyN0aaL6In+MqPVWzHq10=;
	b=MouqUsPrLqwPpjL/5P5L1nUg5cuxrhn4CVMbHOhyTMTvz1iJkox5iSvaMCx2iDFYju2Cy/
	xRvJrAVFFb7sbaR4OktDYl9F/1KTAOKSPV4VxwP8xkkNreDgcf/neX6SWzoEALu/cnIN3p
	CR2d5YBXEVjKSQMISWPfvj7A+Et3SwVNfOtIvamqXVjseD7wvCCQ01OzD1EWGsN3y66SJS
	C3wzqC6dBioXQlO28UYa76HqHnuwf88NQA2KxK9csj1yeP4Kfihq6tVB6293d65p1x5O3R
	mjrNO8BLsiJwXXNsmWHs5uDWUf+43EAditfBjL+Xbh5ey9Ad2Ti7wdVH3pKQBA==
Date: Thu, 20 Mar 2025 12:57:56 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, jan.kiszka@siemens.com,
	Chris.Paterson2@renesas.com
Subject: Re: [cip-dev] Starting 6.12-cip branch
Message-ID: <Z9wCxKLdYgsqDwM2@duo.ucw.cz>
References: <182E7EC480622B22.30505@lists.cip-project.org>
 <182E80640BDED660.30505@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZHCCq3KiCBGzJ4LH"
Content-Disposition: inline
In-Reply-To: <182E80640BDED660.30505@lists.cip-project.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 11:58:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18296


--ZHCCq3KiCBGzJ4LH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > So... I'm starting 6.12-cip branch. It is based on 6.12.19 and I
> > already pushed tree to kernel.org:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-6.12.y-cip
> >=20
> > Next steps should be starting testing the branch. Chris, could you
> > suggest appropriate gitlab-ci file? [Or even better, could we test the
> > branch without the gitlab-ci file, as we are doing for stable trees?]
> >=20
> > This error will need to be investigated:
> >=20
> > fatal: Not a valid commit name
> > be20a73e03e19005cfa5c1c4d6158af1ba02f056
>=20
> So we have this in our 6.1 tree:
>
> ?? > 24 be20a73e03e19005cfa5c1c4d6158af1ba02f056 db7542114675a85d50f8b41b=
9cf342df7d0a7bf6 clk: renesas: vbattb: Add VBATTB clock driver

> commit 39a7d6ce0283d0f2b7b5bec585a56954509a6103
> Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Date:   Fri Jan 24 10:59:57 2025 +0200
>=20
>     clk: renesas: vbattb: Add VBATTB clock driver
>    =20
>     commit be20a73e03e19005cfa5c1c4d6158af1ba02f056 upstream.
>=20
> But that upstream commit does not exist. I'll need to investigate
> more.

This seems to be commit 3b42450ce1771c7b11d8f3563f4bbfe9b8d26611
upstream. I picked that one.

> ?? > 34 bad201b2ac4e238c6d4b6966a220240e3861640c 8222bfe0e3fe1ffc98a6d8a8=
e49284b3bb2c3dad watchdog: rzg2l_wdt: Power on the watchdog domain in the r=
estart handler

This one was picked up by Sasha in commit

commit 486fc631cc499a16bbf38c0b383df2bb83b7e18d
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Date:   Tue Oct 15 19:47:32 2024 +0300

    watchdog: rzg2l_wdt: Power on the watchdog domain in the restart handler
   =20
    [ Upstream commit bad201b2ac4e238c6d4b6966a220240e3861640c ]

So no action required here.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ZHCCq3KiCBGzJ4LH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9wCxAAKCRAw5/Bqldv6
8uD4AKDCgOW8K2fwbk32udm4t+pPtldQSACeKI/aWeQ0XY2rGoc94+tnMXpHC7A=
=0mn8
-----END PGP SIGNATURE-----

--ZHCCq3KiCBGzJ4LH--

