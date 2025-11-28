Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20B5D116F3
	for <webhook@archiver.kernel.org>; Fri, 28 Nov 2025 12:02:39 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14444.1764331349795986405
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Nov 2025 04:02:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=NsFSgZ7h;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4650101D52A3;
	Fri, 28 Nov 2025 13:02:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764331347; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BkfgZj20K//BgCTgiYEZOD+kQ462Me8fZrHE14nUwoQ=;
	b=NsFSgZ7hp0qk+oxaofWTljwp7aFh6GQNNwldb0alTbnGUgP+VoWbb3NBWQdlX3PA7jL+oA
	EMX/QSHNeXJIas8Kk9ZBqolZolBw18bxEL1HAhFp8TzzOmCAk+KjBJe1VU5ZlCRLrvX8Dk
	u/ohx71sv5YwcfZal7uU1pTkVhUEXdHqmWAOfDyeC8DfBEcWpUKw7sqGpS5Ssg0bW73p/x
	J6A1eX/8eJihsTy1kgWiXNN8iaiCW+0m6c2q+fZm7TV8N4HH+KZCVd6CQdKdieW5UpLldh
	PQ1aLuzzDqSuS5KdpsyyyoawQI/l7GNzA8WpCYxu+heu5koo0zsR3BhbiKnKyQ==
Date: Fri, 28 Nov 2025 13:02:15 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 00/22] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}:
 Backport MSTOP support
Message-ID: <aSmPR2lrojvlkjpW@duo.ucw.cz>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KIhGNLRDWht7f2eZ"
Content-Disposition: inline
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Nov 2025 12:02:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20765


--KIhGNLRDWht7f2eZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the MSTOP (Module Stop) support for the Renesas
> RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/G3S, RZ/Five, RZ/V2L SoCs.
>=20
> The purpose of MSTOP is to reduce power consumption by stopping
> unnecessary module's functions.
>=20
> If any master accesses a module that has the clock stopped and the
> MSTOP bit set, a bus error will occur.
>=20
> Due to this, to avoid CPU generating synchronous aborts, changes
> to PM domain specific code were needed. The changes backported in
> this series were adjusted to be executed only for the above
> mentioned Renesas SoCs.
>=20
> Please share your thoughts on this approach.

Ok, so after IRC meeting, I went through the patches again, but I
guess I'll need some more help.

03/22] PM: domains: Add helper to check for PM domain detach on unbind

This one is not mainline, and is only non-mainline patch around,
correct?

 05/22] driver core: platform: Drop dev_pm_domain_detach() call
 06/22] mmc: sdio: Drop dev_pm_domain_detach() call
 07/22] spi: Drop dev_pm_domain_detach() call
 08/22] rpmsg: core: Drop dev_pm_domain_detach() call
 09/22] soundwire: bus: Drop dev_pm_domain_detach() call
 10/22] serdev: Drop dev_pm_domain_detach() call
 11/22] i2c: core: Drop dev_pm_domain_detach() call

These are good cleanups, but are they neccessary for your goals? (Are
you using rpmsg?) Could we get rid of some or all of these?

22/22] clk: renesas: r9a07g04[34]: Use tabs instead of spaces

This one is certainly not neccessary.

Thanks and best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--KIhGNLRDWht7f2eZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSmPRwAKCRAw5/Bqldv6
8gKIAKChSQPmWJonCMLHYOQudP+cy6CDiACfTDLVbUWu4r9lixZyLyvw8Q3zJqo=
=NISX
-----END PGP SIGNATURE-----

--KIhGNLRDWht7f2eZ--

