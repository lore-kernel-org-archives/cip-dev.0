Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2EECD6133
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 19:52:42 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.73106.1696881158621024189
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Oct 2023 12:52:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 27C251C006C; Mon,  9 Oct 2023 21:52:37 +0200 (CEST)
Date: Mon, 9 Oct 2023 21:52:36 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Looney Tunables aka CVE-2023-4911 aka setuid bad
Message-ID: <ZSRaBPRKFGq+ukSO@duo.ucw.cz>
References: <178C8824ABC80843.5378@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rSDSaRyCebLqj709"
Content-Disposition: inline
In-Reply-To: <178C8824ABC80843.5378@lists.cip-project.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 19:52:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13335


--rSDSaRyCebLqj709
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> There seeems to be libc problem with setuid binaries.
>=20
> https://www.bleepingcomputer.com/news/security/new-looney-tunables-linux-=
bug-gives-root-on-major-distros/
> https://access.redhat.com/security/cve/cve-2023-4911
>=20
> It has a name, so it must be serious :-).
>=20
> Ok, so you should not give shell access to untrusted users and you
> should not have setuid binaries. But world is complex, so maybe you
> know of project that is affected.

Fix does not seem to be too bad:

https://sourceware.org/git/?p=3Dglibc.git;a=3Dpatch;h=3D1056e5b4c3f2d90ed2b=
4a55f96add28da2f4c8fa

 elf/dl-tunables.c             | 17 +++++++++-------

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--rSDSaRyCebLqj709
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZSRaBAAKCRAw5/Bqldv6
8iSMAJ4vW8JNrKSQShAqxtGEbwhPe4vMIQCgm0VsR88XTuRp8LjNLbt7kHuFUeA=
=UH2W
-----END PGP SIGNATURE-----

--rSDSaRyCebLqj709--

