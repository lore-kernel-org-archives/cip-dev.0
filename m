Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D772CFC27C
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 13:44:06 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11707.1763732638649213304
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Nov 2025 05:43:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=B4KT6SFq;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D46C310069484;
	Fri, 21 Nov 2025 14:43:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763732636; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=0LqjZr8Y1L0oSYtIQbtsG3F35RLV+pRqCAuBp3VJJEY=;
	b=B4KT6SFqp3ZiR12/Jg23ur0L8ArpYK9Humx0CuN2FLYrZCeRNi6SS9ZjMV8JC+pEm2ve1n
	1AGr8OhRUogN2oJvqKnwUZDCdYO2EoakUopaNAeVArSJGvyTwCWVm7kO8QX7S2p+nJaxaC
	UjjLtWND6xPlp1JAJZMq7tnjb9+19pewtHuY3gGGSSS8ZCGVUjqi0vc0BJqjzV+0wR5H1l
	9QMMF99ObMc1EENmXobZAkPG9MUMsXv4ybI9qigoIIYi9EMO2TjdlvVjkH3tD8SKQ1Abjr
	rELZr6NOj+VGQLTkF/XsOmqlgC5Wvv+r3jTvKHZ3RWpzzdJFHxiVvKFsJ/mEMg==
Date: Fri, 21 Nov 2025 14:43:51 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/22] RZ/{G2L, G2LC, G2UL, G3S,
 Five, V2L}: Backport MSTOP support
Message-ID: <aSBslxvWFIij/zGh@duo.ucw.cz>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
 <aQz1pgHaEQNgfdKa@duo.ucw.cz>
 <1875B18477989308.416970@lists.cip-project.org>
 <e4137de7-ef22-41ce-b2b5-a1d2762eeb4b@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qczAUIEFOQxYTRrn"
Content-Disposition: inline
In-Reply-To: <e4137de7-ef22-41ce-b2b5-a1d2762eeb4b@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 13:44:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20682


--qczAUIEFOQxYTRrn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > E.g. w/o MSTOP support, if a device is part of a clock PM domain, it us=
es
> > devm_pm_runtime_enable() in its driver, if stressing unbind/bind I can
> > reach the point where the rpm_idle() tries to runtime resume the device=
 (in
> > the unbind cleanup phase) while its clocks are not anymore part of its =
PM
> > domain. If the driver has it's own runtime PM APIs as well that tries to
> > access the IP registers, rpm_idle() will call driver RPM APIs and those
> > will fail because the clocks are no longer enabled though PM domain. The
> > issue is explained in the description of
> > https://lore.kernel.org/all/20251106081218.2574950-6-claudiu.beznea.uj@=
bp.renesas.com
> >=20
> >> Could it be done
> >> without changing semantics of existing functions?
> >=20
> > Other approaches I've tried on mainline are:
> >=20
> > 1/ open/close a devres group in bus drivers probe:
> > -
> > https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@b=
p.renesas.com

> One other solution would be to open a devres group in probe and close it =
on
> probe failure path and on remove. This will have to be done for each
> individual driver used by the RZ/{G2L, G2LC, G2UL, G3S, Five, V2L} SoCs.
> With this, patches 01-11 from this series will be dropped.

That looks like feasible solution to me.

> The scope of the devres group would be to track each devm_* calls for the
> device in question, starting from the point the devres group is opened,
> ending to the point where the devres is closed, something like below:
>=20
> ---| any devm_ calls are attached to the group X |------> time
>    ^                                             ^
>    |                                             |
>  open devres                                   close devres
>   group X                                       group X
>=20
> When the devres group will be closed, all the devm actions or reset
> callbacks (tracked from the moment the devres was opened) will be called.
>=20
> The devres group will be the last thing in the remove function and last
> thing on the failure path of the probe, thus the approach will change the
> drivers functionality in the way that all the drivers following this
> pattern will behave like their probe will use no devm_ helpers.
>=20
> I'm going to send a PoC patch for the media drivers used by the RZ/{G2L,
> G2LC, G2UL, V2L} SoCs in reply to this thread. Please let me know how do
> you consider this approach.

I'll take a look, but if mainline is happy, likely I'll be happy, too.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qczAUIEFOQxYTRrn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSBslwAKCRAw5/Bqldv6
8pGjAJ0cqwJ51W+dDyYCsCX4qkQivVYU7gCfUcbsIP1d7MG5G8+YqxIYMfSrfWI=
=ecWa
-----END PGP SIGNATURE-----

--qczAUIEFOQxYTRrn--

