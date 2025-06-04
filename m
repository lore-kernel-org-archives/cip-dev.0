Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84658C5B543
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 18:14:15 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.23785.1749060850028646795
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 11:14:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=ej7eBOHQ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1FDAB10397298;
	Wed,  4 Jun 2025 20:14:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1749060848;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=hr7vL61ygYB+/fgD78wlFHFffBLwGQbPSTYl+gZ0Ny0=;
	b=ej7eBOHQ2BayqFKnQYzoVWkcVvBhSR2igu7fhRDPsWQV83lm2yYoDoIUGyYDVKc0gy4yhk
	dunMkVmRFIlvmk5jh0faaiER9CCOoko0i1Pzrc0ge5qNXNuq8shYlAamnwFeBid7DhJ/6S
	nVpd/KZV8Q2v3UKiV0TVYLCiF0PVISxrlZp3Zqb4e0ZbtcV3ND2VWSW65TJNAv6uucn5Up
	OVScmbodoFcrMJkh9zTop09P+Frp49zzZYuaYiiSNcfBkB1Wx3fdDJzyM4HVgh39ZOBZXu
	E2ksss8hSw4KKujmmlBpxqxjxLyx2tMIdnqrJ4Eb+28lLaRvcQmhK9wuchLFjw==
Date: Wed, 4 Jun 2025 20:14:04 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>, nobuhiro1.iwamatsu@toshiba.co.jp,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 6.1.y-cip v2 0/8] RZ/G3S: Backport SCIF support
Message-ID: <aECM7FjBzfyiV16G@duo.ucw.cz>
References: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
 <1845E5BCD79BC526.5711@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LJwB70s6TgcOZ9AT"
Content-Disposition: inline
In-Reply-To: <1845E5BCD79BC526.5711@lists.cip-project.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 18:14:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19014


--LJwB70s6TgcOZ9AT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Changes in v2:
> > - fixed build error by dropping overlay in patch 8/8
> >
>=20
> Looks good to me. Both me and Iwamatsu-san already reviewed this, so I
> guess I'll just apply this with his reviewed-by if it passses testing.

I applied the series now.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LJwB70s6TgcOZ9AT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaECM7AAKCRAw5/Bqldv6
8qlvAKCSz46NLKskuHrVuZ0aqb4dloZhMgCfWG4ZsB+Bc8G8jPa3/Q9D9cZARsg=
=SmBW
-----END PGP SIGNATURE-----

--LJwB70s6TgcOZ9AT--

