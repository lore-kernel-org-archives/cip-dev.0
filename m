Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B25C55167
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 21:09:40 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.163.1785445763311415862
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2026 14:09:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=bFm5sS8A;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8770711B91F;
	Thu, 30 Jul 2026 23:09:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785445756;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=i2GTFhV25HKfzV9ny10UBOWEYyavjEpWTFcdDcFNY/Q=;
	b=bFm5sS8A21+E/ArMk4eY26vFMGEJpNjM7z27WOU+ZSSWvBHGeUKYbocs9177L0eyBa6C/M
	rNq46r30+zlhdACX2Ul62wdOmJJO5b3OCHXwugrJoh9ivSmXndXSHtL4gSYM0kGS5uo9yT
	C7qZoqxaQ4zoumZJ93kCNj1fuxd/98cc+UpuORHFMYS/pzn53MhofmtBJFR+fnCXeZTzbF
	6RU+4H8Nhg/7WAyFUWZYlZkPn+UTgO0t2mZoRZOLqaMhbgWbw11GjFWX/3w5c1MKky5Bak
	Wtk7p8hPdi/iYIzHWwuxjqJ47aShgrQ7k0e3K/Yzs32yti7/lQ/j4TwLRsWdpQ==
Date: Thu, 30 Jul 2026 23:09:13 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>, Ulrich Hecht <uli@fpond.eu>,
	Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: CVE-2026-64560
Message-ID: <amu9ef9UvmeIKKWN@duo.ucw.cz>
References: <4d61ec83-bb55-4c27-b370-0e2ed60bd800@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n7sejYSAq7z3m8cE"
Content-Disposition: inline
In-Reply-To: <4d61ec83-bb55-4c27-b370-0e2ed60bd800@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jul 2026 21:09:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23821


--n7sejYSAq7z3m8cE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> this looks like it does not need special drivers and is not that easy
> to mitigate (CONFIG_POSIX_TIMERS=3Dn...):
>=20
> https://git.kernel.org/pub/scm/linux/security/vulns.git/commit/?id=3D081d=
2ff9592751aa400828237f17c108e4e1f513
>=20
> Early releases?

No cool name, no logo, and no website? Aint doing no release for that!

So... this is crasher, and you need local access for it. In my eyes,
it is below "Dirty Cow" in severity.

https://lwn.net/Articles/1086226/

But this is 6.12.100. Something tells me 6.12.99 and .98 are fixing
similar issues. So... I guess we should investigate some more.

Best regards,
								Pavel


--n7sejYSAq7z3m8cE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCamu9eQAKCRAw5/Bqldv6
8sjMAKCW92hyUpSApRF2e1tpmZzj7xIFbQCgmTAPMMgqxDnvOqBLXBu2cJVZCPI=
=zCjf
-----END PGP SIGNATURE-----

--n7sejYSAq7z3m8cE--

